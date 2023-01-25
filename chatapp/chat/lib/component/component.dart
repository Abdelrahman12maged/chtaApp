import 'package:flutter/material.dart';

Widget defaultButton(
        {double width = double.infinity,
        Color background = Colors.blue,
        required VoidCallback function,
        required String text}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          "$text",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
Widget defaultTextform(
        {TextEditingController? controller,
        required TextInputType type,

        //   String? validate(String? String)?,
        required String? label,
        required IconData prefix,
        bool isclick = true,
        bool obsecure = false,
        required Color colorenable,
        required Color colorfocus,
        VoidCallback? ontap,
        Function(String)? onchang}) =>
    TextFormField(
      obscureText: obsecure,
      onChanged: onchang,
      onTap: ontap,
      controller: controller,
      keyboardType: type,
      validator: (value) {
        if (value!.isEmpty) {
          return 'failed requiired';
        }
      },
      decoration: InputDecoration(
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: colorenable,
          ),
        ),
        prefixIcon: Icon(prefix),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: colorfocus)),
        enabled: isclick,
      ),
    );

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar(
        {required context, required String message}) =>
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
