import 'package:hive_flutter/hive_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constants.dart';
import '../../data/datasources/property_local_datasource.dart';
import '../../data/models/apartment_model.dart';
import '../../data/repositories/property_repository_impl.dart';
import '../../domain/entities/apartment.dart';
import '../../domain/repositories/property_repository.dart';

part 'property_providers.g.dart';

@riverpod
PropertyLocalDataSource propertyLocalDataSource(PropertyLocalDataSourceRef ref) {
  final box = Hive.box<ApartmentModel>(AppConstants.apartmentBox);
  return PropertyLocalDataSourceImpl(box);
}

@riverpod
PropertyRepository propertyRepository(PropertyRepositoryRef ref) {
  final dataSource = ref.watch(propertyLocalDataSourceProvider);
  return PropertyRepositoryImpl(dataSource);
}

@riverpod
Future<List<Apartment>> allApartments(AllApartmentsRef ref) async {
  final repository = ref.watch(propertyRepositoryProvider);
  return repository.getAllApartments();
}

@riverpod
Future<List<Apartment>> featuredApartments(FeaturedApartmentsRef ref) async {
  final repository = ref.watch(propertyRepositoryProvider);
  return repository.getFeaturedApartments();
}

@riverpod
class PropertyController extends _$PropertyController {
  @override
  FutureOr<void> build() {}

  Future<void> toggleFavorite(String id) async {
    final repository = ref.read(propertyRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repository.toggleFavorite(id);
      ref.invalidate(allApartmentsProvider);
      ref.invalidate(featuredApartmentsProvider);
    });
  }

  Future<void> addApartment(Apartment apartment) async {
    final repository = ref.read(propertyRepositoryProvider);
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await repository.addApartment(apartment);
      ref.invalidate(allApartmentsProvider);
      // Also invalidate owner specific provider if possible, but it depends on parameters
      // ref.invalidate(apartmentsByOwnerProvider(apartment.owner.id)); 
      // Since it's a family, we might need to invalidate widely or specifically.
      // For now, let's just assume we might need to refresh manually or structure providers better.
      // But invalidating allApartmentsProvider is base.
    });
  }
}

@riverpod
Future<List<Apartment>> apartmentsByOwner(ApartmentsByOwnerRef ref, String ownerId) async {
  final repository = ref.watch(propertyRepositoryProvider);
  final allApartments = await repository.getAllApartments();
  return allApartments.where((apt) => apt.owner.id == ownerId).toList();
}
