// ignore_for_file: constant_identifier_names, unused_local_variable

import 'package:fahrtenbuch_frontend/models/role.dart';

class Person {
  final int? Id;
  final String FirstName;
  final String LastName;
  final bool IsActive;
  final List<Role> Roles;

  Person({
    this.Id,
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

   Map<String, dynamic> toJson() {
    return {
      'id': Id,
      'firstName': FirstName,
      'lastName': LastName,
      'isActive': IsActive,
      'roles': Roles.map((role) => role.toJson()).toList(),
    };
  }
}
