// ignore_for_file: prefer_const_constructors, prefer_typing_uninitialized_variables

import 'package:fahrtenbuch_frontend/models/ride.dart';
import 'package:fahrtenbuch_frontend/util/inputs/auto_complete_input.dart';
import 'package:fahrtenbuch_frontend/util/car/car_management.dart';
import 'package:fahrtenbuch_frontend/util/inputs/check_box_input.dart';
import 'package:fahrtenbuch_frontend/util/inputs/datetime_input.dart';
import 'package:fahrtenbuch_frontend/util/inputs/dropdown_input.dart';
import 'package:fahrtenbuch_frontend/util/inputs/number_input.dart';
import 'package:fahrtenbuch_frontend/util/person/person_management.dart';
import 'package:fahrtenbuch_frontend/util/inputs/text_input.dart';
import 'package:flutter/material.dart';

class RideEditPopup extends StatefulWidget {
  final List<String> rideTypeItems;
  final String dialogName;
  final Ride? ride;
  final Function(String, String, String, String, String, String, int, int, int,bool,bool,bool,bool,bool,bool, String, String) onSubmit;

  const RideEditPopup({
    super.key,
    required this.dialogName,
    required this.onSubmit,
    required this.rideTypeItems,
    this.ride,
  });

  @override
  State<RideEditPopup> createState() => _RideEditPopupState();
}

class _RideEditPopupState extends State<RideEditPopup> {
  String? dropDownItem;
  bool usedPowerGenerator = false;
  bool powerGeneratorTankFull = false;
  bool usedRespiratoryProtection = false;
  bool respiratoryProtectionUpgraded = false;
  bool usedCAFS = false;
  bool cafsTankFull = false;

  late String rideType = '';

  late TextEditingController dateController;
  late TextEditingController carController;
  late TextEditingController driverController;
  late TextEditingController commanderController;
  late TextEditingController rideDescriptionController;
  late TextEditingController kilometerStartController;
  late TextEditingController kilometerEndController;
  late TextEditingController gasListerController;
  late TextEditingController defectsController;
  late TextEditingController missingsController;
  late CarManagement carManagement;
 
  @override
  void initState() {
    super.initState();
    if (widget.ride != null) {
      dateController = TextEditingController(text: widget.ride!.Date);
      carController = TextEditingController(text: widget.ride!.Vehicle!.CarNumber);
      driverController = TextEditingController(text: '${widget.ride!.Driver!.FirstName} ${widget.ride!.Driver!.LastName}');
      commanderController = TextEditingController(text: '${widget.ride!.Commander!.FirstName} ${widget.ride!.Commander!.LastName}');
      rideDescriptionController = TextEditingController(text: widget.ride!.RideDescription);
      kilometerStartController = TextEditingController(text: widget.ride!.KilometerStart.toString());
      kilometerEndController = TextEditingController(text: widget.ride!.KilometerEnd.toString());
      gasListerController = TextEditingController(text: widget.ride!.GasLiter.toString());
      defectsController = TextEditingController(text: widget.ride!.Defects);
      missingsController = TextEditingController(text: widget.ride!.MissingItems);

      rideType = widget.ride!.Type!.Name;
      usedPowerGenerator = widget.ride!.UsedPowerGenerator;
      powerGeneratorTankFull = widget.ride!.PowerGeneratorTankFull;
      usedRespiratoryProtection = widget.ride!.UsedRespiratoryProtection;
      respiratoryProtectionUpgraded = widget.ride!.RespiratoryProtectionUpgraded;
      usedCAFS = widget.ride!.UsedCAFS;
      cafsTankFull = widget.ride!.CAFSTankFull;
    }
    else{
      dateController = TextEditingController();
      carController = TextEditingController();
      driverController = TextEditingController();
      commanderController = TextEditingController();
      rideDescriptionController = TextEditingController();
      kilometerStartController = TextEditingController();
      kilometerEndController = TextEditingController();
      gasListerController = TextEditingController();
      defectsController = TextEditingController();
      missingsController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(PersonManagement.persons.value.where((driver) => driver.Roles.any((role) => role.Name == 'Maschinist')).map((person) => '${person.FirstName} ${person.LastName}').toList().length.toString());
    return AlertDialog(
      title: Text(widget.dialogName),
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          constraints: BoxConstraints(maxWidth: 400),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12),
              ExpansionTile(
                title: Text('Allgemeines'),
                leading: Icon(Icons.tune),
                childrenPadding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  CustomDateTimeInput(
                    labelText: 'Datum *',
                    controller: dateController,
                  ),
                  SizedBox(height: 8),
                  AutoCompleteInput(
                    names: CarManagement.cars.value.map((car) => car.CarNumber).toList(), 
                    labelText: 'Fahrzeug *',
                    controller: carController,
                  ),
                  SizedBox(height: 8),
                  AutoCompleteInput(
                    names: PersonManagement.persons.value.where((driver) => driver.Roles.any((role) => role.Name == 'Maschinist')).map((person) => '${person.FirstName} ${person.LastName}').toList(), 
                    labelText: 'Fahrer *',
                    controller: driverController,
                  ),
                  SizedBox(height: 8),
                  AutoCompleteInput(
                    names: PersonManagement.persons.value.where((commander) => commander.Roles.any((role) => role.Name == 'Kommandant')).map((person) => '${person.FirstName} ${person.LastName}').toList(),
                    labelText: 'Kommandant *',
                    controller: commanderController,
                  ),
                  SizedBox(height: 8),
                  DropDown(inputValues: widget.rideTypeItems, selectedValue: rideType, onValueChanged: (value) {setState(() {rideType = value ?? 'Unknowm';});}, labelText: 'Fahrt Typ wählen *'),
                  SizedBox(height: 8),
                  CustomTextInput(
                    labelText: 'Zweck der Fahrt',
                    controller: rideDescriptionController,
                  ),
                  SizedBox(height: 16),
                  Text('Kilometerstand',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                          child: CustomNumberInput(
                        labelText: 'Anfang *',
                        controller: kilometerStartController,
                      )),
                      SizedBox(width: 8),
                      Expanded(
                          child: CustomNumberInput(
                        labelText: 'Ende *',
                        controller: kilometerEndController,
                      )),
                    ],
                  ),
                  SizedBox(height: 16),
                  CustomNumberInput(
                    labelText: 'Getankte Liter',
                    controller: gasListerController,
                  ),
                ],
              ),
              SizedBox(height: 16),
              ExpansionTile(
                title: Text('Spezielles'),
                leading: Icon(Icons.edit),
                childrenPadding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  Text('Stromerzeuger',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  CustomCheckBoxInput(
                    description: 'Betrieben',
                    value: usedPowerGenerator,
                    onChanged: (value) {
                      setState(() {
                        usedPowerGenerator = value;
                      });
                    },
                  ),
                  CustomCheckBoxInput(
                    description: 'Tank voll',
                    value: powerGeneratorTankFull,
                    onChanged: (value) {
                      setState(() {
                        powerGeneratorTankFull = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Text('Atemschutz',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  CustomCheckBoxInput(
                    description: 'Getragen',
                    value: usedRespiratoryProtection,
                    onChanged: (value) {
                      setState(() {
                        usedRespiratoryProtection = value;
                      });
                    },
                  ),
                  CustomCheckBoxInput(
                    description: 'Aufgerüstet',
                    value: respiratoryProtectionUpgraded,
                    onChanged: (value) {
                      setState(() {
                        respiratoryProtectionUpgraded = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Text('CAFS', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  CustomCheckBoxInput(
                    description: 'Betrieben',
                    value: usedCAFS,
                    onChanged: (value) {
                      setState(() {
                        usedCAFS = value;
                      });
                    },
                  ),
                  CustomCheckBoxInput(
                    description: 'Tank voll',
                    value: cafsTankFull,
                    onChanged: (value) {
                      setState(() {
                        cafsTankFull = value;
                      });
                    },
                  ),
                  SizedBox(height: 16),
                  Text('Fahrzeug',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  CustomTextInput(
                    labelText: 'Mängel',
                    controller: defectsController,
                  ),
                  SizedBox(height: 8),
                  CustomTextInput(
                      labelText: 'Fehlendes', controller: missingsController),
                ],
              ),
              SizedBox(height: 12),
            ],
          ),
        ),
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
              carController.text,
              driverController.text,
              commanderController.text,
              dateController.text,
              rideDescriptionController.text,
              rideType,
              int.parse(kilometerStartController.text),
              int.parse(kilometerEndController.text), 
              int.parse(gasListerController.text),
              usedPowerGenerator,
              powerGeneratorTankFull,
              usedRespiratoryProtection,
              respiratoryProtectionUpgraded,
              usedCAFS,
              cafsTankFull,
              defectsController.text,
              missingsController.text
           );
          },
          child: Text('Speichern', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }

   void navigateBack() {
    Navigator.of(context).pop();
  }

  void submitRide() {
    
  }
}