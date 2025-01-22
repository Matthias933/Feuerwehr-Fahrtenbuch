// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ride.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RideAdapter extends TypeAdapter<Ride> {
  @override
  final int typeId = 2;

  @override
  Ride read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Ride(
      CarId: fields[0] as int,
      DriverId: fields[1] as int,
      CommanderId: fields[2] as int,
      Date: fields[3] as String,
      RideTypeId: fields[4] as int,
      RideDescription: fields[5] as String,
      KilometerStart: fields[6] as int,
      KilometerEnd: fields[7] as int,
      GasLiter: fields[8] as int,
      UsedPowerGenerator: fields[9] as bool,
      PowerGeneratorTankFull: fields[10] as bool,
      UsedRespiratoryProtection: fields[11] as bool,
      RespiratoryProtectionUpgraded: fields[12] as bool,
      UsedCAFS: fields[13] as bool,
      CAFSTankFull: fields[14] as bool,
      Defects: fields[15] as String,
      MissingItems: fields[16] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Ride obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.CarId)
      ..writeByte(1)
      ..write(obj.DriverId)
      ..writeByte(2)
      ..write(obj.CommanderId)
      ..writeByte(3)
      ..write(obj.Date)
      ..writeByte(4)
      ..write(obj.RideTypeId)
      ..writeByte(5)
      ..write(obj.RideDescription)
      ..writeByte(6)
      ..write(obj.KilometerStart)
      ..writeByte(7)
      ..write(obj.KilometerEnd)
      ..writeByte(8)
      ..write(obj.GasLiter)
      ..writeByte(9)
      ..write(obj.UsedPowerGenerator)
      ..writeByte(10)
      ..write(obj.PowerGeneratorTankFull)
      ..writeByte(11)
      ..write(obj.UsedRespiratoryProtection)
      ..writeByte(12)
      ..write(obj.RespiratoryProtectionUpgraded)
      ..writeByte(13)
      ..write(obj.UsedCAFS)
      ..writeByte(14)
      ..write(obj.CAFSTankFull)
      ..writeByte(15)
      ..write(obj.Defects)
      ..writeByte(16)
      ..write(obj.MissingItems);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RideAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
