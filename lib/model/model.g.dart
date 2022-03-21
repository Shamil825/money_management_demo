// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModelCodeAdapter extends TypeAdapter<ModelCode> {
  @override
  final int typeId = 0;

  @override
  ModelCode read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModelCode(
      categoryname: fields[0] as String,
      isExpense: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ModelCode obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.categoryname)
      ..writeByte(2)
      ..write(obj.isExpense);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModelCodeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
