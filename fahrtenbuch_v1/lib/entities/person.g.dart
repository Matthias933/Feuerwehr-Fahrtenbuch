// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final int typeId = 0;

  @override
  Person read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Person(
      Id: fields[0] as int,
      FirstName: fields[1] as String,
      LastName: fields[2] as String,
      IsActive: fields[3] as bool,
      Roles: (fields[4] as List).cast<Role>(),
      DriveableCars: (fields[5] as List).cast<Car>(),
    );
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.Id)
      ..writeByte(1)
      ..write(obj.FirstName)
      ..writeByte(2)
      ..write(obj.LastName)
      ..writeByte(3)
      ..write(obj.IsActive)
      ..writeByte(4)
      ..write(obj.Roles)
      ..writeByte(5)
      ..write(obj.DriveableCars);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PersonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
