import 'dart:convert';

import 'package:fahrtenbuch_frontend/controller/management.dart';
import 'package:fahrtenbuch_frontend/models/ride.dart';
import 'package:fahrtenbuch_frontend/models/rideType.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RideController {
  final String baseUrl = 'http://localhost:3000/';

  Future<List<Ride>> fetchRides() async {
    List<Ride> rides = [];

    try {
      final response = await http.get(
        Uri.parse('${baseUrl}ride'),
        headers: {
          'Authorization': 'Bearer ${Management.accessToken}',
          'Content-Type': 'application/json',
        },
      );
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        rides = jsonData
            .map((e) => Ride.fromJson(e as Map<String, dynamic>))
            .toList();
        debugPrint('fetched ${rides.length} rides');
      } else if (response.statusCode == 401) {
        debugPrint('Error: Unauthorized');
      } else {
        debugPrint('ERROR: Could not fetch data.${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return rides;
  }

  Future<List<RideType>> fetchRideTypes() async {
    List<RideType> rideTypes = [];

    try {
      final response = await http.get(
        Uri.parse('${baseUrl}rideTypes'),
        headers: {
          'Authorization': 'Bearer ${Management.accessToken}',
          'Content-Type': 'application/json',
        },
      );
      debugPrint(response.statusCode.toString());
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        rideTypes = jsonData
            .map((e) => RideType.fromJson(e as Map<String, dynamic>))
            .toList();
        debugPrint('fetched ${rideTypes.length} rideTypes');
      } else if (response.statusCode == 401) {
        debugPrint('Error: Unauthorized');
      } else {
        debugPrint('ERROR: Could not fetch data.${response.statusCode}');
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    return rideTypes;
  }

  Future<int> deleteRide(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('${baseUrl}ride/$id'),
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

  Future<int> editRide(Ride ride) async {
    try {
      // convert car to json
      String jsonBody = jsonEncode(ride.toJson());

      final response = await http.put(
        Uri.parse('${baseUrl}ride'),
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
        debugPrint('ERROR: Could not update car. Status code: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
    return -1;
  }

  Future<int> createRide(Ride ride) async {
    try {
      // convert person to json
      String jsonBody = jsonEncode(ride.toJson());

      final response = await http.post(
        Uri.parse('${baseUrl}ride'),
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
    } catch (e) {
      debugPrint('Error: $e');
    }
    return -1;
  }
}