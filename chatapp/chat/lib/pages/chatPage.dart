import 'package:chat/component/chatbuble.dart';
import 'package:chat/component/component.dart';
import 'package:chat/models/messagem.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chat/component/Constant.dart';

class chatPage extends StatelessWidget {
  chatPage({super.key});

  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy('timAt', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //         print(snapshot.data!.docs[0]['message']);
            List<messagemod> messagelist = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagelist.add(messagemod.formjson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: kPrimeryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/scholar.png',
                      height: 50,
                    ),
                    Text('chat'),
                  ],
                ),
                // centerTitle: true,
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagelist.length,
                      itemBuilder: (context, index) {
                        return messagelist[index].id == email
                            ? chatbuble(messagem: messagelist[index])
                            : chatbubleforfriend(
                                messagem: messagelist[index],
                              );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        messages.add({
                          'message': value,
                          'timAt': DateTime.now(),
                          'id': email
                        });
                        controller.clear();
                        _controller.animateTo(0,
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn);
                      },
                      decoration: InputDecoration(
                          hintText: 'send a message',
                          suffixIcon: Icon(Icons.send),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: kPrimeryColor),
                              borderRadius: BorderRadius.circular(16))),
                    ),
                  )
                ],
              ),
            );
          } else {
            return Text('loading..........');
          }
          // print(
          //     "==============${snapshot.data!.docs[0]['message']}=================");
        });
  }
}
