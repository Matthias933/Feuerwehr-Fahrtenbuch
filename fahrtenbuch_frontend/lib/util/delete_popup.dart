// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class DeletePopup extends StatelessWidget {
  final String title;
  final String description;
  final Function onDelete;
  const DeletePopup({super.key, required this.title, required this.description, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title + ' ' + 'Löschen'),
      content: Wrap(
        children: [
          Row(
           children: [
              Icon(Icons.warning, color: Colors.red,),
              Text(description)
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
          onPressed: () => onDelete(),
          child: Text('Löschen', style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}