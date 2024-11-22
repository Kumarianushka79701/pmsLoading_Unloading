import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:project/model/parcel.dart';
import 'package:project/model/scan_state.dart';
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
              return const Center(child: Text('Error occurred while scanning.'));
            default:
              return const Center(child: Text('Unknown state.'));
          }
        },
      ),
    );
  }

  Widget _buildMobileScanner(BuildContext context, ScanActivityProvider provider) {
    return MobileScanner(
    onDetect: (BarcodeCapture barcodeCapture) {
      // Extract barcodes from BarcodeCapture
      final barcodes = barcodeCapture.barcodes;

      if (barcodes.isNotEmpty) {
        // Get the first scanned barcode's value
        final barcode = barcodes.first;
        if (barcode.rawValue != null) {
          provider.processScannedData(barcode.rawValue!); // Pass scanned data to the provider
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
        ElevatedButton(
          onPressed: () {
            context.read<ScanActivityProvider>().resetScanner();
          },
          child: const Text('Scan Again'),
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
            .map(
              (entry) => DataRow(
                cells: [
                  DataCell(Text(entry.key)),
                  DataCell(Text(entry.value ?? 'N/A')),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
