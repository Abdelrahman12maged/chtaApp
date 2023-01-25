import 'package:chat/component/Constant.dart';
import 'package:chat/component/component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class login extends StatefulWidget {
  login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool isload = false;
  String? email, password;
  GlobalKey<FormState> formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isload,
      child: Scaffold(
        backgroundColor: kPrimeryColor,
        body: Form(
          key: formkey,
          child: ListView(children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset('assets/images/scholar.png'),
                  Text(
                    'ScholarChat',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico'),
                  ),
                  SizedBox(
                    height: 80,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'LOGIN',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  defaultTextform(
                      onchang: (data) {
                        email = data;
                      },
                      type: TextInputType.emailAddress,
                      label: 'Email',
                      prefix: Icons.email,
                      colorenable: Color.fromARGB(255, 19, 110, 152),
                      colorfocus: Colors.white),
                  SizedBox(
                    height: 20,
                  ),
                  defaultTextform(
                      onchang: (data) {
                        password = data;
                      },
                      type: TextInputType.emailAddress,
                      label: 'Password',
                      prefix: Icons.lock,
                      obsecure: true,
                      colorenable: Color.fromARGB(255, 19, 110, 152),
                      colorfocus: Colors.white),
                  SizedBox(
                    height: 20,
                  ),
                  defaultButton(
                      function: () async {
                        if (formkey.currentState!.validate()) {
                          isload = true;
                          setState(() {});

                          try {
                            await loginUser();
                            Navigator.pushNamed(context, "cahtpage",
                                arguments: email);
                            showSnackbar(
                                context: context, message: 'success register');
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              showSnackbar(
                                  context: context, message: 'user not found');
                            } else if (e.code == 'wrong-password') {
                              showSnackbar(
                                  context: context, message: 'password wrong');
                            }
                          } catch (e) {
                            showSnackbar(
                                context: context,
                                message: 'there was an error');
                          }
                          isload = false;
                          setState(() {});
                        } else {}
                      },
                      text: "login",
                      background: Colors.white),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "dont have an account? ",
                        style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 224, 78, 81)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, "register");
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future<void> loginUser() async {
    UserCredential user = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email!, password: password!);
  }
}
