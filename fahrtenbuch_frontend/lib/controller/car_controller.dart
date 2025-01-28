import 'dart:convert';

import 'package:fahrtenbuch_frontend/controller/management.dart';
import 'package:fahrtenbuch_frontend/models/car.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CarController {
  Future<List<Car>> fetchCars() async {
    List<Car> cars = [];

    try {
      final response = await http.get(
        Uri.parse('${Management.baseUrl}car'),
        headers: {
          'Authorization': 'Bearer ${Management.accessToken}',
          'Content-Type': 'application/json',
        },
      );
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        cars = jsonData
            .map((e) => Car.fromJson(e as Map<String, dynamic>))
            .toList();
        debugPrint('fetched ${cars.length} cars');
      } else if (response.statusCode == 401) {
        debugPrint('Error: Unauthorized');
      } else {
        debugPrint('ERROR: Could not fetch data.${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return cars;
  }

  Future<int> deleteCar(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('${Management.baseUrl}car/$id'),
        headers: {
          'Authorization': 'Bearer ${Management.accessToken}',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        debugPrint('Car deleted successfully');
        return 0;
      } else {
        debugPrint('ERROR: Could not delete car.${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return -1;
  }

  Future<int> editCar(Car car) async {
    try {
      // convert car to json
      String jsonBody = jsonEncode(car.toJson());

      final response = await http.put(
        Uri.parse('${Management.baseUrl}car'),
        headers: {
          'Authorization': 'Bearer ${Management.accessToken}',
          'Content-Type': 'application/json',
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        debugPrint('Car updated successfully');
        return 0;
      } else {
        debugPrint(
            'ERROR: Could not update car. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return -1;
  }

  Future<int> createCar(Car car) async {
    try {
      // convert person to json
      String jsonBody = jsonEncode(car.toJson());

      final response = await http.post(
        Uri.parse('${Management.baseUrl}car'),
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
        debugPrint(
            'ERROR: Could not create person. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return -1;
  }
}
