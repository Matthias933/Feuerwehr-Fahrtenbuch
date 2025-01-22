import 'package:fahrtenbuch_v1/database/context.dart';
import 'package:fahrtenbuch_v1/pages/create_ride_page.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  DBContext dbContext = DBContext();

  @override
  Widget build(BuildContext context) {
    dynamic ride = dbContext.getPreviousRide();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 10,
        title: const Text(
          'Fahrtenbuch',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 500,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.blueGrey.shade100,
            ),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10)),
                    color: Colors.blueGrey,
                  ),
                  child: const Center(
                    child: Text(
                      'Letzte Fahrt',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ride != null
                      ? Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Fahrzeug: ${dbContext.getCarNameById(ride.CarId)}',
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87)),
                              const SizedBox(height: 5),
                              Text('Fahrer: ${dbContext.getPersonNameById(ride.DriverId)}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87)),
                              const SizedBox(height: 5),
                              Text('Kommandant: ${dbContext.getPersonNameById(ride.CommanderId)}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87)),
                              const SizedBox(height: 5),
                              Text('Datum: ${ride.Date}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87)),
                              const SizedBox(height: 5),
                              Text(
                                  'Kilometerstand Start: ${ride.KilometerStart}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87)),
                              const SizedBox(height: 5),
                              Text('Kilometerstand Ende: ${ride.KilometerEnd}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87)),
                              const SizedBox(height: 5),
                              Text('Tank Liter: ${ride.GasLiter}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.black87)),
                              const SizedBox(height: 5),
                              Text('Defekte: ${ride.Defects}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.redAccent)),
                              const SizedBox(height: 5),
                              Text('Fehlende Artikel: ${ride.MissingItems}',
                                  style: const TextStyle(
                                      fontSize: 14, color: Colors.redAccent)),
                            ],
                          ),
                        )
                      : const Center(
                          child: Text(
                            'Keine Fahrt gefunden.',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.red,
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateRidePage()));
        },
        label: const Text(
          'Hinzufügen',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(Icons.add, color: Colors.white, size: 25),
      ),
    );
  }
}
