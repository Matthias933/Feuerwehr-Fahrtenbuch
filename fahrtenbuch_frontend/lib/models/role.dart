class Role {
  final int? Id;
  final String Name;

  Role({
    this.Id,
    required this.Name,
  });

   factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      Id: json['id'] as int,
      Name: json['name'] as String,
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'id': Id,
      'name': Name,
    };
  }
}
