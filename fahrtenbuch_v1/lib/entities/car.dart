// ignore_for_file: constant_identifier_names, unused_local_variable, non_constant_identifier_names
import 'package:hive/hive.dart';

part 'car.g.dart';

@HiveType(typeId: 3)
class Car {
  @HiveField(0)
  final int Id;

  @HiveField(1)
  final String CarNumber;

  Car({
    required this.Id,
    required this.CarNumber,
  });

   factory Car.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int Id,
        'carNumber': String FirstName,
      } =>
        Car(
          Id: json['id'] as int,
          CarNumber: json['carNumber'] as String,
        ),
      _ => throw const FormatException('Failed to load Cars.'),
    };
  }
}
