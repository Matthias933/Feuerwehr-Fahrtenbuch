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
  final int RideTypeId;
  @HiveField(5)
  final String RideDescription;
  @HiveField(6)
  final int KilometerStart;
  @HiveField(7)
  final int KilometerEnd;
  @HiveField(8)
  final int GasLiter;

  @HiveField(9)
  final bool UsedPowerGenerator;
  @HiveField(10)
  final bool PowerGeneratorTankFull;
  @HiveField(11)
  final bool UsedRespiratoryProtection;
  @HiveField(12)
  final bool RespiratoryProtectionUpgraded;
  @HiveField(13)
  final bool UsedCAFS;
  @HiveField(14)
  final bool CAFSTankFull;
  @HiveField(15)
  final String Defects;
  @HiveField(16)
  final String MissingItems;
  
  Ride({
    required this.CarId,
    required this.DriverId,
    required this.CommanderId,
    required this.Date,
    required this.RideTypeId,
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
  });

Map<String, dynamic> toJson() {
  return {
    'carId': CarId,
    'driverId': DriverId,
    'commanderId': CommanderId,
    'date': Date,
    'rideTypeId': RideTypeId,
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