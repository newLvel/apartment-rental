import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  RangeValues _priceRange = const RangeValues(1000, 3500);
  String _selectedCity = 'Dubai';
  String _selectedType = 'Apartment';
  int _selectedBedrooms = 2;

  final List<String> _cities = ['Dubai', 'Abudhabi', 'Sharjah'];
  final List<String> _types = ['Apartment', 'House', 'Villa'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 20),
          onPressed: () => context.pop(),
        ),
        title: const Text('Filters', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('City'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: _cities.map((city) => _buildChip(city, _selectedCity == city, (val) {
                      setState(() => _selectedCity = city);
                    })).toList(),
                  ),
                  const SizedBox(height: 32),
                  
                  _buildSectionTitle('Type'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 12,
                    children: _types.map((type) => _buildChip(type, _selectedType == type, (val) {
                      setState(() => _selectedType = type);
                    })).toList(),
                  ),
                  const SizedBox(height: 32),
                  
                  _buildSectionTitle('Price Range'),
                  const SizedBox(height: 12),
                  // Chart placeholder visual
                  Container(
                    height: 60,
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(20, (index) {
                        return Container(
                          width: 8,
                          height: 20.0 + (index % 5) * 10,
                          color: Colors.grey.shade200,
                        );
                      }),
                    ),
                  ),
                  RangeSlider(
                    values: _priceRange,
                    min: 0,
                    max: 5000,
                    activeColor: const Color(0xFF0A3D62),
                    inactiveColor: Colors.grey.shade200,
                    onChanged: (values) {
                      setState(() => _priceRange = values);
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildPriceBox('${_priceRange.start.round()} AED'),
                      const Text('-', style: TextStyle(color: Colors.grey)),
                      _buildPriceBox('${_priceRange.end.round()} AED'),
                    ],
                  ),
                  const SizedBox(height: 32),

                  _buildSectionTitle('Bedrooms'),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [1, 2, 3, 4, 5].map((count) {
                      final isSelected = _selectedBedrooms == count;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedBedrooms = count),
                        child: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xFF0A3D62) : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected ? const Color(0xFF0A3D62) : Colors.grey.shade200,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              count == 5 ? '5+' : '$count',
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Buttons
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade100)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      // Reset logic
                      setState(() {
                         _priceRange = const RangeValues(1000, 3500);
                         _selectedCity = 'Dubai';
                         _selectedType = 'Apartment';
                         _selectedBedrooms = 2;
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: const Text('Reset', style: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      context.pop(); // Apply logic would go here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFE85D32),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Text('Apply', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold));
  }

  Widget _buildChip(String label, bool isSelected, Function(bool) onSelected) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFFE85D32).withValues(alpha: 0.1),
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFFE85D32) : Colors.black,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: isSelected ? const Color(0xFFE85D32) : Colors.grey.shade200),
      ),
    );
  }

  Widget _buildPriceBox(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }
}
