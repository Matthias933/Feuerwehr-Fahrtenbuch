// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final List<String> inputValues;
  final String labelText;
  final Function(String?) onValueChanged;
  final String? selectedValue;

  const DropDown(
      {super.key,
      required this.inputValues,
      required this.onValueChanged,
      required this.labelText,
      this.selectedValue});

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  late String? selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.inputValues.contains(widget.selectedValue)) {
      selectedValue = widget.selectedValue;
    } else {
      selectedValue = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Colors.black),
        disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)),
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
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
