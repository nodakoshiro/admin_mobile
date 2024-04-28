import 'package:admin_mobile/import.dart';

final _formKey = GlobalKey<FormState>();
TextEditingController front = TextEditingController();
TextEditingController back = TextEditingController();
TextEditingController memo = TextEditingController();

showCreateModel(
        BuildContext context, void Function(Vocabulary vocablary) insert) =>
    (showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: 500,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Column(children: [
                    TextFormField(
                      controller: front,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'おもて',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '何か文字を入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: back,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'うら',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '何か文字を入力してください';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: memo,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelText: 'メモ',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '何か文字を入力してください';
                        }
                        return null;
                      },
                    )
                  ])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Text('終了'),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ElevatedButton(
                            onPressed: () {
                              // バリデーションメソッドを用いてバリデーションをかける↓
                              if (_formKey.currentState!.validate()) {
                                var vocablary = Vocabulary(
                                    index: 0,
                                    front: front.text,
                                    back: back.text,
                                    memo: memo.text);
                                insert(vocablary);
                              }
                            },
                            child: const Text("登録"),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    ));
