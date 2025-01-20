// ignore_for_file: non_constant_identifier_names
import 'package:hive/hive.dart';

part 'ride.g.dart';

@HiveType(typeId: 2)
class Ride {
  @HiveField(0)
  final int CarId;
  @HiveField(1)
  final int DriverId;
  @HiveField(2)
  final int CommanderId;
  @HiveField(3)
  final String Date;
  @HiveField(4)
  final String RideDescription;
  @HiveField(5)
  final int KilometerStart;
  @HiveField(6)
  final int KilometerEnd;
  @HiveField(7)
  final int GasLiter;

  @HiveField(8)
  final bool UsedPowerGenerator;
  @HiveField(9)
  final bool PowerGeneratorTankFull;
  @HiveField(10)
  final bool UsedRespiratoryProtection;
  @HiveField(11)
  final bool RespiratoryProtectionUpgraded;
  @HiveField(12)
  final bool UsedCAFS;
  @HiveField(13)
  final bool CAFSTankFull;
  @HiveField(14)
  final String Defects;
  @HiveField(15)
  final String MissingItems;
  
  Ride({
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
    this.MissingItems = ''
  });

factory Ride.fromJson(Map<String, dynamic> json) {
  return Ride(
    CarId: json['carId'] as int,
    DriverId: json['driverId'] as int,
    CommanderId: json['commanderId'] as int,
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
  );
}

Map<String, dynamic> toJson() {
  return {
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