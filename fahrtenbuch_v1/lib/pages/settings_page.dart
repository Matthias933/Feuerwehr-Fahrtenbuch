import 'package:fahrtenbuch_v1/database/context.dart';
import 'package:fahrtenbuch_v1/utilities/number_input.dart';
import 'package:fahrtenbuch_v1/utilities/text_input.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController serverAddressController = TextEditingController();
  TextEditingController serverPortController = TextEditingController();

  DBContext dbContext = DBContext();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
    loadSettings();
  }


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Settings'),
      content: Wrap(
        children: [
          Column(
            children: [
              CustomTextInput(labelText: 'Serveradresse', controller: serverAddressController),
              const SizedBox(height: 10,),
              CustomNumberInput(labelText: 'Serverport', controller: serverPortController),
            ],
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Abbrechen', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () => saveSettings(),
          child: const Text('Speichern', style: TextStyle(color: Colors.green)),
        ),
      ],
    );
  }

  void saveSettings(){
    dbContext.setServerInfo(serverAddressController.text, int.parse(serverPortController.text));
    Navigator.of(context).pop();
  }

  void loadSettings(){
    String address = dbContext.getServerAddress();

    if(address.isNotEmpty){
      serverAddressController.text = address;
    }

    int port = dbContext.getServerPort();

    if(port != 0){
      serverPortController.text = port.toString();
    }

    setState(() {});
  }
}