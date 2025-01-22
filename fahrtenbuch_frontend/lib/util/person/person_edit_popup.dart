import 'package:fahrtenbuch_frontend/models/person.dart';
import 'package:flutter/material.dart';
import 'package:fahrtenbuch_frontend/util/inputs/check_box_input.dart';
import 'package:fahrtenbuch_frontend/util/inputs/text_input.dart';

class PersonEditPopup extends StatefulWidget {
  final String dialogName;
  final Person? person;
  final Function(String, String, bool, bool, bool) onSubmit;

  const PersonEditPopup({
    super.key,
    required this.dialogName,
    required this.onSubmit,
    this.person,
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

  @override
  void initState() {
    super.initState();
    if (widget.person != null) {
      firstNameController =
          TextEditingController(text: widget.person!.FirstName);
      lastNameController = TextEditingController(text: widget.person!.LastName);
      isActive = widget.person!.IsActive;

      for (var role in widget.person!.Roles) {
        if (role.Name == 'Maschinist') {
          isDriver = true;
        }
        if (role.Name == 'Kommandant') {
          isCommander = true;
        }
      }
    }
    else{
      firstNameController = TextEditingController();
      lastNameController = TextEditingController();
    }
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
      content: Wrap(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Vorname
              CustomTextInput(
                labelText: 'Vorname',
                controller: firstNameController,
              ),
              SizedBox(height: 10),
              // Nachname
              CustomTextInput(
                labelText: 'Nachname',
                controller: lastNameController,
              ),
              SizedBox(height: 10),
              // Aktiv-Checkbox
              CustomCheckBoxInput(
                description: 'Aktiv',
                value: isActive,
                onChanged: (value) {
                  setState(() {
                    isActive = value;
                  });
                },
              ),
              SizedBox(height: 10),
              // Fahrer-Checkbox (Maschinist)
              CustomCheckBoxInput(
                description: 'Maschinist (Fahrer)',
                value: isDriver,
                onChanged: (value) {
                  setState(() {
                    isDriver = value;
                  });
                },
              ),
              SizedBox(height: 10),
              // Kommandant-Checkbox
              CustomCheckBoxInput(
                description: 'Kommandant',
                value: isCommander,
                onChanged: (value) {
                  setState(() {
                    isCommander = value;
                  });
                },
              ),
              SizedBox(height: 10),
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
            // Alle Variablen an onSubmit übergeben
            widget.onSubmit(
              firstNameController.text,
              lastNameController.text,
              isActive,
              isDriver,
              isCommander,
            );
          },
          child: Text('Speichern', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }
}
