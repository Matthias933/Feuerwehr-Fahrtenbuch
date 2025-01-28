// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:fahrtenbuch_frontend/controller/car_controller.dart';
import 'package:fahrtenbuch_frontend/models/car.dart';
import 'package:fahrtenbuch_frontend/util/car/car_edit_popup.dart';
import 'package:fahrtenbuch_frontend/util/delete_popup.dart';
import 'package:flutter/material.dart';

class CarManagement {
  final BuildContext context;
  final CarController controller;
  final VoidCallback setStateCallback;
  static ValueNotifier<List<Car>> cars = ValueNotifier([]);

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
    int ret = await controller.deleteCar(cars.value[index].Id!);
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
          car: cars.value[index],
          onSubmit: (String carNumber, String manufacturer, String type, int buildyear, bool isActive) {
            confirmEdit(index, carNumber, manufacturer, type, buildyear, isActive);
          },
        );
      },
    );
  }

  void confirmEdit(int index, String carNumber, String manufacturer, String type, int buildyear, bool isActive) async {
    Car currentCar = cars.value[index];

    Car updatedCar = Car(Id: currentCar.Id, CarNumber: carNumber, Manufacturer: manufacturer, Type: type, Buildyear: buildyear, IsActive: isActive);

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
          onSubmit: (String carNumber, String manufacturer, String type, int buildyear, bool isActive) {
            confirmCreate(carNumber, manufacturer, type, buildyear, isActive);
          },
        );
      },
    );
  }

  void confirmCreate(String carNumber, String manufacturer, String type, int buildyear, bool isActive) async {
    Car car = Car(CarNumber: carNumber, Manufacturer: manufacturer, Type: type, Buildyear: buildyear, IsActive: isActive);

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
    cars.value = await controller.fetchCars();
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
