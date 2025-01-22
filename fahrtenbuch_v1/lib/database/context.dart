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
    previousKilometer = kilometerBox.get('kilometer') ?? 0; 
    personList = personBox.get('persons') ?? [];
    rideList = rideBox.get('rides') ?? [];
    carList = carBox.get('cars') ?? [];
    rideTypeList = rideTypeBox.get('rideTypes') ?? [];
    previousRide = previousRideBox.get('previousRide');
  }

  String accessToken = '';
  String previousCarName = '';
  int previousKilometer = 0;
  Ride? previousRide;
  List personList = [];
  List rideList = [];
  List carList = [];
  List rideTypeList = [];

  final personBox = Hive.box('personBox');
  final rideBox = Hive.box('rideBox');
  final carBox = Hive.box('carBox');
  final tokenBox = Hive.box('tokenBox');
  final carNameBox = Hive.box('carNameBox');
  final kilometerBox = Hive.box('kilometerBox');
  final rideTypeBox = Hive.box('rideTypeBox');
  final previousRideBox = Hive.box('previousRideBox');
  

  void setToken(String token) {
    accessToken = token;
    tokenBox.put('token', accessToken);
  }

  String getToken() {
    return tokenBox.get('token') ?? '';
  }

  void setPreviousRide(Ride ride){
    previousRide = ride;
    previousRideBox.put('previousRide', ride);
  }

  Ride? getPreviousRide(){
    return previousRideBox.get('previousRide');
  }

  void setPreviousKilometer(int kilometer){
    previousKilometer = kilometer;
    kilometerBox.put('kilometer', previousKilometer);
  }

  int getPreviousKilometeR(){
    return kilometerBox.get('kilometer') ?? 0;
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

  List getRideTypes(){
    return rideTypeList;
  }

  void setRideTypes(List rideTypes){
    rideTypeList = rideTypes;
    rideTypeBox.put('rideTypes', rideTypeList);
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

  int getRideTypeIdByName(String rideTypeName){
    var rideType = rideTypeList.firstWhere((rideType) => rideType.Name == rideTypeName);
    return rideType.Id ?? 0;
  }

  String getPersonNameById(int id){
    try{
      return '${personList.firstWhere((person) => person.Id == id).FirstName} ${personList.firstWhere((person) => person.Id == id).LastName}';
    }
    catch(e){
      return 'Nicht gefunden';
    }
  }

  String getCarNameById(int id){
    try{
      return '${carList.firstWhere((car) => car.Id == id).CarNumber}';
    }
    catch(e){
      return 'Nicht gefunden';
    }
  }

  String getRideTypeNameById(int id){
    try{
      return '${rideTypeList.firstWhere((rideType) => rideType.Id == id).Name}';
    }
    catch(e){
      return 'Nicht gefunden';
    }
  }
}
