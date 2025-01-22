class RideType{
  final int Id;

  final String Name;

  RideType({
    required this.Id,
    required this.Name,
  });

  factory RideType.fromJson(Map<String, dynamic> json) {
  return RideType(
    Id: json['id'] as int,
    Name: json['name'] as String,
  );
}

Map<String, dynamic> toJson() {
  return {
    'id': Id,
    'Name': Name,
  };
}
}