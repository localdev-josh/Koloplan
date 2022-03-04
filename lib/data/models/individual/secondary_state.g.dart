// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secondary_state.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SecondaryStateAdapter extends TypeAdapter<SecondaryState> {
  @override
  SecondaryState read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SecondaryState(
      isLoggedIn: fields[0] as bool,
      lastMinimized: fields[1] as DateTime,
      password: fields[2] as String,
      email: fields[3] as String,
      biometricsEnabled: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SecondaryState obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.isLoggedIn)
      ..writeByte(1)
      ..write(obj.lastMinimized)
      ..writeByte(2)
      ..write(obj.password)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.biometricsEnabled);
  }

  @override
  int get typeId => 1;
}
