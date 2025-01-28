// ignore_for_file: prefer_interpolation_to_compose_strings, curly_braces_in_flow_control_structures, empty_catches

import 'dart:convert';

import 'package:fahrtenbuch_v1/entities/car.dart';
import 'package:fahrtenbuch_v1/entities/person.dart';
import 'package:fahrtenbuch_v1/entities/ride.dart';
import 'package:fahrtenbuch_v1/database/context.dart';
import 'package:fahrtenbuch_v1/entities/rideType.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiController {
  final String baseUrl;
  DBContext context = DBContext();

  static bool isConnected = false;

  ApiController({String? baseUrl}) 
    : baseUrl = baseUrl ?? 'http://${DBContext().getServerAddress()}:${DBContext().getServerPort()}/';


  Future<void> checkServerConnection() async {
    final url = Uri.parse('${baseUrl}checkConnection');
    try {
      final response = await http.post(url);

      print('status code is: ${response.statusCode}');

      if (response.statusCode == 201) {
        isConnected = true;
      } else {
        isConnected = false;
      }
    } catch (e) {
      isConnected = false;
    }
  }

  Future<void> fetchPeople() async {
    if (!isConnected) return;

    List<Person> persons;

    try {
      final response = await http.get(
        Uri.parse(baseUrl + 'activePeople'),
        headers: {
          'Authorization': 'Bearer ${context.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        persons = jsonData
            .map((e) => Person.fromJson(e as Map<String, dynamic>))
            .toList();
        context.setPersons(persons);
        debugPrint('fetched ' + persons.length.toString() + ' people');
      } else if (response.statusCode == 401) {
        debugPrint('Error: Unauthorized');
      } else {
        debugPrint('ERROR: Could not fetch data.' + response.statusCode.toString());
      }
    } catch (e) {debugPrint('error: $e');}
  }

  Future<void> fetchRideTypes() async {
    if (!isConnected) return;

    List<RideType> rideTypes;

    try {
      final response = await http.get(
        Uri.parse(baseUrl + 'rideTypes'),
        headers: {
          'Authorization': 'Bearer ${context.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        rideTypes = jsonData
            .map((e) => RideType.fromJson(e as Map<String, dynamic>))
            .toList();
        context.setRideTypes(rideTypes);
        debugPrint('fetched ' + rideTypes.length.toString() + ' rideTypes');
      } else if (response.statusCode == 401) {
        debugPrint('Error: Unauthorized');
      } else {
        debugPrint('ERROR: Could not fetch data.' + response.statusCode.toString());
      }
    } catch (e) {debugPrint('error: $e');}
  }

  Future<void> fetchCars() async {
    if (!isConnected) return;

    List<Car> cars;

    try {
      final response = await http.get(
        Uri.parse(baseUrl + 'activeCar'),
        headers: {
          'Authorization': 'Bearer ${context.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        cars = jsonData
            .map((e) => Car.fromJson(e as Map<String, dynamic>))
            .toList();
        context.setCars(cars);
        debugPrint('fetched ' + cars.length.toString() + ' cars');
      } else if (response.statusCode == 401) {
        debugPrint('Error: Unauthorized');
      } else {
        debugPrint('ERROR: Could not fetch data.' + response.statusCode.toString());
      }
    } catch (e) {debugPrint('error: $e');}
  }

  Future<int> createRide(Ride ride) async {
    await checkServerConnection();
    if (!isConnected) 
      return -1;

    final url = Uri.parse('${baseUrl}ride');
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer ${context.accessToken}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(ride.toJson()),
      );
      debugPrint(response.statusCode.toString());
    } catch (e) {debugPrint('error: $e');}
    return 0;
  }
}
