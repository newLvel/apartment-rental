// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$propertyLocalDataSourceHash() =>
    r'fc487975ad98a07739d710a647cb7f52165bc5c4';

/// See also [propertyLocalDataSource].
@ProviderFor(propertyLocalDataSource)
final propertyLocalDataSourceProvider =
    AutoDisposeProvider<PropertyLocalDataSource>.internal(
  propertyLocalDataSource,
  name: r'propertyLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$propertyLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PropertyLocalDataSourceRef
    = AutoDisposeProviderRef<PropertyLocalDataSource>;
String _$propertyRepositoryHash() =>
    r'0e4dbfe5e2c82b1ffafeed58303e0f35ae53f0b4';

/// See also [propertyRepository].
@ProviderFor(propertyRepository)
final propertyRepositoryProvider =
    AutoDisposeProvider<PropertyRepository>.internal(
  propertyRepository,
  name: r'propertyRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$propertyRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PropertyRepositoryRef = AutoDisposeProviderRef<PropertyRepository>;
String _$allApartmentsHash() => r'86d866a71a45772aebb5459e09353a413ac95cd7';

/// See also [allApartments].
@ProviderFor(allApartments)
final allApartmentsProvider =
    AutoDisposeFutureProvider<List<Apartment>>.internal(
  allApartments,
  name: r'allApartmentsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allApartmentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllApartmentsRef = AutoDisposeFutureProviderRef<List<Apartment>>;
String _$featuredApartmentsHash() =>
    r'95a7f1f3b03f01e03964b519e5113e949917fe96';

/// See also [featuredApartments].
@ProviderFor(featuredApartments)
final featuredApartmentsProvider =
    AutoDisposeFutureProvider<List<Apartment>>.internal(
  featuredApartments,
  name: r'featuredApartmentsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$featuredApartmentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FeaturedApartmentsRef = AutoDisposeFutureProviderRef<List<Apartment>>;
String _$apartmentsByOwnerHash() => r'36c48250d491cac94c65d8156db9ecb664f62be3';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [apartmentsByOwner].
@ProviderFor(apartmentsByOwner)
const apartmentsByOwnerProvider = ApartmentsByOwnerFamily();

/// See also [apartmentsByOwner].
class ApartmentsByOwnerFamily extends Family<AsyncValue<List<Apartment>>> {
  /// See also [apartmentsByOwner].
  const ApartmentsByOwnerFamily();

  /// See also [apartmentsByOwner].
  ApartmentsByOwnerProvider call(
    String ownerId,
  ) {
    return ApartmentsByOwnerProvider(
      ownerId,
    );
  }

  @override
  ApartmentsByOwnerProvider getProviderOverride(
    covariant ApartmentsByOwnerProvider provider,
  ) {
    return call(
      provider.ownerId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'apartmentsByOwnerProvider';
}

/// See also [apartmentsByOwner].
class ApartmentsByOwnerProvider
    extends AutoDisposeFutureProvider<List<Apartment>> {
  /// See also [apartmentsByOwner].
  ApartmentsByOwnerProvider(
    String ownerId,
  ) : this._internal(
          (ref) => apartmentsByOwner(
            ref as ApartmentsByOwnerRef,
            ownerId,
          ),
          from: apartmentsByOwnerProvider,
          name: r'apartmentsByOwnerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$apartmentsByOwnerHash,
          dependencies: ApartmentsByOwnerFamily._dependencies,
          allTransitiveDependencies:
              ApartmentsByOwnerFamily._allTransitiveDependencies,
          ownerId: ownerId,
        );

  ApartmentsByOwnerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ownerId,
  }) : super.internal();

  final String ownerId;

  @override
  Override overrideWith(
    FutureOr<List<Apartment>> Function(ApartmentsByOwnerRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ApartmentsByOwnerProvider._internal(
        (ref) => create(ref as ApartmentsByOwnerRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ownerId: ownerId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Apartment>> createElement() {
    return _ApartmentsByOwnerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ApartmentsByOwnerProvider && other.ownerId == ownerId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ownerId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ApartmentsByOwnerRef on AutoDisposeFutureProviderRef<List<Apartment>> {
  /// The parameter `ownerId` of this provider.
  String get ownerId;
}

class _ApartmentsByOwnerProviderElement
    extends AutoDisposeFutureProviderElement<List<Apartment>>
    with ApartmentsByOwnerRef {
  _ApartmentsByOwnerProviderElement(super.provider);

  @override
  String get ownerId => (origin as ApartmentsByOwnerProvider).ownerId;
}

String _$propertyControllerHash() =>
    r'9006661fb96ffad2882b6099c275ad43b7a93ca6';

/// See also [PropertyController].
@ProviderFor(PropertyController)
final propertyControllerProvider =
    AutoDisposeAsyncNotifierProvider<PropertyController, void>.internal(
  PropertyController.new,
  name: r'propertyControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$propertyControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PropertyController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
