// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:fahrtenbuch_v1/database/context.dart';
import 'package:fahrtenbuch_v1/pages/create_ride_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  DBContext dbContext = DBContext();
  @override
  Widget build(BuildContext context) {
    List<dynamic> rides =  List.from(dbContext.rideList);
    return Scaffold(
      backgroundColor: Colors.white,
       appBar: AppBar(
          elevation: 10,
          title: Text('Fahrtenbuch',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          centerTitle: true,
        ),
      
      body: Center(
        child: SizedBox(
          width: 300,
          height: 500,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey,
            ),
            child: Column(
              children: [
                Text(
                  'Lokal gespeicherte Fahrten',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),
                ),
                Text(rides.isEmpty ? 'Alle Fahrten sind auf dem Server gespeichert'  : 'Nicht gespeicherte Fahrten'),
                Expanded(
                  child: ListView.builder(
                    itemCount: rides.length,
                    itemBuilder: (BuildContext content, int index){
                      return ListTile(
                        title: Text(rides[index].RideDescription),
                        subtitle: Text(rides[index].Date),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: (){
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder:  (context) => const CreateRidePage()));
        },
        label: const Text('Hinzufügen', style: TextStyle(color: Colors.white),),
        icon: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }
}