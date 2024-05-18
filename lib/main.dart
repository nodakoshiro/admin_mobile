import 'package:admin_mobile/import.dart';

void main() {
  runApp(const MaterialApp(home: WordBook()));
}

class WordBook extends StatefulWidget {
  const WordBook({super.key});

  @override
  State<WordBook> createState() => _WordBookState();
}

class _WordBookState extends State<WordBook> {
  // DatabaseHelper クラスのインスタンス取得
  final dbHelper = DatabaseHelper.instance;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  late ListModel<Vocabulary> _list;
  late Vocabulary? _selectedItem;

  @override
  void initState() {
    super.initState();

    //testdata
    var testdata = <Vocabulary>[
      Vocabulary(index: 0, front: "hana", back: "1", memo: "memo"),
      Vocabulary(index: 1, front: "dur", back: "2", memo: "memo")
    ];

    _list = ListModel<Vocabulary>(
      listKey: _listKey,
      initialItems: testdata,
      removedItemBuilder: _buildRemovedItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('AnimatedList'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add_circle),
            tooltip: 'insert a new item',
            onPressed: () {
              showCreateModel(context, insert);
            },
          ),
          IconButton(
            icon: const Icon(Icons.remove_circle),
            tooltip: 'remove the selected item',
            onPressed: remove,
          ),
        ],
      ),
      body: Row(
        children: [
          const SideNavigation(),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: AnimatedList(
              key: _listKey,
              initialItemCount: _list.length,
              itemBuilder: _buildItem,
            ),
          ),
        ],
      ),
    ));
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      index: index,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }

  /// The builder function used to build items that have been removed.
  ///
  /// Used to build an item after it has been removed from the list. This method
  /// is needed because a removed item remains visible until its animation has
  /// completed (even though it's gone as far as this ListModel is concerned).
  /// The widget will be used by the [AnimatedListState.removeItem] method's
  /// [AnimatedRemovedItemBuilder] parameter.
  Widget _buildRemovedItem(
      Vocabulary item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      index: item.index,
      item: item,
    );
  }

  // Insert the "next item" into the list model.
  void insert(Vocabulary vocabulary) {
    final int index =
        _selectedItem == null ? _list.length : _list.indexOf(_selectedItem!);
    vocabulary.index = index;
    _list.insert(index, vocabulary);
  }

  // Remove the selected item from the list model.
  void remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem!));
      setState(() {
        _selectedItem = null;
      });
    }
  }
}

typedef RemovedItemBuilder<T> = Widget Function(
    T item, BuildContext context, Animation<double> animation);

/// Keeps a Dart [List] in sync with an [AnimatedList].
///
/// The [insert] and [removeAt] methods apply to both the internal list and
/// the animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that
/// mutate the list must make the same changes to the animated list in terms
/// of [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class ListModel<E> {
  ListModel({
    required this.listKey,
    required this.removedItemBuilder,
    Iterable<E>? initialItems,
  }) : _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final RemovedItemBuilder<E> removedItemBuilder;
  final List<E> _items;

  AnimatedListState? get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList!.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList!.removeItem(
        index,
        (BuildContext context, Animation<double> animation) {
          return removedItemBuilder(removedItem, context, animation);
        },
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}
