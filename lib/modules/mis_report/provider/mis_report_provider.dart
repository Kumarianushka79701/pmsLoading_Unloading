import 'package:flutter/material.dart';

class MisReportProvider with ChangeNotifier {
  final TextEditingController trainNoController = TextEditingController();
  final TextEditingController sourceController = TextEditingController();
  final TextEditingController summaryController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  Future<void> setDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000), 
      lastDate: DateTime(2100), 
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        final DateTime selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        final formattedDateTime = "${selectedDateTime.day}-${selectedDateTime.month}-${selectedDateTime.year} "
            "${pickedTime.format(context)}";

        dateController.text = formattedDateTime;

        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    trainNoController.dispose();
    sourceController.dispose();
    summaryController.dispose();
    dateController.dispose();
    super.dispose();
  }
}
