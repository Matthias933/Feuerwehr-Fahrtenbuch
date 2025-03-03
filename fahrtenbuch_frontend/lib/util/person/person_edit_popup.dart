import 'package:flutter/material.dart';
import 'package:fahrtenbuch_frontend/models/person.dart';
import 'package:fahrtenbuch_frontend/models/car.dart';
import 'package:fahrtenbuch_frontend/util/inputs/check_box_input.dart';
import 'package:fahrtenbuch_frontend/util/inputs/text_input.dart';

class PersonEditPopup extends StatefulWidget {
  final String dialogName;
  final Person? person;
  final List<Car> availableCars;
  final Function(String, String, bool, bool, bool, List<Car>) onSubmit;

  const PersonEditPopup({
    super.key,
    required this.dialogName,
    required this.onSubmit,
    this.person,
    required this.availableCars,
  });

  @override
  _PersonEditPopupState createState() => _PersonEditPopupState();
}

class _PersonEditPopupState extends State<PersonEditPopup> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  bool isActive = false;
  bool isDriver = false;
  bool isCommander = false;
  late List<Car> assignedCars;

  @override
  void initState() {
    super.initState();

    firstNameController = TextEditingController(text: widget.person?.FirstName ?? '');
    lastNameController = TextEditingController(text: widget.person?.LastName ?? '');
    isActive = widget.person?.IsActive ?? false;

    for (var role in widget.person?.Roles ?? []) {
      if (role.Name == 'Maschinist') {
        isDriver = true;
      }
      if (role.Name == 'Kommandant') {
        isCommander = true;
      }
    }

    assignedCars = widget.person?.DriveableCars.toList() ?? [];
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.dialogName),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextInput(labelText: 'Vorname', controller: firstNameController),
            const SizedBox(height: 10),
            CustomTextInput(labelText: 'Nachname', controller: lastNameController),
            const SizedBox(height: 10),
            CustomCheckBoxInput(
              description: 'Aktiv',
              value: isActive,
              onChanged: (value) => setState(() => isActive = value),
            ),
            const SizedBox(height: 10),
            CustomCheckBoxInput(
              description: 'Maschinist (Fahrer)',
              value: isDriver,
              onChanged: (value) => setState(() => isDriver = value),
            ),
            const SizedBox(height: 10),
            CustomCheckBoxInput(
              description: 'Kommandant',
              value: isCommander,
              onChanged: (value) => setState(() => isCommander = value),
            ),
            const SizedBox(height: 10),
            const Text("Berechtigte Fahrzeuge:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Column(
              children: widget.availableCars.map((car) {
                bool isAssigned = assignedCars.any((assignedCar) => assignedCar.CarNumber == car.CarNumber);
                return CustomCheckBoxInput(
                  description: car.CarNumber,
                  value: isAssigned,
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        assignedCars.add(car);
                      } else {
                        assignedCars.removeWhere((assignedCar) => assignedCar.CarNumber == car.CarNumber);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Abbrechen', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {
            widget.onSubmit(
              firstNameController.text,
              lastNameController.text,
              isActive,
              isDriver,
              isCommander,
              assignedCars,
            );
          },
          child: const Text('Speichern', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }
}
