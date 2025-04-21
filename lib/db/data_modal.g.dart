// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_modal.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentModalAdapter extends TypeAdapter<StudentModal> {
  @override
  final int typeId = 1;

  @override
  StudentModal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentModal(
      name: fields[1] as String,
      age: fields[2] as String,
      id: fields[0] as int?,
      week: fields[3] as String,
      gender: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, StudentModal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.age)
      ..writeByte(3)
      ..write(obj.week)
      ..writeByte(4)
      ..write(obj.gender);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
