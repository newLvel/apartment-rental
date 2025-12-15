import 'owner.dart';

class Apartment {
  final String id;
  final String title;
  final String description;
  final double pricePerMonth;
  final String address;
  final List<String> images;
  final int bedrooms;
  final int bathrooms;
  final double areaSquareFeet;
  final List<String> amenities;
  final Owner owner;
  final bool isFeatured;
  final bool isFavorite;

  const Apartment({
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
    required this.isFeatured,
    required this.isFavorite,
  });
}
