import 'package:chat/component/Constant.dart';
import 'package:chat/component/component.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Register extends StatefulWidget {
  Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? email;

  String? password;

  bool isload = false;

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
                  Image.asset('assets/images/scholar.png'),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'ScholarChat',
                    style: TextStyle(
                        fontSize: 32,
                        color: Colors.white,
                        fontFamily: 'pacifico'),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 32,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
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
                            await registerUser();
                            Navigator.pushNamed(context, "login");
                            showSnackbar(
                                context: context, message: 'success register');
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              showSnackbar(
                                  context: context, message: 'weak password');
                            } else if (e.code == 'email-already-in-use') {
                              showSnackbar(
                                  context: context,
                                  message: 'email already exist');
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
                      text: "Register",
                      background: Colors.white),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text(
                        "if you have an account ",
                        style: TextStyle(
                            fontSize: 17,
                            color: Color.fromARGB(255, 224, 78, 81)),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'login',
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

  Future<void> registerUser() async {
    UserCredential user = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email!, password: password!);
  }
}
