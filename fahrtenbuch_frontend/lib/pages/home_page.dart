// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings
import 'package:fahrtenbuch_frontend/controller/management.dart';
import 'package:fahrtenbuch_frontend/pages/car_management_page.dart';
import 'package:fahrtenbuch_frontend/pages/person_management_page.dart';
import 'package:fahrtenbuch_frontend/pages/ride_management_page.dart';
import 'package:fahrtenbuch_frontend/util/car/car_management.dart';
import 'package:fahrtenbuch_frontend/util/person/person_management.dart';
import 'package:fahrtenbuch_frontend/util/ride/ride_management.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> appBarNames = ['Personen', 'Fahrzeuge', 'Fahrten'];
  final List<Widget> appPages = [];
  int currentIndex = 0;

  late Management management;
  late PersonManagement personManagement;
  late CarManagement carManagement;
  late RideManagement rideManagement;

  @override
  void initState() {
    super.initState();
    management = Management(setStateCallback: () {
      setState(() {});
    });
    personManagement = PersonManagement(
        context: context,
        setStateCallback: () {
          setState(() {});
        });
    carManagement = CarManagement(
        context: context,
        setStateCallback: () {
          setState(() {});
        });

    rideManagement = RideManagement(
        context: context,
        setStateCallback: () {
          setState(() {});
        });

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Management.showLoginPage(context);
      debugPrint('login finished');
      setState(() {

        appPages.addAll([
        PersonManagementPage(),
        CarManagementPage(),
        RideManagementPage(),
      ]);
        //fetch cars
        carManagement.fetchCars();
      });  
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: appPages.isEmpty
          ? null
          : appPages[currentIndex],
      appBar: AppBar(
        title: Text(appBarNames[currentIndex]),
        centerTitle: true,
      ),
      drawer: appPages.isEmpty
          ? null
          : Drawer(
              backgroundColor: Colors.white,
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Center(
                        child: Container(
                      child: Column(
                        children: [
                          Image.network(
                              'https://www.feuerwehr-nenzing.at/wp-content/uploads/2022/01/cropped-logo-feuerwehr-nenzing.png'),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Fahrtenbuch',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))
                        ],
                      ),
                    )),
                  ),
                  ListTile(
                    leading: Icon(Icons.group),
                    title: Text(
                      'Personen',
                      style: TextStyle(color: Colors.black),
                    ),
                    onTap: () => navigatePage(0),
                  ),
                  ListTile(
                      leading: Icon(Icons.drive_eta),
                      title: Text(
                        'Fahrzeuge',
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () => navigatePage(1)),
                  ListTile(
                      leading: Icon(Icons.route),
                      title: Text(
                        'Fahrten',
                        style: TextStyle(color: Colors.black),
                      ),
                      onTap: () => navigatePage(2)),
                ],
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => displayPopUp(),
        backgroundColor: Colors.red,
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void navigatePage(int idx) {
    setState(() {
      currentIndex = idx;
    });
  }

  void displayPopUp() {
    showCustomDialog();
  }

  void showCustomDialog() {
    Management.tokenExpired(context);
    
    if (currentIndex == 0) {
      personManagement.createPerson();
    } else if (currentIndex == 1) {
      carManagement.createCar();
    } else if (currentIndex == 2) {
      rideManagement.createRide();
    } else {}
  }
}
