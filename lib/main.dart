import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:apartment_rental/core/constants.dart';
import 'package:apartment_rental/core/seed_data.dart';
import 'package:apartment_rental/core/router/app_router.dart';
import 'package:apartment_rental/features/property_listing/data/models/apartment_model.dart';
import 'package:apartment_rental/features/property_listing/data/models/owner_model.dart';
import 'package:apartment_rental/features/booking/data/models/booking_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive Init
  await Hive.initFlutter();
  
  // Register Adapters
  Hive.registerAdapter(OwnerModelAdapter());
  Hive.registerAdapter(ApartmentModelAdapter());
  Hive.registerAdapter(BookingModelAdapter());

  // Open Boxes
  final apartmentBox = await Hive.openBox<ApartmentModel>(AppConstants.apartmentBox);
  await Hive.openBox<BookingModel>(AppConstants.bookingBox);
  
  // Seeding
  if (apartmentBox.isEmpty) {
    await apartmentBox.addAll(seedApartments);
    debugPrint('Seeded apartments: ${apartmentBox.length}');
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: router,
      title: 'Apartment Rental',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        fontFamily: 'Poppins', 
      ),
    );
  }
}