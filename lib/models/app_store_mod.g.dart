// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_store_mod.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AppStoreModelAdapter extends TypeAdapter<AppStoreModel> {
  @override
  final int typeId = 0;

  @override
  AppStoreModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AppStoreModel(
      appOrder: fields[0] as int?,
      name: fields[1] as String?,
      appId: fields[2] as String?,
      img: fields[3] as String?,
      url: fields[4] as String?,
      appInstalled: fields[5] as String?,
      progress: fields[6] as int?,
      isChecked: fields[7] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, AppStoreModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.appOrder)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.appId)
      ..writeByte(3)
      ..write(obj.img)
      ..writeByte(4)
      ..write(obj.url)
      ..writeByte(5)
      ..write(obj.appInstalled)
      ..writeByte(6)
      ..write(obj.progress)
      ..writeByte(7)
      ..write(obj.isChecked);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppStoreModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
