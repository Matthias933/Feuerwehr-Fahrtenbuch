import 'dart:convert';

import 'package:fahrtenbuch_frontend/controller/management.dart';
import 'package:fahrtenbuch_frontend/models/person.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PersonController {
  final String baseUrl = 'http://localhost:3000/';

  Future<List<Person>> fetchPeople() async {
    List<Person> persons = [];

    try {
      final response = await http.get(
        Uri.parse(baseUrl + 'people'),
        headers: {
          'Authorization': 'Bearer ${Management.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        persons = jsonData
            .map((e) => Person.fromJson(e as Map<String, dynamic>))
            .toList();
      } else if (response.statusCode == 401) {
        debugPrint('Error: Unauthorized');
      } else {
        debugPrint('ERROR: Could not fetch data.' + response.statusCode.toString());
      }
    } catch (e) {
      debugPrint('Error $e');
    }

    return persons;
  }

  Future<int> deletePerson(int id) async {
    try {
      final response = await http.delete(
        Uri.parse(baseUrl + 'people/$id'),
        headers: {
          'Authorization': 'Bearer ${Management.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Person deleted successfully');
        return 0;
      } else {
       debugPrint('ERROR: Could not delete person.' + response.statusCode.toString());
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return -1;
  }

 Future<int> editPerson(Person person) async {
  try {
    // convert person to json
    String jsonBody = jsonEncode(person.toJson());

    final response = await http.put(
      Uri.parse(baseUrl + 'people'),
      headers: {
        'Authorization': 'Bearer ${Management.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonBody,  
    );

    if (response.statusCode == 200) {
      debugPrint('Person updated successfully');
      return 0;
    } else {
      debugPrint('ERROR: Could not update person. Status code: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('Error: $e');
  }
  return -1;
}

Future<int> createPerson(Person person) async{
  try{
    // convert person to json
    String jsonBody = jsonEncode(person.toJson());

    final response = await http.post(
      Uri.parse(baseUrl + 'people'),
      headers: {
        'Authorization': 'Bearer ${Management.accessToken}',
        'Content-Type': 'application/json',
      },
      body: jsonBody,  
    );

    if (response.statusCode == 201) {
      debugPrint('Person created successfully');
      return 0;
    } else {
      debugPrint('ERROR: Could not create person. Status code: ${response.statusCode}');
    }
  }
  catch(e){
    debugPrint('Error: $e');
  }
  return -1;
}

}
