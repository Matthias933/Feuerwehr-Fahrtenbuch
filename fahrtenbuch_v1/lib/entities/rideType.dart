import 'package:hive/hive.dart';

part 'rideType.g.dart';

@HiveType(typeId: 4)
class RideType{
  @HiveField(0)
  final int Id;

  @HiveField(1)
  final String Name;

  RideType({
    required this.Id,
    required this.Name,
  });

  factory RideType.fromJson(Map<String, dynamic> json) {
  return RideType(
    Id: json['id'] as int,
    Name: json['name'] as String,
  );
}

Map<String, dynamic> toJson() {
  return {
    'id': Id,
    'Name': Name,
  };
}
}