import 'package:flutter/material.dart';

class PrrStatusProvider with ChangeNotifier {
  final TextEditingController prrController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController destController = TextEditingController();
  final TextEditingController bookingTypeController = TextEditingController();

  String _selectedBookingType = 'PWB';

  String get selectedBookingType => _selectedBookingType;

  void updateBookingType(String type) {
    _selectedBookingType = type;
    bookingTypeController.text = type;
    notifyListeners();
  }

  void submitForm() {
    final prr = prrController.text;
    final source = sourceController.text;
    final dest = destController.text;
    final bookingType = bookingTypeController.text;

    // Handle form submission
    debugPrint('PRR: $prr, Source: $source, Destination: $dest, Booking Type: $bookingType');
  }
}
