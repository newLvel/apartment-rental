import 'package:hive/hive.dart';
import 'owner_model.dart'; // Import OwnerModel

part 'apartment_model.g.dart';

@HiveType(typeId: 1)
class ApartmentModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final double pricePerMonth;
  @HiveField(4)
  final String address;
  @HiveField(5)
  final List<String> images;
  @HiveField(6)
  final int bedrooms;
  @HiveField(7)
  final int bathrooms;
  @HiveField(8)
  final double areaSquareFeet;
  @HiveField(9)
  final List<String> amenities;
  @HiveField(10)
  final OwnerModel owner; // Use OwnerModel here
  @HiveField(11)
  final bool isFeatured;
  @HiveField(12)
  final bool isFavorite;

  ApartmentModel({
    required this.id,
    required this.title,
    required this.description,
    required this.pricePerMonth,
    required this.address,
    required this.images,
    required this.bedrooms,
    required this.bathrooms,
    required this.areaSquareFeet,
    required this.amenities,
    required this.owner,
    this.isFeatured = false,
    this.isFavorite = false,
  });

  ApartmentModel copyWith({
    String? id,
    String? title,
    String? description,
    double? pricePerMonth,
    String? address,
    List<String>? images,
    int? bedrooms,
    int? bathrooms,
    double? areaSquareFeet,
    List<String>? amenities,
    OwnerModel? owner,
    bool? isFeatured,
    bool? isFavorite,
  }) {
    return ApartmentModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      pricePerMonth: pricePerMonth ?? this.pricePerMonth,
      address: address ?? this.address,
      images: images ?? this.images,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      areaSquareFeet: areaSquareFeet ?? this.areaSquareFeet,
      amenities: amenities ?? this.amenities,
      owner: owner ?? this.owner,
      isFeatured: isFeatured ?? this.isFeatured,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}