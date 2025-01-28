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

  var personBox = await Hive.openBox('personBox');
  var rideBox = await Hive.openBox('rideBox');
  var rideTypeBox = await Hive.openBox('rideTypeBox');
  var carBox = await Hive.openBox('carBox');
  var tokenBox = await Hive.openBox('tokenBox');
  var carNameBox = await Hive.openBox('carNameBox');
  var kilometerBox = await Hive.openBox('kilometerBox');
  var previousRideBox = await Hive.openBox('previousRideBox');
  var serverInfoBox = await Hive.openBox('serverBox');

  //Get people from server
  ApiController apiController = ApiController();
  AuthController authController = AuthController();
  DBContext dbContext = DBContext();

  await apiController.checkServerConnection();
  await authController.signIn();
  await apiController.fetchPeople();
  await apiController.fetchCars();
  await apiController.fetchRideTypes();

  final List<dynamic> rides = List.from(dbContext.rideList); //creates a copy of the actual list
  if(rides.isNotEmpty){
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
