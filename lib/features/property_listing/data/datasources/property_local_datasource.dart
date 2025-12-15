import 'package:hive_flutter/hive_flutter.dart';
import '../models/apartment_model.dart';

abstract class PropertyLocalDataSource {
  Future<List<ApartmentModel>> getApartments();
  Future<void> toggleFavorite(String id);
  Future<void> addApartment(ApartmentModel apartment);
}

class PropertyLocalDataSourceImpl implements PropertyLocalDataSource {
  final Box<ApartmentModel> apartmentBox;

  PropertyLocalDataSourceImpl(this.apartmentBox);

  // Note: Seeding is handled in main.dart or a separate service for simplicity

  @override
  Future<List<ApartmentModel>> getApartments() async {
    return apartmentBox.values.toList();
  }

  @override
  Future<void> toggleFavorite(String id) async {
    final apartment = apartmentBox.values.firstWhere((e) => e.id == id);
    final updatedApartment = apartment.copyWith(isFavorite: !apartment.isFavorite);
    
    // Find key to update
    final key = apartmentBox.keyAt(apartmentBox.values.toList().indexOf(apartment));
    await apartmentBox.put(key, updatedApartment);
  }

  @override
  Future<void> addApartment(ApartmentModel apartment) async {
    await apartmentBox.put(apartment.id, apartment);
  }
}
