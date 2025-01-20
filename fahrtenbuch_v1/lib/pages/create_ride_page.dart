// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace, sort_child_properties_last, deprecated_member_use

import 'package:fahrtenbuch_v1/classes/api_controller.dart';
import 'package:fahrtenbuch_v1/entities/ride.dart';
import 'package:fahrtenbuch_v1/database/context.dart';
import 'package:fahrtenbuch_v1/pages/home_page.dart';
import 'package:fahrtenbuch_v1/utilities/check_box_input.dart';
import 'package:fahrtenbuch_v1/utilities/datetime_input.dart';
import 'package:fahrtenbuch_v1/utilities/number_input.dart';
import 'package:fahrtenbuch_v1/utilities/text_input.dart';
import 'package:flutter/material.dart';

import '../utilities/auto_complete_input.dart';

class CreateRidePage extends StatefulWidget {
  const CreateRidePage({super.key});
  @override
  State<CreateRidePage> createState() => _CreateRidePageState();
}

class _CreateRidePageState extends State<CreateRidePage> {
  TextEditingController carController = TextEditingController();
  TextEditingController driverController = TextEditingController();
  TextEditingController commanderController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController rideDescriptionController = TextEditingController();
  TextEditingController kilometerStartController = TextEditingController();
  TextEditingController kilometerEndController = TextEditingController();
  TextEditingController gasListerController = TextEditingController();
  TextEditingController defectsController = TextEditingController();
  TextEditingController missingsController = TextEditingController();
  bool usedPowerGenerator = false;
  bool powerGeneratorTankFull = false;
  bool usedRespiratoryProtection = false;
  bool respiratoryProtectionUpgraded = false;
  bool usedCAFS = false;
  bool cafsTankFull = false;
  DBContext dbContext = DBContext();

  @override
  void initState() {
    super.initState();
    String previousCarName = dbContext.getPreviousCarName();
    if(previousCarName.isNotEmpty){
      setState(() {
        carController.text = previousCarName;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> commanders = dbContext.getCommanders().map((commander) {
      return '${commander.FirstName} ${commander.LastName}';
    }).toList();
    List<String> drivers = dbContext.getDrivers().map((driver) {
      return '${driver.FirstName} ${driver.LastName}';
    }).toList();

    List<String> cars = dbContext.getCars().map((car){
      return '${car.CarNumber}';
    }).toList();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 10,
          title: Text('Fahrtenbuch',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Container(
                  width: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Neue Fahrt erstellen',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      ExpansionTile(
                        title: Text('Allgemeines'),
                        leading: Icon(Icons.tune),
                        childrenPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        children: [
                          AutoCompleteInput(
                            names: cars,
                            labelText: 'Fahrzeug *',
                            controller: carController,
                          ),
                          SizedBox(height: 8),
                          CustomDateTimeInput(
                            labelText: 'Datum *',
                            controller: dateController,
                          ),
                          SizedBox(height: 8),
                          AutoCompleteInput(
                            names: drivers,
                            labelText: 'Fahrer *',
                            controller: driverController,
                          ),
                          SizedBox(height: 8),
                          AutoCompleteInput(
                            names: commanders,
                            labelText: 'Kommandant *',
                            controller: commanderController,
                          ),
                          SizedBox(height: 8),
                          CustomTextInput(
                            labelText: 'Zweck der Fahrt *',
                            controller: rideDescriptionController,
                          ),
                          SizedBox(height: 16),
                          Text('Kilometerstand',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                  child: CustomNumberInput(
                                labelText: 'Anfang *',
                                controller: kilometerStartController,
                              )),
                              SizedBox(width: 8),
                              Expanded(
                                  child: CustomNumberInput(
                                labelText: 'Ende *',
                                controller: kilometerEndController,
                              )),
                            ],
                          ),
                          SizedBox(height: 16),
                          CustomNumberInput(
                            labelText: 'Getankte Liter',
                            controller: gasListerController,
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ExpansionTile(
                        title: Text('Spezielles'),
                        leading: Icon(Icons.edit),
                        childrenPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        children: [
                          Text('Stromerzeuger',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          CustomCheckBoxInput(
                            description: 'Betrieben',
                            value: usedPowerGenerator,
                            onChanged: (value) {
                              setState(() {
                                usedPowerGenerator = value;
                              });
                            },
                          ),
                          CustomCheckBoxInput(
                            description: 'Tank voll',
                            value: powerGeneratorTankFull,
                            onChanged: (value) {
                              setState(() {
                                powerGeneratorTankFull = value;
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          Text('Atemschutz',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          CustomCheckBoxInput(
                            description: 'Getragen',
                            value: usedRespiratoryProtection,
                            onChanged: (value) {
                              setState(() {
                                usedRespiratoryProtection = value;
                              });
                            },
                          ),
                          CustomCheckBoxInput(
                            description: 'Aufgerüstet',
                            value: respiratoryProtectionUpgraded,
                            onChanged: (value) {
                              setState(() {
                                respiratoryProtectionUpgraded = value;
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          Text('CAFS',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          CustomCheckBoxInput(
                            description: 'Betrieben',
                            value: usedCAFS,
                            onChanged: (value) {
                              setState(() {
                                usedCAFS = value;
                              });
                            },
                          ),
                          CustomCheckBoxInput(
                            description: 'Tank voll',
                            value: cafsTankFull,
                            onChanged: (value) {
                              setState(() {
                                cafsTankFull = value;
                              });
                            },
                          ),
                          SizedBox(height: 16),
                          Text('Fahrzeug',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          CustomTextInput(
                            labelText: 'Mängel',
                            controller: defectsController,
                          ),
                          SizedBox(height: 8),
                          CustomTextInput(
                              labelText: 'Fehlendes',
                              controller: missingsController),
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () => navigateBack(),
                            child: Text(
                              'Zurück',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.black),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          ElevatedButton(
                            onPressed: () => submitRide(),
                            child: Text(
                              'Absenden',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: ApiController.isConnected
                            ? Colors.green
                            : Colors.red),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      ApiController.isConnected ? 'Connected' : 'Disconnected',
                      style: TextStyle(color: Colors.black),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  //place for function
  void submitRide() {
    if (dateController.text.isNotEmpty &&
        rideDescriptionController.text.isNotEmpty &&
        kilometerStartController.text.isNotEmpty &&
        kilometerEndController.text.isNotEmpty &&
        driverController.text.isNotEmpty &&
        commanderController.text.isNotEmpty) {
      //requierd fields are filled out 
      Ride ride = assignRide();

      if (ApiController.isConnected) {
        saveOnServer(ride);
      } else {
        saveOnDevice(ride);
      }
    } else {
      displaySnackbar('Bitte alle Felder mit einem * ausfüllen',
          Icon(Icons.error, color: Colors.white), Colors.red);
    }
  }

  void saveOnServer(Ride ride) async {
    ApiController apiController = ApiController();
    int ret = await apiController.createRide(ride);
    if (ret < 0) {
      saveOnDevice(ride);
    } else {
      dbContext.setPreviousCarName(carController.text);
      displaySnackbar(
          'Fahrt wurde erfolgreich gespeichert',
          Icon(
            Icons.info,
            color: Colors.white,
          ), Colors.green);
      navigateBack();
    }
  }

  void saveOnDevice(Ride ride) {
    dbContext.setRide(ride);
    displaySnackbar(
        'Fahrt wurde erfolgreich auf dem Gerät gespeichert',
        Icon(
          Icons.info,
          color: Colors.white,
        ), Colors.blue);
    navigateBack();
  }

  void navigateBack() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  Ride assignRide() {
    int driverId = dbContext.getIdByName(driverController.text);
    int commanderId = dbContext.getIdByName(commanderController.text);
    int carId = dbContext.getCarIdByName(carController.text);
    return Ride(
      CarId: carId,
      DriverId: driverId,
      CommanderId: commanderId,
      Date: dateController.text,
      RideDescription: rideDescriptionController.text,
      KilometerStart: int.parse(kilometerStartController.text),
      KilometerEnd: int.parse(kilometerEndController.text),
      GasLiter: int.tryParse(gasListerController.text) ?? 0,
      UsedPowerGenerator: usedPowerGenerator,
      PowerGeneratorTankFull: powerGeneratorTankFull,
      UsedRespiratoryProtection: usedRespiratoryProtection,
      RespiratoryProtectionUpgraded: respiratoryProtectionUpgraded,
      UsedCAFS: usedCAFS,
      CAFSTankFull: cafsTankFull,
      Defects: defectsController.text,
      MissingItems: missingsController.text,
    );
  }

  void displaySnackbar(String text, Icon icon, Color color) {
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
