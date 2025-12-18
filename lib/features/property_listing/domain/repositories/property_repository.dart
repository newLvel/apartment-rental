import '../entities/apartment.dart';

abstract class PropertyRepository {
  Future<List<Apartment>> getFeaturedApartments();
  Future<List<Apartment>> getAllApartments();
  Future<void> toggleFavorite(String id);
  Future<void> addApartment(Apartment apartment);
  Future<void> updateApartment(Apartment apartment);
}
