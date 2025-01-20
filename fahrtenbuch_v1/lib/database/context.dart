import 'package:fahrtenbuch_v1/entities/ride.dart';
import 'package:hive/hive.dart';

class DBContext {
  // Singleton instance
  static final DBContext _instance = DBContext._internal();

  // Factory constructor to return the singleton instance
  factory DBContext() {
    return _instance;
  }

  // Private constructor
  DBContext._internal() {
    accessToken = tokenBox.get('token') ?? '';
    previousCarName = carNameBox.get('name') ?? '';
    personList = personBox.get('persons') ?? [];
    rideList = rideBox.get('rides') ?? [];
    carList = carBox.get('cars') ?? [];
  }

  String accessToken = '';
  String previousCarName = '';
  List personList = [];
  List rideList = [];
  List carList = [];

  final personBox = Hive.box('personBox');
  final rideBox = Hive.box('rideBox');
  final carBox = Hive.box('carBox');
  final tokenBox = Hive.box('tokenBox');
  final carNameBox = Hive.box('carNameBox');
  

  void setToken(String token) {
    accessToken = token;
    tokenBox.put('token', accessToken);
  }

  String getToken() {
    return tokenBox.get('token') ?? '';
  }

  void setPreviousCarName(String name) {
    previousCarName = name;
    carNameBox.put('name', previousCarName);
  }

  String getPreviousCarName() {
    return carNameBox.get('name') ?? '';
  }

  void setRide(Ride ride) {
    rideList.add(ride);
    rideBox.put('rides', rideList);
  }

  List getRides() {
    return rideBox.get('rides') ?? [];
  }

  void clearRides(){
    rideBox.clear();
    rideList = getRides();
  }

  void setPersons(List personList) {
    this.personList = personList;
    personBox.put('persons', this.personList);
  }

  List getDrivers() {
    return personList
        .where(
            (driver) => driver.Roles.any((role) => role.Name == 'Maschinist'))
        .toList();
  }

  List getCommanders() {
    return personList
        .where((commander) =>
            commander.Roles.any((role) => role.Name == 'Kommandant'))
        .toList();
  }

  void setCars(List carList){
    this.carList = carList;
    carBox.put('cars', this.carList);
  }

  List getCars(){
    return carList;
  }

  int getIdByName(String fullname) {
    List<String> splittedName = fullname.split(' ');
    var person = personList.firstWhere((person) =>
        person.FirstName == splittedName[0] &&
        person.LastName == splittedName[1]);
    return person?.Id ?? 0;
  }

  int getCarIdByName(String carName){
    var car = carList.firstWhere((car) => car.CarNumber == carName);
    return car?.Id ?? 0;
  }
}
