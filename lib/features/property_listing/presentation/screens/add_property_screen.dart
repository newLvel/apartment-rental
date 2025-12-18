import 'dart:io'; // Import for File class

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'package:uuid/uuid.dart';
import 'package:apartment_rental/features/property_listing/domain/entities/apartment.dart';
import 'package:apartment_rental/features/property_listing/domain/entities/owner.dart';
import 'package:apartment_rental/features/property_listing/presentation/providers/property_providers.dart';
import 'package:apartment_rental/features/authentication/presentation/providers/auth_provider.dart';

class AddPropertyScreen extends ConsumerStatefulWidget {
  final Apartment? apartment; // Make apartment optional

  const AddPropertyScreen({super.key, this.apartment});

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
  
  // Image picker
  String? _selectedImagePath;
  final ImagePicker _picker = ImagePicker();

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

  @override
  void initState() {
    super.initState();
    if (widget.apartment != null) {
      final apt = widget.apartment!;
      _titleController.text = apt.title;
      _descriptionController.text = apt.description;
      _priceController.text = apt.pricePerMonth.toString();
      _addressController.text = apt.address;
      _bedroomsController.text = apt.bedrooms.toString();
      _bathroomsController.text = apt.bathrooms.toString();
      _areaController.text = apt.areaSquareFeet.toString();
      _selectedImagePath = apt.images.isNotEmpty ? apt.images.first : null;
      for (var amenity in apt.amenities) {
        if (_amenities.containsKey(amenity)) {
          _amenities[amenity] = true;
        }
      }
    }
  }

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

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _selectedImagePath = image?.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    final controllerState = ref.watch(propertyControllerProvider);
    final isLoading = controllerState.isLoading;
    final isEditMode = widget.apartment != null;

    ref.listen(propertyControllerProvider, (previous, next) {
      if (!next.isLoading && !next.hasError && previous?.isLoading == true) {
        // Success
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Property ${isEditMode ? 'Updated' : 'Added'} Successfully!')));
        context.pop();
      } else if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${next.error}')));
      }
    });

    return Scaffold(
      appBar: AppBar(title: Text(isEditMode ? 'Edit Property' : 'Add New Property')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               const Text('Property Image', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: _selectedImagePath == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, color: Colors.grey[600], size: 40),
                            const SizedBox(height: 8),
                            Text('Tap to select image', style: TextStyle(color: Colors.grey[600])),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            File(_selectedImagePath!),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => 
                                const Center(child: Text('Error loading image')),
                          ),
                        ),
                ),
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
                    : Text(isEditMode ? 'Update Property' : 'Add Property'),
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
    if (_formKey.currentState!.validate() && _selectedImagePath != null) {
      final currentUser = ref.read(authNotifierProvider).value;
      if (currentUser == null || currentUser.role != UserRole.owner.name) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('You must be logged in as an owner.')));
        return;
      }
      final selectedAmenities = _amenities.entries
          .where((entry) => entry.value)
          .map((entry) => entry.key)
          .toList();

      final apartmentData = Apartment(
        id: widget.apartment?.id ?? const Uuid().v4(),
        title: _titleController.text,
        description: _descriptionController.text,
        pricePerMonth: double.parse(_priceController.text),
        address: _addressController.text,
        images: [_selectedImagePath!],
        bedrooms: int.parse(_bedroomsController.text),
        bathrooms: int.parse(_bathroomsController.text),
        areaSquareFeet: double.parse(_areaController.text),
        amenities: selectedAmenities,
        owner: Owner(
          id: currentUser.id,
          name: currentUser.name,
          imageUrl: '',
          phoneNumber: '',
        ),
        isFeatured: widget.apartment?.isFeatured ?? false,
        isFavorite: widget.apartment?.isFavorite ?? false,
      );

      if (widget.apartment != null) {
        ref.read(propertyControllerProvider.notifier).updateApartment(apartmentData);
      } else {
        ref.read(propertyControllerProvider.notifier).addApartment(apartmentData);
      }

    } else if (_selectedImagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select an image')));
    }
  }
}
