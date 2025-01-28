import 'package:fahrtenbuch_v1/classes/api_controller.dart';
import 'package:fahrtenbuch_v1/database/context.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AuthController {
  final String baseUrl;
  DBContext context = DBContext();

  AuthController({String? baseUrl}) 
    : baseUrl = baseUrl ?? '${DBContext().getServerAddress()}:${DBContext().getServerPort()}';


   Future<void> signIn() async{
    if(!ApiController.isConnected){
      debugPrint('no connection');
      return;
    }

     final uri = Uri.http(baseUrl, 'signIn', {
      'name': 'Admin',
      'password': 'Admin',
    });
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      context.setToken(response.body);
    } else {
      debugPrint('Invalid password or server error.');
    }
   }
}