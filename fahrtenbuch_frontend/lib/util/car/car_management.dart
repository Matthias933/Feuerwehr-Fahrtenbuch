// ignore_for_file: prefer_const_constructors

import 'package:fahrtenbuch_frontend/controller/car_controller.dart';
import 'package:fahrtenbuch_frontend/models/car.dart';
import 'package:fahrtenbuch_frontend/util/car/car_edit_popup.dart';
import 'package:fahrtenbuch_frontend/util/delete_popup.dart';
import 'package:flutter/material.dart';

class CarManagement {
  final BuildContext context;
  final CarController controller;
  final VoidCallback setStateCallback;
  static List<Car> cars = [];

  CarManagement({required this.context, required this.setStateCallback})
      : controller = CarController();

  void deleteCar(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeletePopup(
            title: 'Fahrzeug',
            description:
                'Wenn Sie dieses Fahrzeug löschen werden alle anhängenden Fahrten des Fahrzeugs mit gelöscht!',
            onDelete: () => confirmDelte(index),
          );
        });
  }

  void confirmDelte(int index) async {
    int ret = await controller.deleteCar(cars[index].Id!);
    Navigator.of(context).pop();
    if (ret == 0) {
      fetchCars();
      displaySnackbar(
          'Fahrzeug wurde erfolgreich gelöscht',
          Icon(
            Icons.info,
            color: Colors.white,
          ),
          Colors.green);
    } else {
      displaySnackbar('Fahrzeug konnte nicht gelöscht werden',
          Icon(Icons.error, color: Colors.white), Colors.red);
    }
  }

  void editCar(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CarEditPopup(
          dialogName: 'Fahrzeug bearbeiten',
          car: cars[index],
          onSubmit: (String carNumber) {
            confirmEdit(index, carNumber);
          },
        );
      },
    );
  }

  void confirmEdit(int index, String carNumber) async {
    Car currentCar = cars[index];

    Car updatedCar = Car(Id: currentCar.Id, CarNumber: carNumber);

    int ret = await controller.editCar(updatedCar);

    if (ret == 0) {
      displaySnackbar(
          'Fahrzeug wurde aktualisiert',
          Icon(
            Icons.info,
            color: Colors.white,
          ),
          Colors.green);
      fetchCars();
    } else {
      displaySnackbar(
          'Fahrzeug konnte nicht aktualisiert werden',
          Icon(
            Icons.error,
            color: Colors.white,
          ),
          Colors.red);
    }
    Navigator.of(context).pop();
  }

  void createCar() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CarEditPopup(
          dialogName: 'Fahrzeug erstellen',
          car: null,
          onSubmit: (String carNumber) {
            confirmCreate(carNumber);
          },
        );
      },
    );
  }

  void confirmCreate(String carNumber) async {
    Car car = Car(CarNumber: carNumber);

    int ret = await controller.createCar(car);

    if (ret == 0) {
      displaySnackbar(
          'Fahrzeug wurde erstellt',
          Icon(
            Icons.info,
            color: Colors.white,
          ),
          Colors.green);
      fetchCars();
    } else {
      displaySnackbar(
          'Fahrzeug konnte nicht erstellt werden',
          Icon(
            Icons.error,
            color: Colors.white,
          ),
          Colors.red);
    }
    Navigator.of(context).pop();
  }

  void fetchCars() async {
    debugPrint('fetching all cars');
    cars = await controller.fetchCars();
    setStateCallback();
  }

  void displaySnackbar(String text, Icon icon, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      //behavior: SnackBarBehavior.floating,
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
