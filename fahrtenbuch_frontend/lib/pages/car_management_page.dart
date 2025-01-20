// ignore_for_file: prefer_const_constructors

import 'package:fahrtenbuch_frontend/util/car/car_management.dart';
import 'package:flutter/material.dart';

class CarManagementPage extends StatefulWidget {
  const CarManagementPage({super.key});

  @override
  State<CarManagementPage> createState() => _CarManagementPageState();
}

class _CarManagementPageState extends State<CarManagementPage> {
  late CarManagement carManagement;

  @override
  void initState() {
    super.initState();
    carManagement = CarManagement(context: context, setStateCallback: () {setState(() {});});
    carManagement.fetchCars();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CarManagement.cars.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: CarManagement.cars.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    CarManagement.cars[index].CarNumber,
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: SizedBox(
                    width: 80, 
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .min,
                      children: [
                        IconButton(onPressed: () => carManagement.editCar(index), icon: Icon(Icons.edit)),
                        IconButton(onPressed: () => carManagement.deleteCar(index), icon: Icon(Icons.delete, color: Colors.red,)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}