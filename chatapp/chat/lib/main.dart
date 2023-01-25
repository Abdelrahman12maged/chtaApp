import 'package:chat/pages/Registeration.dart';
import 'package:chat/pages/chatPage.dart';
import 'package:chat/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScholarChat());
}

class ScholarChat extends StatelessWidget {
  ScholarChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Register(),
      routes: {
        'login': (context) => login(),
        'register': (context) => Register(),
        'cahtpage': (context) => chatPage()
        //      ChatPage.id : (context) => ChatPage()
      },
    );
  }
}
