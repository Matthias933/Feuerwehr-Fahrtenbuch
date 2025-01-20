// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:fahrtenbuch_frontend/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

class Management {
  static String accessToken = '';
  final VoidCallback setStateCallback;

  Management({required this.setStateCallback});

  static void tokenExpired(BuildContext context){
    if(JwtDecoder.isExpired(accessToken)){
      showLoginPage(context);
    }
  }

  static Future<void> showLoginPage(BuildContext context) async {
    TextEditingController nameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return LoginPage(
            nameController: nameController,
            passwordController: passwordController,
            onSubmit: () async {
              debugPrint('signing in');
              try {
                final uri = Uri.http('localhost:3000', 'signIn', {
                  'name': nameController.text,
                  'password': passwordController.text,
                });
                final response = await http.get(uri);
                debugPrint(response.statusCode.toString());
                if (response.statusCode == 200) {
                  accessToken = response.body;
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Colors.red,
                    //behavior: SnackBarBehavior.floating,
                    duration: Duration(seconds: 5),
                    showCloseIcon: true,
                    content: Row(
                      children: const [
                        Icon(Icons.error),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Falsches Password oder Benutzername',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ));
                }
              } catch (e) {
                debugPrint(e.toString());
              }
            },
          );
        });
  }
}
