// ignore_for_file: non_constant_identifier_names

import 'package:fahrtenbuch_frontend/models/car.dart';
import 'package:fahrtenbuch_frontend/models/person.dart';

class Ride {
  final int? Id;
  final int? CarId;
  final int? DriverId;
  final int? CommanderId;
  final String Date;
  final String RideDescription;
  final int KilometerStart;
  final int KilometerEnd;
  final int GasLiter;

  final bool UsedPowerGenerator;
  final bool PowerGeneratorTankFull;
  final bool UsedRespiratoryProtection;
  final bool RespiratoryProtectionUpgraded;
  final bool UsedCAFS;
  final bool CAFSTankFull;
  final String Defects;
  final String MissingItems;

  final Car? Vehicle;
  final Person? Driver;
  final Person? Commander;

  Ride({
    this.Id,
    required this.CarId,
    required this.DriverId,
    required this.CommanderId,
    required this.Date,
    required this.RideDescription,
    required this.KilometerStart,
    required this.KilometerEnd,
    this.GasLiter = 0,
    this.UsedPowerGenerator = false,
    this.PowerGeneratorTankFull = false,
    this.UsedRespiratoryProtection = false,
    this.RespiratoryProtectionUpgraded = false,
    this.UsedCAFS = false,
    this.CAFSTankFull = false,
    this.Defects = '',
    this.MissingItems = '',

    this.Vehicle,
    this.Driver,
    this.Commander
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    Person driver = Person.fromJson(json['driver']);
    Person commander = Person.fromJson(json['commander']);
    Car vehicle = Car.fromJson(json['car']);

    return Ride(
      Id: json['id'] as int?,
      CarId: vehicle.Id,
      DriverId: driver.Id,
      CommanderId: commander.Id,
      Date: json['date'] as String,
      RideDescription: json['rideDescription'] as String,
      KilometerStart: json['kilometerStart'] as int,
      KilometerEnd: json['kilometerEnd'] as int,
      GasLiter: json['gasLiter'] as int? ?? 0,
      UsedPowerGenerator: json['usedPowerGenerator'] as bool? ?? false,
      PowerGeneratorTankFull: json['powerGeneratorTankFull'] as bool? ?? false,
      UsedRespiratoryProtection: json['usedRespiratoryProtection'] as bool? ?? false,
      RespiratoryProtectionUpgraded: json['respiratoryProtectionUpgraded'] as bool? ?? false,
      UsedCAFS: json['usedCAFS'] as bool? ?? false,
      CAFSTankFull: json['cafstankFull'] as bool? ?? false,
      Defects: json['defects'] as String? ?? '',
      MissingItems: json['missingItems'] as String? ?? '',

      Commander: commander,
      Driver: driver,
      Vehicle: vehicle
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': Id,
      'carId': CarId,
      'driverId': DriverId,
      'commanderId': CommanderId,
      'date': Date,
      'rideDescription': RideDescription,
      'kilometerStart': KilometerStart,
      'kilometerEnd': KilometerEnd,
      'gasLiter': GasLiter,
      'usedPowerGenerator': UsedPowerGenerator,
      'powerGeneratorTankFull': PowerGeneratorTankFull,
      'usedRespiratoryProtection': UsedRespiratoryProtection,
      'respiratoryProtectionUpgraded': RespiratoryProtectionUpgraded,
      'usedCAFS': UsedCAFS,
      'cafstankFull': CAFSTankFull,
      'defects': Defects,
      'missingItems': MissingItems,
    };
  }
}
