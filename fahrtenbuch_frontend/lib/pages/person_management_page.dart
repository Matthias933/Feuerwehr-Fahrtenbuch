import 'package:fahrtenbuch_frontend/util/person/person_management.dart';
import 'package:flutter/material.dart';

class PersonManagementPage extends StatefulWidget {
  const PersonManagementPage({super.key});

  @override
  State<PersonManagementPage> createState() => _PersonManagementPageState();
}

class _PersonManagementPageState extends State<PersonManagementPage> {
  late PersonManagement personManagement;

  @override
  void initState() {
    super.initState();
    personManagement = PersonManagement(context: context, setStateCallback: () {setState(() {});});
    personManagement.fetchPeople();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: PersonManagement.persons.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              shrinkWrap: true,
              itemCount: PersonManagement.persons.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    '${PersonManagement.persons[index].FirstName} ${PersonManagement.persons[index].LastName}',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: SizedBox(
                    width: 80,
                    child: Row(
                      mainAxisSize: MainAxisSize.min, 
                      children: [
                        IconButton(onPressed: () => personManagement.editPerson(index), icon: Icon(Icons.edit)),
                        IconButton(onPressed: () => personManagement.deletePerson(index), icon: Icon(Icons.delete, color: Colors.red,)),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
