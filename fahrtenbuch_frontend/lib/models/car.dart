// ignore_for_file: non_constant_identifier_names, unused_local_variable, constant_identifier_names

class Car {
  final int? Id;
  final String CarNumber;
  final String Manufacturer;
  final String Type;
  final int Buildyear;
  final bool IsActive;

  Car({
    this.Id,
    required this.CarNumber,
    required this.Manufacturer,
    required this.Type,
    required this.Buildyear,
    required this.IsActive
  });

   factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      Id: json['id'] as int,
      CarNumber: json['carNumber'] as String,
      Manufacturer: json['manufacturer'] as String,
      Type: json['type'] as String,
      Buildyear: json['buildyear'] as int,
      IsActive: json['isActive'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': Id,
      'carNumber': CarNumber,
      'manufacturer': Manufacturer,
      'type': Type,
      'buildyear': Buildyear,
      'isActive': IsActive
    };
  }
}