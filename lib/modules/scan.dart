import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/model/parcel.dart';
import 'package:project/model/scan_state.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double screenHeight = screenSize.height;
    double buttonContainerHeight = screenHeight * 0.12;
    double maxButtonContainerHeight = 70;

    return Scaffold(
      body: Column(
        children: [
          // Content of QR Code
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: _buildContent(context),
              ),
            ),
          ),
          // Container(
          //   height: buttonContainerHeight,
          //   constraints: BoxConstraints(
          //     maxHeight: maxButtonContainerHeight,
          //   ),
          //   child: _buildButtonContainer(context),
          // ),
        ],
      ),
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
      'Chargeable Weight for Current Package': data.chargeableWeightForCurrentPackage,
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
        columnSpacing: 20.0,
        headingTextStyle: const TextStyle(color: Colors.white),
        headingRowColor: MaterialStateColor.resolveWith(
          (states) => const Color.fromARGB(255, 11, 6, 48),
        ),
        dataRowColor: MaterialStateColor.resolveWith(
          (states) => Colors.white,
        ),
        columns: const [
          DataColumn(label: Text('Property')),
          DataColumn(label: Text('Value')),
        ],
        rows: dataMap.entries.map(
          (entry) {
            return DataRow(cells: [
              DataCell(Text(entry.key)),
              DataCell(Text(entry.value ?? 'N/A')),
            ]);
          },
        ).toList(),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final scanState = context.watch<ScanState>();
    final status = scanState.status;
    final data = scanState.data;

    switch (status) {
      case DataStatus.initial:
        return const Text('Initial');
      case DataStatus.loading:
        return const Text('Loading');
      case DataStatus.success:
        if (data == null) {
          return const Text('No data available.');
        }
        return SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: buildDataTable(data),
          ),
        );
      case DataStatus.error:
        return const Text('Error');
      default:
        return const SizedBox();
    }
  }

  // Widget _buildButtonContainer(BuildContext context) {
  //   final scanState = context.watch<ScanState>();
  //   final status = scanState.status;

  //   return _buildButtons(
  //     context,
  //     status,
  //     () => context.read<ScanState>().scanQR(),
  //     () => context.read<ScanState>().addParcelDataToTable(),
  //   );
  // }

  Widget _buildButtons(
    BuildContext context,
    DataStatus status,
    VoidCallback scanQr,
    VoidCallback addParcelDataToTable,
  ) {
    switch (status) {
      case DataStatus.initial:
      case DataStatus.loading:
      case DataStatus.error:
        return buttonWidget(context, scanQr);
      case DataStatus.success:
        return buttonsWidget(context, scanQr, addParcelDataToTable);
      default:
        return const SizedBox();
    }
  }

  Widget buttonWidget(BuildContext context, VoidCallback scanQR) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: scanQR,
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
          ),
          child: Text(
            'Scan Start',
            style: TextStyle(color: Theme.of(context).colorScheme.primaryFixed),
          ),
        ),
      ],
    );
  }

  Widget buttonsWidget(
    BuildContext context,
    VoidCallback scanQR,
    VoidCallback addParcelDataToTable,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: scanQR,
          style: TextButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            elevation: 6.0,
            shadowColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          child: Text(
            'Scan Start',
            style: TextStyle(color: Theme.of(context).colorScheme.primaryFixed),
          ),
        ),
        const SizedBox(width: 20),
        TextButton(
          onPressed: addParcelDataToTable,
          style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 219, 43, 31),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            elevation: 6.0,
          ),
          child: const Text(
            'Add to table',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
