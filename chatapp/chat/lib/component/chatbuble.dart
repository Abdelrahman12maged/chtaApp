import 'package:chat/models/messagem.dart';
import 'package:flutter/material.dart';
import 'package:chat/component/Constant.dart';

class chatbuble extends StatelessWidget {
  chatbuble({
    required this.messagem,
    Key? key,
  }) : super(key: key);
  final messagemod messagem;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomRight: Radius.circular(32),
          ),
          color: kPrimeryColor,
        ),
        child: Text(messagem.message),
      ),
    );
  }
}

class chatbubleforfriend extends StatelessWidget {
  chatbubleforfriend({
    required this.messagem,
    Key? key,
  }) : super(key: key);
  final messagemod messagem;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.only(left: 16, top: 32, bottom: 32, right: 32),
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
            bottomLeft: Radius.circular(32),
          ),
          color: Color(0xff006D84),
        ),
        child: Text(
          messagem.message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
