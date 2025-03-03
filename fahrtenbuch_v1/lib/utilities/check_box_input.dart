// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class CustomCheckBoxInput extends StatefulWidget {
  final String description;
  final bool value;
  final ValueChanged<bool> onChanged; 

  const CustomCheckBoxInput({
    super.key,
    required this.description,
    required this.value,
    required this.onChanged, 
  });

  @override
  State<CustomCheckBoxInput> createState() => _CustomCheckBoxInputState();
}

class _CustomCheckBoxInputState extends State<CustomCheckBoxInput> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.value,
          onChanged: (value) {
            widget.onChanged(value ?? false); 
          },
        ),
        Text(widget.description),
      ],
    );
  }
}

