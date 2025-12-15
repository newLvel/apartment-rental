// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'apartment_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ApartmentModelAdapter extends TypeAdapter<ApartmentModel> {
  @override
  final int typeId = 1;

  @override
  ApartmentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ApartmentModel(
      id: fields[0] as String,
      title: fields[1] as String,
      description: fields[2] as String,
      pricePerMonth: fields[3] as double,
      address: fields[4] as String,
      images: (fields[5] as List).cast<String>(),
      bedrooms: fields[6] as int,
      bathrooms: fields[7] as int,
      areaSquareFeet: fields[8] as double,
      amenities: (fields[9] as List).cast<String>(),
      owner: fields[10] as OwnerModel,
      isFeatured: fields[11] as bool,
      isFavorite: fields[12] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ApartmentModel obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.pricePerMonth)
      ..writeByte(4)
      ..write(obj.address)
      ..writeByte(5)
      ..write(obj.images)
      ..writeByte(6)
      ..write(obj.bedrooms)
      ..writeByte(7)
      ..write(obj.bathrooms)
      ..writeByte(8)
      ..write(obj.areaSquareFeet)
      ..writeByte(9)
      ..write(obj.amenities)
      ..writeByte(10)
      ..write(obj.owner)
      ..writeByte(11)
      ..write(obj.isFeatured)
      ..writeByte(12)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ApartmentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
