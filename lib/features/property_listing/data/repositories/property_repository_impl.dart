import '../../domain/entities/apartment.dart';
import '../../domain/entities/owner.dart';
import '../../domain/repositories/property_repository.dart';
import '../datasources/property_local_datasource.dart';
import '../models/apartment_model.dart';
import '../models/owner_model.dart';

class PropertyRepositoryImpl implements PropertyRepository {
  final PropertyLocalDataSource localDataSource;

  PropertyRepositoryImpl(this.localDataSource);

  @override
  Future<List<Apartment>> getAllApartments() async {
    final models = await localDataSource.getApartments();
    return models.map((m) => m.toEntity()).toList();
  }

  @override
  Future<List<Apartment>> getFeaturedApartments() async {
    final models = await localDataSource.getApartments();
    return models.where((m) => m.isFeatured).map((m) => m.toEntity()).toList();
  }

  @override
  Future<void> toggleFavorite(String id) async {
    await localDataSource.toggleFavorite(id);
  }

  @override
  Future<void> addApartment(Apartment apartment) async {
    final model = ApartmentModel(
      id: apartment.id,
      title: apartment.title,
      description: apartment.description,
      pricePerMonth: apartment.pricePerMonth,
      address: apartment.address,
      images: apartment.images,
      bedrooms: apartment.bedrooms,
      bathrooms: apartment.bathrooms,
      areaSquareFeet: apartment.areaSquareFeet,
      amenities: apartment.amenities,
      owner: OwnerModel(
        id: apartment.owner.id,
        name: apartment.owner.name,
        imageUrl: apartment.owner.imageUrl,
        phoneNumber: apartment.owner.phoneNumber,
      ),
      isFeatured: apartment.isFeatured,
      isFavorite: apartment.isFavorite,
    );
    await localDataSource.addApartment(model);
  }
}

extension ApartmentModelX on ApartmentModel {
  Apartment toEntity() {
    return Apartment(
      id: id,
      title: title,
      description: description,
      pricePerMonth: pricePerMonth,
      address: address,
      images: images,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      areaSquareFeet: areaSquareFeet,
      amenities: amenities,
      owner: owner.toEntity(),
      isFeatured: isFeatured,
      isFavorite: isFavorite,
    );
  }
}

extension OwnerModelX on OwnerModel {
  Owner toEntity() {
    return Owner(
      id: id,
      name: name,
      imageUrl: imageUrl,
      phoneNumber: phoneNumber,
    );
  }
}
