import 'package:hive/hive.dart';

part 'owner_model.g.dart';

@HiveType(typeId: 0)
class OwnerModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final String phoneNumber;

  OwnerModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.phoneNumber,
  });

  // For mapping to entity
  OwnerModel copyWith({
    String? id,
    String? name,
    String? imageUrl,
    String? phoneNumber,
  }) {
    return OwnerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}