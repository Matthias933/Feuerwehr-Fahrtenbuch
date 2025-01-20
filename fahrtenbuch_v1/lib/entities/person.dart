// ignore_for_file: constant_identifier_names, unused_local_variable, non_constant_identifier_names

import 'package:hive/hive.dart';
import 'role.dart';

part 'person.g.dart';

@HiveType(typeId: 0)
class Person {
  @HiveField(0)
  final int Id;

  @HiveField(1)
  final String FirstName;

  @HiveField(2)
  final String LastName;

  @HiveField(3)
  final bool IsActive;

  @HiveField(4)
  final List<Role> Roles;

  Person({
    required this.Id,
    required this.FirstName,
    required this.LastName,
    required this.IsActive,
    required this.Roles,
  });

   factory Person.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int Id,
        'firstName': String FirstName,
        'lastName': String LastName,
        'isActive': bool IsActive,
      } =>
        Person(
          Id: json['id'] as int,
          FirstName: json['firstName'] as String,
          LastName: json['lastName'] as String,
          IsActive: json['isActive'] as bool,
          Roles: (json['roles'] as List<dynamic>)
          .map((roleJson) => Role.fromJson(roleJson as Map<String, dynamic>))
          .toList(),
        ),
      _ => throw const FormatException('Failed to load person.'),
    };
  }
}
