// ignore_for_file: prefer_const_constructors

import 'package:fahrtenbuch_frontend/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Management {
  final String baseUrl = 'localhost:3000';
  static String accessToken = '';
  final VoidCallback setStateCallback;

  Management({required this.setStateCallback});
  
  Future<void> signIn(String userName, String password, BuildContext context) async{
    debugPrint('signing in');
    try{
      final uri = Uri.http(baseUrl, 'signIn', {
      'name': '$userName',
      'password': '$password',
    });
    final response = await http.get(uri);
    debugPrint(response.statusCode.toString());
    if (response.statusCode == 200) {
      accessToken = response.body;
      Navigator.of(context).pop();
    } else {
      displaySnackbar('Falsches Password oder Benutzername', Icon(Icons.error, color: Colors.white,), Colors.red, context);
      debugPrint('Invalid password or server error.');
    }
    }
    catch(e){
      debugPrint(e.toString());
    }
  }

  Future<void> ShowLoginPage(BuildContext context) async{
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    await showDialog(context: context, barrierDismissible: false, builder: (BuildContext context){
      return LoginPage(nameController: nameController, passwordController: passwordController, onSubmit: () {signIn(nameController.text, passwordController.text, context);},);
    });
  }

  void displaySnackbar(String text, Icon icon, Color color, BuildContext context){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: color,
      //behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 5),
      showCloseIcon: true,
      content: Row(
        children: [
          icon,
          SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    ));
  }
}