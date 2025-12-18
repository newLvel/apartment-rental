import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../property_listing/domain/entities/apartment.dart';
import '../providers/booking_providers.dart';

class BookingDialog extends ConsumerStatefulWidget {
  final Apartment apartment;

  const BookingDialog({super.key, required this.apartment});

  @override
  ConsumerState<BookingDialog> createState() => _BookingDialogState();
}

class _BookingDialogState extends ConsumerState<BookingDialog> {
  DateTimeRange? _selectedDateRange;

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingControllerProvider);
    final isLoading = bookingState.isLoading;
    final currencyFormatter = NumberFormat.currency(locale: 'fr_CM', symbol: 'XAF', decimalDigits: 0);

    // Listen for success/error
    ref.listen(bookingControllerProvider, (previous, next) {
      if (next.hasError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${next.error}')),
        );
      } else if (!next.isLoading && !next.hasError && previous?.isLoading == true) {
         // Success
        Navigator.of(context).pop(); // Close dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking Confirmed!')),
        );
      }
    });

    double totalPrice = 0;
    if (_selectedDateRange != null) {
      final days = _selectedDateRange!.duration.inDays + 1; 
      final dailyRate = widget.apartment.pricePerMonth / 30;
      totalPrice = dailyRate * days;
    }

    return AlertDialog(
      title: const Text('Book Apartment'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Apartment: ${widget.apartment.title}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
              );
              if (picked != null) {
                setState(() {
                  _selectedDateRange = picked;
                });
              }
            },
            child: Text(_selectedDateRange == null
                ? 'Select Dates'
                : '${DateFormat.MMMd().format(_selectedDateRange!.start)} - ${DateFormat.MMMd().format(_selectedDateRange!.end)}'),
          ),
          if (_selectedDateRange != null) ...[
            const SizedBox(height: 16),
            Text('Total Days: ${_selectedDateRange!.duration.inDays + 1}'),
            Text('Total Price: ${currencyFormatter.format(totalPrice)}'),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: (_selectedDateRange == null || isLoading)
              ? null
              : () {
                  ref.read(bookingControllerProvider.notifier).createBooking(
                        apartmentId: widget.apartment.id,
                        startDate: _selectedDateRange!.start,
                        endDate: _selectedDateRange!.end,
                        totalPrice: totalPrice,
                      );
                },
          child: isLoading
              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
              : const Text('Confirm Booking'),
        ),
      ],
    );
  }
}
