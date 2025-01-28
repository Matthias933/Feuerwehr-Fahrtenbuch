// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:fahrtenbuch_frontend/controller/management.dart';
import 'package:fahrtenbuch_frontend/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");

  String serverName = dotenv.env['SERVR_NAME'] ?? '';
  String serverPort = dotenv.env['SERVER_PORT'] ?? '';

  Management.serverName = serverName;
  Management.serverPort = serverPort;

  Management.baseUrl = 'http://$serverName:$serverPort/';

  debugPrint('${Management.baseUrl}baseUrl');
  runApp(MainApp());
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
