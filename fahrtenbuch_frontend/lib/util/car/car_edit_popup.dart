import 'package:fahrtenbuch_frontend/models/car.dart';
import 'package:fahrtenbuch_frontend/util/text_input.dart';
import 'package:flutter/material.dart';

class CarEditPopup extends StatefulWidget {
  final String dialogName;
  final Car? car;
  final Function(String) onSubmit;
  const CarEditPopup({super.key, required this.dialogName, required this.car, required this.onSubmit});

  @override
  State<CarEditPopup> createState() => _CarEditPopupState();
}

class _CarEditPopupState extends State<CarEditPopup> {
  late TextEditingController carNumberController;

  @override
  void initState() {
    super.initState();
    if (widget.car != null) {
      carNumberController = TextEditingController(text: widget.car!.CarNumber);
    } else {
      carNumberController = TextEditingController();
    }
  }

  @override
  void dispose() {
    carNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.dialogName),
      content: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            
              CustomTextInput(
                labelText: 'Fahrzeugnummer',
                controller: carNumberController,
              ),
              SizedBox(height: 10)
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
            widget.onSubmit(
              carNumberController.text,
            );
          },
          child: Text('Speichern', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }
}
