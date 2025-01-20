// ignore_for_file: non_constant_identifier_names

import 'package:hive/hive.dart';

part 'role.g.dart';

@HiveType(typeId: 1)
class Role {
  @HiveField(0)
  final int Id;

  @HiveField(1)
  final String Name;

  Role({
    required this.Id,
    required this.Name,
  });

   factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      Id: json['id'] as int,
      Name: json['name'] as String,
    );
  }
}
