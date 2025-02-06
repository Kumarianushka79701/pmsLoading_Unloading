import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project/model/parcel.dart';
import 'package:project/model/scan_state.dart';
import 'package:project/modules/providers/local_database_provider.dart';
import 'package:project/modules/providers/scan_activity_provider.dart';
import 'package:provider/provider.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Code Scanner')),
      body: Consumer<ScanActivityProvider>(
        builder: (context, provider, child) {
          switch (provider.status) {
            case DataStatus.initial:
              return _buildMobileScanner(context, provider);
            case DataStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case DataStatus.success:
              if (provider.scannedData == null) {
                return const Center(child: Text('No data found.'));
              }
              return _buildScannedData(context, provider.scannedData!);
            case DataStatus.error:
              return const Center(
                  child: Text('Error occurred while scanning.'));
            default:
              return const Center(child: Text('Unknown state.'));
          }
        },
      ),
    );
  }

  Widget _buildMobileScanner(
      BuildContext context, ScanActivityProvider provider) {
    return MobileScanner(
      onDetect: (BarcodeCapture barcodeCapture) {
        final barcodes = barcodeCapture.barcodes;

        if (barcodes.isNotEmpty) {
          final barcode = barcodes.first;
          if (barcode.rawValue != null) {
            provider.processScannedData(barcode.rawValue!);
            // Save the scanned data to the local database
            final parcelData = provider.scannedData;
            if (parcelData != null) {
              context
                  .read<LocalDatabaseProvider>()
                  .insertParcelData(parcelData);
            }
          } else {
            provider.setErrorState("No valid QR code detected.");
          }
        } else {
          provider.setErrorState("No barcodes detected.");
        }
      },
    );
  }

  Widget _buildScannedData(BuildContext context, ParcelData data) {
    return Column(
      children: [
        Expanded(child: buildDataTable(data)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<ScanActivityProvider>().resetScanner();
              },
              child: const Text('Scan Again'),
            ),
            const SizedBox(width: 16), // Space between buttons
            ElevatedButton(
              onPressed: () async {
                final localDbProvider = context.read<LocalDatabaseProvider>();

                // Check if the PRR number already exists
                final bool? isDuplicate =
                    await localDbProvider.isParcelDuplicate(data.prrNumber);

                if (isDuplicate == true) {
                  // Show a message if it's a duplicate
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Duplicate parcel data. Cannot save!')),
                  );
                } else {
                  // Save the data if it's not a duplicate
                  await localDbProvider.insertParcelData(data);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Parcel data saved successfully!')),
                  );
                }
              },
              child: const Text('Save Data'),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildDataTable(ParcelData data) {
    final dataMap = {
      'Weight of Consignment': data.weightOfConsignment,
      'PRR Number': data.prrNumber,
      'Total Packages': data.totalPackages,
      'Current Package Number': data.currentPackageNumber,
      'Destination Station Code': data.destinationStationCode,
      'Source Station Code': data.sourceStationCode,
      'Total Weight': data.totalWeight,
      'Commodity Type Code': data.commodityTypeCode,
      'Booking Date': data.bookingDate,
      'Chargeable Weight for Current Package':
          data.chargeableWeightForCurrentPackage,
      'Total Chargeable Weight': data.totalChargeableWeight,
      'Packaging Description Code': data.packagingDescriptionCode,
      'Train Scale Code': data.trainScaleCode,
      'Rajdhani Flag': data.rajdhaniFlag,
      'Estimated Unloading Time': data.estimatedUnloadingTime,
      'Transshipment Station': data.transhipmentStation,
    };

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Property')),
          DataColumn(label: Text('Value')),
        ],
        rows: dataMap.entries
            .map((entry) => DataRow(
                  cells: [
                    DataCell(Text(entry.key)),
                    DataCell(Text(entry.value ?? 'N/A')),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
