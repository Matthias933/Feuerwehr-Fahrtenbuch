// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison, prefer_conditional_assignment, unnecessary_set_literal, unused_local_variable

import 'package:fahrtenbuch_v1/classes/api_controller.dart';
import 'package:fahrtenbuch_v1/classes/auth_controller.dart';
import 'package:fahrtenbuch_v1/entities/car.dart';
import 'package:fahrtenbuch_v1/entities/person.dart';
import 'package:fahrtenbuch_v1/entities/ride.dart';
import 'package:fahrtenbuch_v1/entities/rideType.dart';
import 'package:fahrtenbuch_v1/entities/role.dart';
import 'package:fahrtenbuch_v1/database/context.dart';
import 'package:fahrtenbuch_v1/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  
  // Register adapters
  Hive.registerAdapter(PersonAdapter());
  Hive.registerAdapter(RoleAdapter());
  Hive.registerAdapter(RideAdapter());
  Hive.registerAdapter(CarAdapter());
  Hive.registerAdapter(RideTypeAdapter());

  // Open all boxes
  var boxes = [
    'personBox',
    'rideBox',
    'rideTypeBox',
    'carBox',
    'tokenBox',
    'carNameBox',
    'kilometerBox',
    'previousRideBox',
    'serverBox'
  ];

  for (var boxName in boxes) {
    var box = await Hive.openBox(boxName);
    //await box.clear(); // Clears all data
    //await box.deleteFromDisk(); // Uncomment to completely remove the box
  }

  // Initialize necessary services
  ApiController apiController = ApiController();
  AuthController authController = AuthController();
  DBContext dbContext = DBContext();

  await apiController.checkServerConnection();
  await authController.signIn();
  await apiController.fetchPeople();
  await apiController.fetchCars();
  await apiController.fetchRideTypes();

  // Sync rides if there are any
  final List<dynamic> rides = List.from(dbContext.rideList);
  if (rides.isNotEmpty) {
    for (var ride in rides) {
      await apiController.createRide(ride);
    }
    dbContext.clearRides();
  }

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage()
    );
  }
}
