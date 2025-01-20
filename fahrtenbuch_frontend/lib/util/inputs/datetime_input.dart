// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';

class CustomDateTimeInput extends StatefulWidget {
  final String labelText;
  TextEditingController controller;
  CustomDateTimeInput({super.key, required this.labelText, required this.controller});

  @override
  State<CustomDateTimeInput> createState() => _CustomDateTimeInput();
}

class _CustomDateTimeInput extends State<CustomDateTimeInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: OutlineInputBorder(),
      ),
      readOnly: true,
      onTap: () {
        selectDate();
      },
    );
  }

  Future<void> selectDate() async{
    DateTime? pickedDate =  await showDatePicker(
      context: context, 
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100),
    );
    
    if(pickedDate != null){
      setState(() {
        widget.controller.text = pickedDate.toString().split(" ")[0];
      });
    }
  }
}