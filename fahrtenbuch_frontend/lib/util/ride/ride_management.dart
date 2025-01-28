// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, use_build_context_synchronously

import 'package:fahrtenbuch_frontend/controller/csv_controller.dart';
import 'package:fahrtenbuch_frontend/controller/ride_controller.dart';
import 'package:fahrtenbuch_frontend/models/car.dart';
import 'package:fahrtenbuch_frontend/models/person.dart';
import 'package:fahrtenbuch_frontend/models/ride.dart';
import 'package:fahrtenbuch_frontend/models/rideType.dart';
import 'package:fahrtenbuch_frontend/util/car/car_management.dart';
import 'package:fahrtenbuch_frontend/util/delete_popup.dart';
import 'package:fahrtenbuch_frontend/util/person/person_management.dart';
import 'package:fahrtenbuch_frontend/util/ride/ride_edit_popup.dart';
import 'package:flutter/material.dart';

class RideManagement {
  final BuildContext context;
  final RideController controller;
  final CsvController csvController;
  final VoidCallback setStateCallback;
  List<Ride> rides = [];
  List<RideType> rideTypes = [];

  RideManagement({required this.context, required this.setStateCallback})
      : controller = RideController(), csvController = CsvController();

  void deleteRide(int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return DeletePopup(
            title: 'Fahrt',
            description:
                'Wenn Sie diese Fahrt löschen kann der Vorgang nicht rückgängig gemacht werden!',
            onDelete: () => confirmDelte(index),
          );
        });
  }

  void confirmDelte(int index) async {
    int ret = await controller.deleteRide(rides[index].Id!);
    Navigator.of(context).pop();
    if (ret == 0) {
      fetchRides();
      displaySnackbar(
          'Fahrt wurde erfolgreich gelöscht',
          Icon(
            Icons.info,
            color: Colors.white,
          ),
          Colors.green);
    } else {
      displaySnackbar('Fahrt konnte nicht gelöscht werden',
          Icon(Icons.error, color: Colors.white), Colors.red);
    }
  }

  void editRide(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RideEditPopup(
          rideTypeItems: rideTypes.map((type) => type.Name).toList(),
          dialogName: 'Fahrt bearbeiten',
          ride: rides[index],
          onSubmit: (
            String carNumber,
            String driverName,
            String commanderName,
            String date,
            String rideType,
            String rideDescription,
            int KilometerStart,
            int KilometerEnd,
            int GasLiter,
            bool UsedPowerGenerator,
            bool PowerGeneratorTankFull,
            bool UsedRespiratoryProtection,
            bool RespiratoryProtectionUpgraded,
            bool UsedCAFS,
            bool CAFSTankFull,
            String Defects,
            String MissingItems,
          ) {
            confirmEdit(
                index,
                carNumber,
                driverName,
                commanderName,
                date,
                rideType,
                rideDescription,
                KilometerStart,
                KilometerEnd,
                GasLiter,
                UsedPowerGenerator,
                PowerGeneratorTankFull,
                UsedRespiratoryProtection,
                RespiratoryProtectionUpgraded,
                UsedCAFS,
                CAFSTankFull,
                Defects,
                MissingItems);
          },
        );
      },
    );
  }

  void confirmEdit(
    int index,
    String carNumber,
    String driverName,
    String commanderName,
    String date,
    String rideType,
    String rideDescription,
    int KilometerStart,
    int KilometerEnd,
    int GasLiter,
    bool UsedPowerGenerator,
    bool PowerGeneratorTankFull,
    bool UsedRespiratoryProtection,
    bool RespiratoryProtectionUpgraded,
    bool UsedCAFS,
    bool CAFSTankFull,
    String Defects,
    String MissingItems,
  ) async {
    Ride currentRide = rides[index];

    List<String> driverNames = driverName.split(' ');
    List<String> commanderNames = commanderName.split(' ');


    Car car = CarManagement.cars.value.firstWhere((car) => car.CarNumber == carNumber && car.IsActive == true);
    Person driver = PersonManagement.persons.value.firstWhere((driver) => driver.FirstName == driverNames[0] && driver.LastName == driverNames[1]);
    Person commander = PersonManagement.persons.value.firstWhere((commander) => commander.FirstName == commanderNames[0] && commander.LastName == commanderNames[1]);
    RideType type = rideTypes.firstWhere((t) => t.Name == rideType);
    Ride updatedRide = Ride(
      Id: currentRide.Id,
      CarId: car.Id,
      DriverId: driver.Id,
      RideTypeId: type.Id,
      CommanderId: commander.Id,
      Date: date,
      RideDescription: rideDescription,
      KilometerStart: KilometerStart,
      KilometerEnd: KilometerEnd,
      GasLiter: GasLiter,
      UsedPowerGenerator: UsedPowerGenerator,
      PowerGeneratorTankFull: PowerGeneratorTankFull,
      UsedRespiratoryProtection: UsedPowerGenerator,
      RespiratoryProtectionUpgraded: RespiratoryProtectionUpgraded,
      UsedCAFS: UsedCAFS,
      CAFSTankFull: CAFSTankFull,
      Defects: Defects,
      MissingItems: MissingItems
    );

    int ret = await controller.editRide(updatedRide);

    if (ret == 0) {
      displaySnackbar(
          'Fahrt wurde aktualisiert',
          Icon(
            Icons.info,
            color: Colors.white,
          ),
          Colors.green);
      fetchRides();
    } else {
      displaySnackbar(
          'Fahrt konnte nicht aktualisiert werden',
          Icon(
            Icons.error,
            color: Colors.white,
          ),
          Colors.red);
    }
    Navigator.of(context).pop();
  }

  void createRide() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RideEditPopup(
          rideTypeItems: rideTypes.map((type) => type.Name).toList(),
          dialogName: 'Fahrt erstellen',
          ride: null,
           onSubmit: (
            String carNumber,
            String driverName,
            String commanderName,
            String date,
            String rideDescription,
            String rideType,
            int KilometerStart,
            int KilometerEnd,
            int GasLiter,
            bool UsedPowerGenerator,
            bool PowerGeneratorTankFull,
            bool UsedRespiratoryProtection,
            bool RespiratoryProtectionUpgraded,
            bool UsedCAFS,
            bool CAFSTankFull,
            String Defects,
            String MissingItems,
          ) {
            confirmCreate(
                carNumber,
                driverName,
                commanderName,
                date,
                rideType,
                rideDescription,
                KilometerStart,
                KilometerEnd,
                GasLiter,
                UsedPowerGenerator,
                PowerGeneratorTankFull,
                UsedRespiratoryProtection,
                RespiratoryProtectionUpgraded,
                UsedCAFS,
                CAFSTankFull,
                Defects,
                MissingItems);
          },
        );
      },
    );
  }

  void confirmCreate(
    String carNumber,
    String driverName,
    String commanderName,
    String date,
    String rideType,
    String rideDescription,
    int KilometerStart,
    int KilometerEnd,
    int GasLiter,
    bool UsedPowerGenerator,
    bool PowerGeneratorTankFull,
    bool UsedRespiratoryProtection,
    bool RespiratoryProtectionUpgraded,
    bool UsedCAFS,
    bool CAFSTankFull,
    String Defects,
    String MissingItems,
  ) async {
    List<String> driverNames = driverName.split(' ');
    List<String> commanderNames = commanderName.split(' ');

    Car car = CarManagement.cars.value.firstWhere((car) => car.CarNumber == carNumber);
    Person driver = PersonManagement.persons.value.firstWhere((driver) => driver.FirstName == driverNames[0] && driver.LastName == driverNames[1]);
    Person commander= PersonManagement.persons.value.firstWhere((commander) => commander.FirstName == commanderNames[0] && commander.LastName == commanderNames[1]);
    RideType type = rideTypes.firstWhere((t) => t.Name == rideType);

     Ride ride = Ride(
      CarId: car.Id,
      DriverId: driver.Id,
      CommanderId: commander.Id,
      RideTypeId: type.Id,
      Date: date,
      RideDescription: rideDescription,
      KilometerStart: KilometerStart,
      KilometerEnd: KilometerEnd,
      GasLiter: GasLiter,
      UsedPowerGenerator: UsedPowerGenerator,
      PowerGeneratorTankFull: PowerGeneratorTankFull,
      UsedRespiratoryProtection: UsedPowerGenerator,
      RespiratoryProtectionUpgraded: RespiratoryProtectionUpgraded,
      UsedCAFS: UsedCAFS,
      CAFSTankFull: CAFSTankFull,
      Defects: Defects,
      MissingItems: MissingItems
    );

    int ret = await controller.createRide(ride);

    if (ret == 0) {
      displaySnackbar(
          'Fahrt wurde erstellt',
          Icon(
            Icons.info,
            color: Colors.white,
          ),
          Colors.green);
      fetchRides();
    } else {
      displaySnackbar(
          'Fahrt konnte nicht erstellt werden',
          Icon(
            Icons.error,
            color: Colors.white,
          ),
          Colors.red);
    }
    Navigator.of(context).pop();
   
  }

  Future<void> fetchRides() async {
    debugPrint('fetching all rides');
    rides = await controller.fetchRides();
    setStateCallback();
  }

  Future<void> fetchRideTypes() async {
    debugPrint('fetching all rideTypes');
    rideTypes = await controller.fetchRideTypes();
    setStateCallback();
  }

  void generateCsv(List<Ride> rides){
    List<List<String>> listOfLists = [];

    for (var ride in rides) {
      List<String> rideList = [
        ride.Date,
        '${ride.Driver!.FirstName} ${ride.Driver!.LastName}',
        '${ride.Commander!.FirstName} ${ride.Commander!.LastName}',
        ride.Type!.Name,
        ride.RideDescription,
        ride.KilometerStart.toString(),
        ride.KilometerEnd.toString(),
        ride.GasLiter.toString(),
        ride.UsedPowerGenerator ? 'ja' : 'nein',
        ride.PowerGeneratorTankFull ? 'ja' : 'nein',
        ride.UsedRespiratoryProtection ? 'ja' : 'nein',
        ride.RespiratoryProtectionUpgraded ? 'ja' : 'nein',
        ride.UsedCAFS ? 'ja' : 'nein',
        ride.CAFSTankFull ? 'ja' : 'nein',
        ride.Defects,
        ride.MissingItems
      ];
      listOfLists.add(rideList);
    }
    csvController.DownloadCSV(listOfLists);
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
