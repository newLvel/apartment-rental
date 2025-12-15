// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$bookingLocalDataSourceHash() =>
    r'd2ee9d0dcf3293c7dee24a964207f05220d0e1f6';

/// See also [bookingLocalDataSource].
@ProviderFor(bookingLocalDataSource)
final bookingLocalDataSourceProvider =
    AutoDisposeProvider<BookingLocalDataSource>.internal(
  bookingLocalDataSource,
  name: r'bookingLocalDataSourceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookingLocalDataSourceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookingLocalDataSourceRef
    = AutoDisposeProviderRef<BookingLocalDataSource>;
String _$bookingRepositoryHash() => r'5bde2095f5ec36bfea57706fa0431762b9cb4137';

/// See also [bookingRepository].
@ProviderFor(bookingRepository)
final bookingRepositoryProvider =
    AutoDisposeProvider<BookingRepository>.internal(
  bookingRepository,
  name: r'bookingRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookingRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BookingRepositoryRef = AutoDisposeProviderRef<BookingRepository>;
String _$userBookingsHash() => r'bf49d87bf35095139a49bf36616b9294cf682fcd';

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

/// See also [userBookings].
@ProviderFor(userBookings)
const userBookingsProvider = UserBookingsFamily();

/// See also [userBookings].
class UserBookingsFamily extends Family<AsyncValue<List<Booking>>> {
  /// See also [userBookings].
  const UserBookingsFamily();

  /// See also [userBookings].
  UserBookingsProvider call(
    String userId,
  ) {
    return UserBookingsProvider(
      userId,
    );
  }

  @override
  UserBookingsProvider getProviderOverride(
    covariant UserBookingsProvider provider,
  ) {
    return call(
      provider.userId,
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
  String? get name => r'userBookingsProvider';
}

/// See also [userBookings].
class UserBookingsProvider extends AutoDisposeFutureProvider<List<Booking>> {
  /// See also [userBookings].
  UserBookingsProvider(
    String userId,
  ) : this._internal(
          (ref) => userBookings(
            ref as UserBookingsRef,
            userId,
          ),
          from: userBookingsProvider,
          name: r'userBookingsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userBookingsHash,
          dependencies: UserBookingsFamily._dependencies,
          allTransitiveDependencies:
              UserBookingsFamily._allTransitiveDependencies,
          userId: userId,
        );

  UserBookingsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<List<Booking>> Function(UserBookingsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserBookingsProvider._internal(
        (ref) => create(ref as UserBookingsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Booking>> createElement() {
    return _UserBookingsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserBookingsProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserBookingsRef on AutoDisposeFutureProviderRef<List<Booking>> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserBookingsProviderElement
    extends AutoDisposeFutureProviderElement<List<Booking>>
    with UserBookingsRef {
  _UserBookingsProviderElement(super.provider);

  @override
  String get userId => (origin as UserBookingsProvider).userId;
}

String _$bookingControllerHash() => r'e6cd76213e627e9d83f3ed642f67e8f186f2e89b';

/// See also [BookingController].
@ProviderFor(BookingController)
final bookingControllerProvider =
    AutoDisposeAsyncNotifierProvider<BookingController, void>.internal(
  BookingController.new,
  name: r'bookingControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookingControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BookingController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
