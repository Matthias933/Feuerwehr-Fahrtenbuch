import 'package:flutter/material.dart';

class CustomDropDownInput extends StatefulWidget {
  final List<String> items;
  final Function(String?) onValueChanged;

  CustomDropDownInput({Key? key, required this.onValueChanged, required  this.items})
      : super(key: key);

  @override
  _CustomDropDownInputState createState() => _CustomDropDownInputState();
}

class _CustomDropDownInputState extends State<CustomDropDownInput> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      items: widget.items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
      value: selectedItem,
      onChanged: (value) {
        setState(() {
          selectedItem = value;
        });
        widget.onValueChanged(value);
      },
      hint: Text('Wähle ein Fahrzeug'),
    );
  }
}
