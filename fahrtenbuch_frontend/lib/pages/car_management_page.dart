// ignore_for_file: prefer_const_constructors

import 'package:fahrtenbuch_frontend/controller/management.dart';
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

    CarManagement.cars.addListener(refreshCars);

    carManagement = CarManagement(context: context, setStateCallback: () {setState(() {});});
    carManagement.fetchCars();
  }

  @override
  void dispose() {
    super.dispose();
    CarManagement.cars.removeListener(refreshCars);
  }

  void refreshCars(){
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CarManagement.cars.value.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: CarManagement.cars.value.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    CarManagement.cars.value[index].CarNumber,
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: SizedBox(
                    width: 80, 
                    child: Row(
                      mainAxisSize: MainAxisSize
                          .min,
                      children: [
                        IconButton(onPressed: () => editCar(index), icon: Icon(Icons.edit)),
                        IconButton(onPressed: () => deleteCar(index), icon: Icon(Icons.delete, color: Colors.red,)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  void editCar(int index){
    Management.tokenExpired(context);
    carManagement.editCar(index);
  }
  void deleteCar(int index){
    Management.tokenExpired(context);
    carManagement.deleteCar(index);
  }
}