// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rideType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RideTypeAdapter extends TypeAdapter<RideType> {
  @override
  final int typeId = 4;

  @override
  RideType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RideType(
      Id: fields[0] as int,
      Name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RideType obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.Id)
      ..writeByte(1)
      ..write(obj.Name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RideTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
