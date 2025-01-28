
import 'package:flutter/material.dart';
import 'package:project/modules/unLoading/providers/unloading_provider.dart';
import 'package:provider/provider.dart';

class UnloadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UnloadingProvider(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.blue),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'Unloading Summary',
            style: TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildDateField('Scheduled Dep.', '20-Jan-2025'),
              const SizedBox(height: 16),
              _buildDropdownField(context),
              const SizedBox(height: 16),
              _buildTextField(context, 'Train No.'),
              const SizedBox(height: 16),
              _buildSwitch(context),
              const SizedBox(height: 16),
              _buildDateField('Actual Load Date', '20-Jan-2025'),
              const Spacer(),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(String title, String date) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 16, color: Colors.black)),
        Text(date, style: TextStyle(fontSize: 16, color: Colors.black)),
      ],
    );
  }

  Widget _buildDropdownField(BuildContext context) {
    return Consumer<UnloadingProvider>(
      builder: (context, provider, child) {
        return DropdownButtonFormField<String>(
          value: provider.vehicleType,
          onChanged: (value) {
            if (value != null) provider.updateVehicleType(value);
          },
          items: [
            'Select Vehicle Type',
            'Truck',
            'Van',
            'Bike',
          ].map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type),
            );
          }).toList(),
          decoration: InputDecoration(
            labelText: 'Vehicle Type',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(BuildContext context, String hint) {
    return Consumer<UnloadingProvider>(
      builder: (context, provider, child) {
        return TextFormField(
          onChanged: (value) {
            provider.updateTrainNumber(value);
          },
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSwitch(BuildContext context) {
    return Consumer<UnloadingProvider>(
      builder: (context, provider, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Show Guidance',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Switch(
              value: provider.showGuidance,
              onChanged: (value) {
                provider.toggleShowGuidance();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        // Handle submission
      },
      child: Text('Submit'),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
