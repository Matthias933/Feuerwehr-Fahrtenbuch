import 'package:fahrtenbuch_frontend/util/inputs/password_input.dart';
import 'package:fahrtenbuch_frontend/util/inputs/text_input.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController passwordController;
  final Function onSubmit;
  const LoginPage({super.key, required this.nameController, required this.passwordController, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Login'),
      content: Wrap(
        children:[ Column(
          children: [
            CustomTextInput(labelText: 'Benutzername', controller: nameController),
            SizedBox(height: 10,),
            CustomPasswordInput(labelText: 'Password', controller: passwordController)
          ],
        ),
      ]),
     actions: [
        TextButton(
          onPressed: () {
            onSubmit();
          },
          child: Text('Anmelden', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }
}