import 'package:fahrtenbuch_frontend/models/car.dart';
import 'package:fahrtenbuch_frontend/util/inputs/check_box_input.dart';
import 'package:fahrtenbuch_frontend/util/inputs/number_input.dart';
import 'package:fahrtenbuch_frontend/util/inputs/text_input.dart';
import 'package:flutter/material.dart';

class CarEditPopup extends StatefulWidget {
  final String dialogName;
  final Car? car;
  final Function(String, String, String, int, bool) onSubmit;
  const CarEditPopup({super.key, required this.dialogName, required this.car, required this.onSubmit});

  @override
  State<CarEditPopup> createState() => _CarEditPopupState();
}

class _CarEditPopupState extends State<CarEditPopup> {
  late TextEditingController carNumberController;
  late TextEditingController manufacturerController;
  late TextEditingController buildyearController;
  late TextEditingController typeController;
  late bool isAcitve;
  @override
  void initState() {
    super.initState();
    if (widget.car != null) {
      carNumberController = TextEditingController(text: widget.car!.CarNumber);
      manufacturerController = TextEditingController(text: widget.car!.Manufacturer);
      typeController = TextEditingController(text: widget.car!.Type);
      buildyearController = TextEditingController(text: widget.car!.Buildyear.toString());
      isAcitve = widget.car!.IsActive;
    } else {
      carNumberController = TextEditingController();
      manufacturerController = TextEditingController();
      typeController = TextEditingController();
      buildyearController = TextEditingController();
      isAcitve = false;
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
              const SizedBox(height: 10),
              CustomTextInput(
                labelText: 'Hersteller',
                controller: manufacturerController,
              ),
              const SizedBox(height: 10),
               CustomTextInput(
                labelText: 'Fahrzeugtyp',
                controller: typeController,
              ),
              const SizedBox(height: 10),
              CustomNumberInput(
                labelText: 'Baujahr', 
                controller: buildyearController
              ),
              const SizedBox(height: 10),
              CustomCheckBoxInput(description: 'Aktiv', value: isAcitve, onChanged: (value) {setState(() {isAcitve = value;});})
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Abbrechen', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {
            widget.onSubmit(
              carNumberController.text,
              manufacturerController.text,
              typeController.text,
              int.parse(buildyearController.text),
              isAcitve
            );
          },
          child: const Text('Speichern', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }
}
