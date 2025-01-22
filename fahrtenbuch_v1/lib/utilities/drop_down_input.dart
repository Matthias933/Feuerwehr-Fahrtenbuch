// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final List<String> inputValues;
  final String labelText;
  final Function(String?) onValueChanged;

  DropDown({super.key, required this.inputValues, required this.onValueChanged, required this.labelText});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: Colors.black
          ),
          disabledBorder:const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey
            )
          ),
          enabledBorder: const OutlineInputBorder(),
          focusedBorder: const OutlineInputBorder(),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        ),
        value: selectedValue,
        items: widget.inputValues
            .map((value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedValue = value;
            widget.onValueChanged(value);
          });
        },
    );
  }
}