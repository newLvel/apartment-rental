import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:apartment_rental/core/constants.dart';
import 'package:apartment_rental/core/seed_data.dart';
import 'package:apartment_rental/core/router/app_router.dart';
import 'package:apartment_rental/features/property_listing/data/models/apartment_model.dart';
import 'package:apartment_rental/features/property_listing/data/models/owner_model.dart';
import 'package:apartment_rental/features/booking/data/models/booking_model.dart';
import 'package:apartment_rental/features/authentication/data/models/user_model.dart';
import 'package:apartment_rental/features/chat/data/models/chat_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Hive Init
  await Hive.initFlutter();
  
  // Register Adapters
  Hive.registerAdapter(OwnerModelAdapter());
  Hive.registerAdapter(ApartmentModelAdapter());
  Hive.registerAdapter(BookingModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(ChatConversationModelAdapter());
  Hive.registerAdapter(ChatMessageModelAdapter());

  // Open Boxes
  final apartmentBox = await Hive.openBox<ApartmentModel>(AppConstants.apartmentBox);
  final userBox = await Hive.openBox<UserModel>(AppConstants.userBox);
  final bookingBox = await Hive.openBox<BookingModel>(AppConstants.bookingBox);
  final conversationBox = await Hive.openBox<ChatConversationModel>(AppConstants.conversationBox);
  final messageBox = await Hive.openBox<ChatMessageModel>(AppConstants.messageBox);
  await Hive.openBox<String>(AppConstants.userPreferencesBox);
  
  // RESET & SEED
  await apartmentBox.clear();
  await userBox.clear();
  await bookingBox.clear();
  await conversationBox.clear();
  await messageBox.clear();
  
  await apartmentBox.addAll(seedApartments.map((a) => MapEntry(a.id, a)).toList().map((e) => e.value));
  await userBox.addAll(seedUsers.map((u) => MapEntry(u.id, u)).toList().map((e) => e.value));
  await bookingBox.addAll(seedBookings.map((b) => MapEntry(b.id, b)).toList().map((e) => e.value));
  await conversationBox.addAll(seedConversations.map((c) => MapEntry(c.id, c)).toList().map((e) => e.value));
  await messageBox.addAll(seedMessages.map((m) => MapEntry(m.id, m)).toList().map((e) => e.value));
  
debugPrint('Database Cleared & Seeded');

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      routerConfig: router,
      title: 'Apartment Rental CM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFE85D32), // Cameroonian Clay/Earth tone match? Or just the Orange
          primary: const Color(0xFFE85D32),
        ),
        useMaterial3: true,
        fontFamily: 'Poppins', 
      ),
    );
  }
}