// ignore_for_file: non_constant_identifier_names, unused_local_variable, constant_identifier_names

class Car {
  final int? Id;
  final String CarNumber;

  Car({
    this.Id,
    required this.CarNumber
  });

   factory Car.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int Id,
        'carNumber': String CarNumber,
      } =>
        Car(
          Id: json['id'] as int,
          CarNumber: json['carNumber'] as String,
        ),
      _ => throw const FormatException('Failed to load Cars.'),
    };
  }

  Map<String, dynamic> toJson() {
    return {
      'id': Id,
      'carNumber': CarNumber
    };
  }
}