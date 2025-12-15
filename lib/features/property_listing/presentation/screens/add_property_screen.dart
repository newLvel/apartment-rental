import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:apartment_rental/features/property_listing/domain/entities/apartment.dart';
import 'package:apartment_rental/features/property_listing/domain/entities/owner.dart';
import 'package:apartment_rental/features/property_listing/presentation/providers/property_providers.dart';

class AddPropertyScreen extends ConsumerStatefulWidget {
  const AddPropertyScreen({super.key});

  @override
  ConsumerState<AddPropertyScreen> createState() => _AddPropertyScreenState();
}

class _AddPropertyScreenState extends ConsumerState<AddPropertyScreen> {
  final _formKey = GlobalKey<FormState>();
  
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _addressController = TextEditingController();
  final _bedroomsController = TextEditingController();
  final _bathroomsController = TextEditingController();
  final _areaController = TextEditingController();
  
  // Amenities selection
  final Map<String, bool> _amenities = {
    'Wifi': false,
    'AC': false,
    'Gym': false,
    'Parking': false,
    'Pool': false,
    'Pet Friendly': false,
    'Garden': false,
  };

  // Image selection
  final List<String> _availableImages = [
    'assets/images/apartment_1.png',
    'assets/images/apartment_2.webp',
    'assets/images/apartment_3.webp',
    'assets/images/apartment_4.webp',
    'assets/images/apartment_5.webp',
  ];
  String? _selectedImage;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _addressController.dispose();
    _bedroomsController.dispose();
    _bathroomsController.dispose();
    _areaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controllerState = ref.watch(propertyControllerProvider);
    final isLoading = controllerState.isLoading;

    ref.listen(propertyControllerProvider, (previous, next) {
      if (!next.isLoading && !next.hasError && previous?.isLoading == true) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Property Added Successfully!')));
        context.pop();
      } else if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${next.error}')));
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Add New Property')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               // Image Picker (Simulation)
              const Text('Property Image', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              SizedBox(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _availableImages.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final imagePath = _availableImages[index];
                    final isSelected = _selectedImage == imagePath;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedImage = imagePath),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          border: isSelected ? Border.all(color: Colors.blue, width: 3) : null,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(imagePath, fit: BoxFit.cover),
                        ),
                      ),
                    );
                  },
                ),
              ),
              if (_selectedImage == null)
                 const Padding(
                   padding: EdgeInsets.only(top: 4.0),
                   child: Text('Please select an image', style: TextStyle(color: Colors.red, fontSize: 12)),
                 ),
              const SizedBox(height: 16),

              _buildTextField(_titleController, 'Title', 'e.g., Luxury Condo'),
              const SizedBox(height: 16),
              _buildTextField(_addressController, 'Address', 'e.g., 123 Main St'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField(_priceController, 'Price/Month', 'e.g., 2000', isNumber: true)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(_areaController, 'Area (sqft)', 'e.g., 1200', isNumber: true)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: _buildTextField(_bedroomsController, 'Bedrooms', 'e.g., 2', isNumber: true)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildTextField(_bathroomsController, 'Bathrooms', 'e.g., 2', isNumber: true)),
                ],
              ),
              const SizedBox(height: 16),
              _buildTextField(_descriptionController, 'Description', 'Describe the property...', maxLines: 3),
              const SizedBox(height: 24),
              const Text('Amenities', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 16,
                runSpacing: 8,
                children: _amenities.keys.map((key) {
                  return FilterChip(
                    label: Text(key),
                    selected: _amenities[key]!,
                    onSelected: (bool value) {
                      setState(() {
                        _amenities[key] = value;
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: isLoading 
                    ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white))
                    : const Text('Add Property'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, String hint, {bool isNumber = false, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Required';
        }
        return null;
      },
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() && _selectedImage != null) {
      final selectedAmenities = _amenities.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      final newApartment = Apartment(
        id: const Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        pricePerMonth: double.parse(_priceController.text),
        address: _addressController.text,
        images: [_selectedImage!], // Use selected image
        bedrooms: int.parse(_bedroomsController.text),
        bathrooms: int.parse(_bathroomsController.text),
        areaSquareFeet: double.parse(_areaController.text),
        amenities: selectedAmenities,
        owner: const Owner(
          id: 'owner1', // Hardcoded for this POC
          name: 'Current Owner',
          imageUrl: '',
          phoneNumber: '123-456-7890',
        ),
        isFeatured: false,
        isFavorite: false,
      );

      ref.read(propertyControllerProvider.notifier).addApartment(newApartment);
    } else if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select an image')));
    }
  }
}
