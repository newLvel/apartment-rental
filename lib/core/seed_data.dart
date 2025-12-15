import '../features/property_listing/data/models/apartment_model.dart';
import '../features/property_listing/data/models/owner_model.dart';

final List<OwnerModel> seedOwners = [
  OwnerModel(
    id: 'owner1',
    name: 'John Doe',
    imageUrl: '', // Placeholder
    phoneNumber: '+1 555 010 999',
  ),
  OwnerModel(
    id: 'owner2',
    name: 'Jane Smith',
    imageUrl: '', // Placeholder
    phoneNumber: '+1 555 010 888',
  ),
];

final List<ApartmentModel> seedApartments = [
  ApartmentModel(
    id: 'apt1',
    title: 'Modern City Apartment',
    description: 'A beautiful modern apartment in the heart of the city. Features stunning views and high-end finishes.',
    pricePerMonth: 2500.0,
    address: '123 Main St, New York, NY',
    images: ['assets/images/apartment_1.png', 'assets/images/apartment_2.webp'],
    bedrooms: 2,
    bathrooms: 2,
    areaSquareFeet: 1200,
    amenities: ['Wifi', 'AC', 'Gym', 'Parking'],
    owner: seedOwners[0],
    isFeatured: true,
  ),
  ApartmentModel(
    id: 'apt2',
    title: 'Cozy Suburban Home',
    description: 'Perfect for a small family. Quiet neighborhood with excellent schools nearby.',
    pricePerMonth: 1800.0,
    address: '456 Elm St, Springfield',
    images: ['assets/images/apartment_3.webp', 'assets/images/apartment_4.webp'],
    bedrooms: 3,
    bathrooms: 2,
    areaSquareFeet: 1500,
    amenities: ['Parking', 'Garden', 'Pet Friendly'],
    owner: seedOwners[1],
  ),
   ApartmentModel(
    id: 'apt3',
    title: 'Luxury Penthouse',
    description: 'Top floor with amazing views of the skyline. Includes private elevator access.',
    pricePerMonth: 5000.0,
    address: '789 High St, Metropolis',
    images: ['assets/images/apartment_5.webp', 'assets/images/apartment_6.png'],
    bedrooms: 4,
    bathrooms: 3,
    areaSquareFeet: 2500,
    amenities: ['Pool', 'Concierge', 'Gym', 'Wifi', 'Smart Home'],
    owner: seedOwners[0],
    isFeatured: true,
  ),
   ApartmentModel(
    id: 'apt4',
    title: 'Studio Loft',
    description: 'Great for singles or couples. Walking distance to cafes and art galleries.',
    pricePerMonth: 1200.0,
    address: '101 Art Ave, Brooklyn',
    images: ['assets/images/apartment_7.png', 'assets/images/apartment_1.png'],
    bedrooms: 1,
    bathrooms: 1,
    areaSquareFeet: 800,
    amenities: ['Wifi', 'AC', 'Laundry'],
    owner: seedOwners[1],
  ),
];
