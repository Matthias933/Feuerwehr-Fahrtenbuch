// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:fahrtenbuch_frontend/util/text_input.dart';
import 'package:flutter/material.dart';

class CarPopup extends StatelessWidget {
  final String dialogName;
  const CarPopup({super.key, required this.dialogName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(dialogName + ' ' + 'hinzufügen'),
      content: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextInput(labelText: 'Fahrzeug nummer', controller: TextEditingController()),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Abbrechen', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Erstellen', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}