import 'package:uuid/uuid.dart';
import '../features/authentication/data/models/user_model.dart';
import '../features/property_listing/data/models/apartment_model.dart';
import '../features/property_listing/data/models/owner_model.dart';
import '../features/booking/data/models/booking_model.dart';
import '../features/chat/data/models/chat_model.dart';

// Create owners first
final _owner1 = OwnerModel(id: 'owner1', name: 'Alhaji Musa', imageUrl: '', phoneNumber: '+237 677 00 00 01');
final _owner2 = OwnerModel(id: 'owner2', name: 'Madame Kamga', imageUrl: '', phoneNumber: '+237 699 11 22 33');
final _owner3 = OwnerModel(id: 'owner3', name: 'Chief Eko', imageUrl: '', phoneNumber: '+237 655 55 66 77');

final List<OwnerModel> seedOwners = [_owner1, _owner2, _owner3];

// Create login-able users for tenants and owners
final List<UserModel> seedUsers = [
  // Tenants
  UserModel(id: 'user1', email: 'client@cameroon.com', name: 'Ngwa Collins', role: 'client'),
  
  // Owners (with login credentials)
  UserModel(id: _owner1.id, email: 'owner1@cameroon.com', name: _owner1.name, role: 'owner'),
  UserModel(id: _owner2.id, email: 'owner2@cameroon.com', name: _owner2.name, role: 'owner'),
  UserModel(id: _owner3.id, email: 'owner3@cameroon.com', name: _owner3.name, role: 'owner'),
];

// Assign apartments to owners
final List<ApartmentModel> seedApartments = [
  // Apartments for Owner 1
  ApartmentModel(
    id: 'apt1', title: 'Luxury Apt in Bonapriso', description: 'High-end 3-bedroom apartment in a secure residence.', pricePerMonth: 450000.0, address: 'Rue des Palmiers, Bonapriso, Douala',
    images: ['assets/images/minh-pham-OtXADkUh3-I-unsplash.jpg', 'assets/images/francesca-tosolini-tHkJAMcO3QE-unsplash.jpg'],
    bedrooms: 3, bathrooms: 3, areaSquareFeet: 1600, amenities: ['Wifi', 'AC', 'Pool', 'Generator', 'Security'], owner: _owner1, isFeatured: true,
  ),
  ApartmentModel(
    id: 'apt2', title: 'Villa in Bastos', description: 'Prestigious 5-bedroom villa in the diplomatic neighborhood.', pricePerMonth: 800000.0, address: 'Avenue de Gaulle, Bastos, Yaoundé',
    images: ['assets/images/point3d-commercial-imaging-ltd-aeTexYQKsuk-unsplash.jpg', 'assets/images/point3d-commercial-imaging-ltd-Cu2xZLKgn10-unsplash.jpg'],
    bedrooms: 5, bathrooms: 4, areaSquareFeet: 3500, amenities: ['Garden', 'Garage', 'Security', 'AC'], owner: _owner1, isFeatured: true,
  ),
  ApartmentModel(
    id: 'apt3', title: 'Student Residence Molyko', description: 'Affordable studio close to the University of Buea.', pricePerMonth: 60000.0, address: 'Checkpoint, Molyko, Buea',
    images: ['assets/images/isaac-benhesed-1SbJCq-vHpI-unsplash.jpg', 'assets/images/grant-UhpYKnqZwE8-unsplash.jpg'],
    bedrooms: 1, bathrooms: 1, areaSquareFeet: 400, amenities: ['Water', 'Electricity', 'Fenced'], owner: _owner1,
  ),
  ApartmentModel(
    id: 'apt4', title: 'Spacious Flat Up Station', description: 'Secure 3-bedroom flat in Up Station, Bamenda.', pricePerMonth: 120000.0, address: 'Up Station, Bamenda',
    images: ['assets/images/patrick-perkins-iRiVzALa4pI-unsplash.jpg', 'assets/images/naomi-hebert-MP0bgaS_d1c-unsplash.jpg'],
    bedrooms: 3, bathrooms: 2, areaSquareFeet: 1400, amenities: ['Water', 'Fenced', 'Parking'], owner: _owner1,
  ),

  // Apartments for Owner 2
  ApartmentModel(
    id: 'apt5', title: 'Modern Studio in Akwa', description: 'Perfect for business travelers in the business district.', pricePerMonth: 200000.0, address: 'Boulevard de la Liberté, Akwa, Douala',
    images: ['assets/images/patrick-perkins-3wylDrjxH-E-unsplash.jpg', 'assets/images/spacejoy-umAXneH4GhA-unsplash.jpg'],
    bedrooms: 1, bathrooms: 1, areaSquareFeet: 600, amenities: ['Wifi', 'AC', 'Furnished'], owner: _owner2,
  ),
  ApartmentModel(
    id: 'apt6', title: 'Apartment in Omnisport', description: 'Accessible 2-bedroom apartment near the stadium.', pricePerMonth: 150000.0, address: 'Quartier Omnisport, Yaoundé',
    images: ['assets/images/jarek-ceborski-jn7uVeCdf6U-unsplash.jpg', 'assets/images/sonnie-hiles-DhFHtkECn7Q-unsplash.jpg'],
    bedrooms: 2, bathrooms: 2, areaSquareFeet: 1100, amenities: ['Parking', 'Water Heater'], owner: _owner2,
  ),
  ApartmentModel(
    id: 'apt7', title: 'Vacation Home Kribi', description: 'Furnished bungalow for holidays with direct beach access.', pricePerMonth: 400000.0, address: 'Route des Chutes, Kribi',
    images: ['assets/images/hannah-busing-U-k6XLlml1I-unsplash.jpg', 'assets/images/point3d-commercial-imaging-ltd-6GruB-1L9kE-unsplash.jpg'],
    bedrooms: 2, bathrooms: 2, areaSquareFeet: 1000, amenities: ['Beach Access', 'Furnished', 'AC'], owner: _owner2, isFeatured: true,
  ),
   ApartmentModel(
    id: 'apt8', title: 'Modern Loft in Bonanjo', description: 'Chic loft in the administrative center of Douala.', pricePerMonth: 300000.0, address: 'Bonanjo, Douala',
    images: ['assets/images/francesca-tosolini-XyGvEj587Mc-unsplash.jpg', 'assets/images/ian-dooley-_-JR5TxKNSo-unsplash.jpg'],
    bedrooms: 1, bathrooms: 1, areaSquareFeet: 900, amenities: ['Wifi', 'AC', 'Security', 'Gym'], owner: _owner2, isFeatured: true,
  ),

  // Apartments for Owner 3
  ApartmentModel(
    id: 'apt9', title: 'Family House in GRA', description: 'Quiet 3-bedroom house in Buea with a scenic view.', pricePerMonth: 250000.0, address: 'GRA, Buea',
    images: ['assets/images/cytonn-photography-76JYlSoAYM4-unsplash.jpg', 'assets/images/timothy-buck-psrloDbaZc8-unsplash.jpg'],
    bedrooms: 3, bathrooms: 2, areaSquareFeet: 1800, amenities: ['Garden', 'Parking', 'Fireplace'], owner: _owner3, isFeatured: true,
  ),
  ApartmentModel(
    id: 'apt10', title: 'Seaside Apartment', description: 'Relaxing 2-bedroom apartment in Limbe with an ocean view.', pricePerMonth: 300000.0, address: 'Down Beach, Limbe',
    images: ['assets/images/huy-nguyen-AB-q9lwCVv8-unsplash.jpg', 'assets/images/huy-nguyen-9vvp_nuVaJk-unsplash.jpg'],
    bedrooms: 2, bathrooms: 2, areaSquareFeet: 1200, amenities: ['Ocean View', 'AC', 'Terrace'], owner: _owner3, isFeatured: true,
  ),
  ApartmentModel(
    id: 'apt11', title: 'Residence in Bafoussam', description: 'New building with modern amenities, close to the market.', pricePerMonth: 90000.0, address: 'Quartier Haoussa, Bafoussam',
    images: ['assets/images/norbert-levajsics-oTJ92KUXHls-unsplash.jpg', 'assets/images/deborah-cortelazzi-gREquCUXQLI-unsplash.jpg'],
    bedrooms: 2, bathrooms: 1, areaSquareFeet: 1000, amenities: ['Water', 'Electricity'], owner: _owner3,
  ),
];


// Seed Bookings to make the Tenant Dashboard functional
final List<BookingModel> seedBookings = [
  BookingModel(
    id: 'booking1', apartmentId: 'apt1', userId: 'user1',
    startDate: DateTime(2023, 1, 1), endDate: DateTime(2023, 12, 31),
    status: 'confirmed', totalPrice: 450000.0 * 12,
  ),
];

// Seed Chat data to make the Chat interface functional
final List<ChatConversationModel> seedConversations = [
  ChatConversationModel(
    id: 'convo1', participantIds: ['user1', 'owner1'],
    lastMessage: 'Yes, it is available for viewing tomorrow.',
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
];

final List<ChatMessageModel> seedMessages = [
  ChatMessageModel(
    id: const Uuid().v4(), conversationId: 'convo1', senderId: 'user1',
    text: 'Hello, is the Bonapriso apartment available for viewing?',
    timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
  ),
  ChatMessageModel(
    id: const Uuid().v4(), conversationId: 'convo1', senderId: 'owner1',
    text: 'Yes, it is available for viewing tomorrow.',
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
];
