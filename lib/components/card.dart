import 'package:admin_mobile/import.dart';

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value.
///
/// The text is displayed in bright green if [selected] is
/// true. This widget's height is based on the [animation] parameter, it
/// varies from 0 to 128 as the animation varies from 0.0 to 1.0.
class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    this.onTap,
    this.selected = false,
    required this.animation, //ok
    required this.item, //ok
    required this.index, //ok
  }) : assert(index >= 0);

  final Animation<double> animation;
  final VoidCallback? onTap;
  final int index;
  final Vocabulary item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headlineMedium!;
    if (selected) {
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    }
    return Padding(
        padding: const EdgeInsets.all(2.0),
        child: SizeTransition(
            sizeFactor: animation,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onTap,
              child: SizedBox(
                height: 150.0,
                child: Card(
                  color: colorPrimary,
                  child: Center(
                    child: Card(
                      elevation: 8,
                      shadowColor: Colors.grey,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          ListTile(
                            leading: ClipOval(
                              child: Container(
                                color: colorPrimary,
                                width: 48,
                                height: 48,
                                child: Center(
                                  child: Text(
                                    item.front.substring(0, 1),
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 24),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(item.front),
                            subtitle: const Text('2 min ago'),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 72),
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: colorPrimary, width: 4),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Flexible(child: Text(item.front)),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          color: colorPrimary, width: 2),
                                    ),
                                  ),
                                  child: Text(
                                    item.back,
                                    style: const TextStyle(
                                        color: Colors.blueAccent),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: colorNegative,
                                    ),
                                    onPressed: () {},
                                    child: Text(item.front),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      foregroundColor: colorPositive,
                                      backgroundColor:
                                          colorPositive.withOpacity(0.2),
                                    ),
                                    onPressed: () {},
                                    child: Text(item.memo),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )));
  }
}
