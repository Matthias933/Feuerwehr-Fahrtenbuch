// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:fahrtenbuch_frontend/controller/management.dart';
import 'package:fahrtenbuch_frontend/models/ride.dart';
import 'package:fahrtenbuch_frontend/util/car/car_management.dart';
import 'package:fahrtenbuch_frontend/util/inputs/datetime_input.dart';
import 'package:fahrtenbuch_frontend/util/inputs/dropdown_input.dart';
import 'package:fahrtenbuch_frontend/util/ride/ride_management.dart';
import 'package:flutter/material.dart';

class RideManagementPage extends StatefulWidget {
  const RideManagementPage({super.key});

  @override
  State<RideManagementPage> createState() => _RideManagementPageState();
}

class _RideManagementPageState extends State<RideManagementPage> {
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();

  late RideManagement rideManagement;
  late List<Ride> rides = [];
  late List<Ride> filteredRides = [];
  String? selectedCar;
  String? selectedType;

  @override
  void initState() {
    super.initState();

    rideManagement = RideManagement(
      context: context,
      setStateCallback: () {
        setState(() {});
      },
    );

    rideManagement.fetchRideTypes().then((_){
      setState(() {
        
      });
    });
    // Fetch rides
    rideManagement.fetchRides().then((_) {
      setState(() {
        rides = rideManagement.rides;
        filteredRides = List.from(rides);
      });
    });

    startController.addListener(() => filterRides());
    endController.addListener(() => filterRides());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomDateTimeInput(
                    labelText: 'Von',
                    controller: startController,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: CustomDateTimeInput(
                    labelText: 'Bis',
                    controller: endController,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: DropDown(
                    labelText: 'Fahrzeug wählen',
                    inputValues:
                        CarManagement.cars.map((car) => car.CarNumber).toList(),
                    onValueChanged: (selectedItem) {
                      selectedCar = selectedItem;
                      filterRides();
                    },
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  flex: 2,
                  child: DropDown(
                    labelText: 'Fahrten Typ wählen',
                    inputValues:
                        rideManagement.rideTypes.map((type) => type.Name).toList(),
                    onValueChanged: (selectedItem) {
                      selectedType = selectedItem;
                      filterRides();
                    },
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: ElevatedButton(
                    onPressed: resetFilters,
                    child: Text('Zurücksetzen'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Flexible(
              child: filteredRides.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredRides.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            title: Text(
                              filteredRides[index].RideDescription,
                              style: TextStyle(color: Colors.black),
                            ),
                            subtitle: Text(
                              'Datum: ${filteredRides[index].Date}\n'
                              'Kommandant: ${filteredRides[index].Commander!.FirstName} ${filteredRides[index].Commander!.LastName}\n'
                              'Verwendetes Fahrzeug: ${filteredRides[index].Vehicle!.CarNumber}\n'
                              'Gefahrene Kilometer: ${filteredRides[index].KilometerEnd - filteredRides[index].KilometerStart}',
                              style: TextStyle(color: Colors.black),
                            ),
                            trailing: SizedBox(
                              width: 80,
                              child: IconButton(
                                  onPressed: () => editRide(index),
                                  icon: Icon(Icons.edit)),
                            ));
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                  onPressed: () {
                    rideManagement.generateCsv(filteredRides);
                  },
                  child: Text('Exportieren'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

    void filterRides() {
    DateTime? start = startController.text.isNotEmpty
        ? DateTime.tryParse(startController.text)
        : null;
    DateTime? end = endController.text.isNotEmpty
        ? DateTime.tryParse(endController.text)
        : null;

    setState(() {
      filteredRides = rideManagement.rides.where((ride) {
        DateTime rideDate = DateTime.parse(ride.Date);

        // Check date range
        bool matchesStart = start == null || rideDate.isAfter(start);
        bool matchesEnd = end == null || rideDate.isBefore(end);

        // Check car filter
        bool matchesCar =
            selectedCar == null || ride.Vehicle!.CarNumber == selectedCar;

        bool matchesTyp =
            selectedType == null || ride.Type!.Name == selectedType;

        return matchesStart && matchesEnd && matchesCar && matchesTyp;
      }).toList();
    });
  }

  void resetFilters() {
    setState(() {
      filteredRides = List.from(rides);
      startController.clear();
      endController.clear();
      selectedCar = null;
    });
  }

  void editRide(int index) {
    Management.tokenExpired(context);
    rideManagement.editRide(index);
  }
}
