// ignore_for_file: must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';

class CustomPasswordInput extends StatefulWidget {
  final String labelText;
  TextEditingController controller;
  CustomPasswordInput(
      {super.key, required this.labelText, required this.controller});
  @override
  State<CustomPasswordInput> createState() => _CustomPasswordInputState();
}

class _CustomPasswordInputState extends State<CustomPasswordInput> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: hidePassword,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
          suffixIcon: hidePassword
              ? IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      hidePassword = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      hidePassword = true;
                    });
                  },
                ),
          border: OutlineInputBorder(),
          labelText: widget.labelText),
    );
  }
}
