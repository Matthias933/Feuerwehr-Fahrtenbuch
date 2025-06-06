// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:fahrtenbuch_frontend/controller/car_controller.dart';
import 'package:fahrtenbuch_frontend/controller/person_controller.dart';
import 'package:fahrtenbuch_frontend/models/car.dart';
import 'package:fahrtenbuch_frontend/models/person.dart';
import 'package:fahrtenbuch_frontend/models/role.dart';
import 'package:fahrtenbuch_frontend/util/delete_popup.dart';
import 'package:fahrtenbuch_frontend/util/person/person_edit_popup.dart';
import 'package:flutter/material.dart';

class PersonManagement {
  final BuildContext context;
  final PersonController controller;
  final CarController carController;
  final VoidCallback setStateCallback;
  static ValueNotifier<List<Person>> persons = ValueNotifier([]);

  PersonManagement({required this.context, required this.setStateCallback})  : controller = PersonController(), carController = CarController();
    void deletePerson(int index){
    showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
      return DeletePopup(title: 'Person', description: 'Wenn Sie diese Person löschen werden alle anhängenden Fahrten der Person mit gelöscht!',  onDelete: () => confirmDelte(index),);
    });
  }

  void confirmDelte(int index) async{
    int ret = await controller.deletePerson(persons.value[index].Id!);
    Navigator.of(context).pop();
    if(ret == 0){
      fetchPeople();
      displaySnackbar('Person wurde erfolgreich gelöscht', Icon(Icons.info, color: Colors.white,), Colors.green);
    }
    else{
      displaySnackbar('Person konnte nicht gelöscht werden', Icon(Icons.error, color: Colors.white), Colors.red);
    }
  }

  void editPerson(int index) async{
  List<Car> cars = await carController.fetchCars();
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return PersonEditPopup(
        dialogName: 'Person bearbeiten',
        person: persons.value[index],
        availableCars: cars,
        onSubmit: (String firstName, String lastName, bool isActive, bool isDriver, bool isCommander, List<Car> selectedCars) {
          confirmEdit(index, firstName, lastName, isActive, isDriver, isCommander, selectedCars);
        },
      );
    },
  );
}


 void confirmEdit(int index, String firstName, String lastName, bool isActive, bool isDriver, bool isCommander, List<Car> selectedCars) async {
  Person currentPerson = persons.value[index];

  List<Role> updatedRoles = List.from(currentPerson.Roles); 

  if (isDriver && !updatedRoles.any((role) => role.Name == 'Maschinist')) {
    updatedRoles.add(Role(Name: 'Maschinist'));
  } else if (!isDriver && updatedRoles.any((role) => role.Name == 'Maschinist')) {
    updatedRoles.removeWhere((role) => role.Name == 'Maschinist');
  }

  if (isCommander && !updatedRoles.any((role) => role.Name == 'Kommandant')) {
    updatedRoles.add(Role(Name: 'Kommandant'));
  } else if (!isCommander && updatedRoles.any((role) => role.Name == 'Kommandant')) {
    updatedRoles.removeWhere((role) => role.Name == 'Kommandant');
  }

  Person updatedPerson = Person(
    Id: currentPerson.Id,
    FirstName: firstName,
    LastName: lastName,
    IsActive: isActive,
    Roles: updatedRoles,
    DriveableCars: selectedCars
  );

  int ret = await controller.editPerson(updatedPerson);

  if (ret == 0) {
    displaySnackbar('Person wurde aktualisiert', Icon(Icons.info, color: Colors.white,), Colors.green);
    fetchPeople();
  } else {
    displaySnackbar('Person konnte nicht aktualisiert werden', Icon(Icons.error, color: Colors.white,), Colors.red);
  }
  Navigator.of(context).pop();
}

  Future<void> createPerson() async{
    List<Car> cars = await carController.fetchCars();
    showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return PersonEditPopup(
        dialogName: 'Person Erstellen',
        person: null,
        availableCars: cars,
        onSubmit: (String firstName, String lastName, bool isActive, bool isDriver, bool isCommander, List<Car> selectedCars) async {
          await confirmCreate(firstName, lastName, isActive, isDriver, isCommander, selectedCars);
        },
      );
    },
  );
  }

  Future<void> confirmCreate(String firstName, String lastName, bool isActive, bool isDriver, bool isCommander, List<Car> selectedCars) async {
    List<Role> roles = [];

    if (isDriver) {
      roles.add(Role(Name: 'Maschinist'));
    }

    if (isCommander) {
      roles.add(Role(Name: 'Kommandant'));
    }
    
    Person person = Person(
      FirstName: firstName,
      LastName: lastName,
      IsActive: isActive,
      Roles: roles,
      DriveableCars: selectedCars
    );

    int ret = await controller.createPerson(person);

    if (ret == 0) {
      displaySnackbar(
          'Person wurde erstellt',
          Icon(
            Icons.info,
            color: Colors.white,
          ),
          Colors.green);
          fetchPeople();
    } else {
      displaySnackbar(
          'Person konnte nicht erstellt werden',
          Icon(
            Icons.error,
            color: Colors.white,
          ),
          Colors.red);
    }
    Navigator.of(context).pop();
  }



  Future<void> fetchPeople() async {
    debugPrint('fetching all people');
    persons.value = await controller.fetchPeople();
    setStateCallback();
  }

  void displaySnackbar(String text, Icon icon, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      duration: Duration(seconds: 5),
      showCloseIcon: true,
      content: Row(
        children: [
          icon,
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ));
  }
}