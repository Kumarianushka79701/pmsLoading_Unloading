import 'package:flutter/material.dart';
import 'package:project/model/parcel.dart';
import 'package:project/modules/providers/local_database_provider.dart';
import 'package:project/utils/color_extensions.dart';
import 'package:provider/provider.dart';





class TableScreen extends StatefulWidget {
  const TableScreen({super.key});

  @override
  _TableScreenState createState() => _TableScreenState();
}

class _TableScreenState extends State<TableScreen> {
  bool _showAllData = false; // Toggle flag to control data display

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        title: Text(
          'Database',
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_showAllData ? Icons.visibility_off : Icons.visibility),
            onPressed: () {
              setState(() {
                _showAllData = !_showAllData; // Toggle the data display
              });
            },
          ),
        ],
      ),
      body: Consumer<LocalDatabaseProvider>(
        builder: (context, provider, child) {
          return FutureBuilder<List<ParcelData>>(
            future: provider.getParcelData(), // Fetch the data from the provider
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('No data found', style: TextStyle(fontSize: 20.0)),
                      Text(
                        'Please add some data to see it here',
                        style: TextStyle(fontSize: 15.0, color: Colors.grey),
                      ),
                    ],
                  ),
                );
              } else {
                List<ParcelData> tableData = snapshot.data!;

                if (!_showAllData) {
                  tableData = [tableData.last]; // Show only the latest data
                } else {
                  tableData.sort((a, b) =>
                      b.bookingDate!.compareTo(a.bookingDate!)); // Sort by date
                }

                return Container(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columnSpacing: 20.0,
                      dividerThickness: 1.2,
                      border: TableBorder.all(
                        color: const Color(0xFF000000),
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                      headingRowColor: MaterialStateColor.resolveWith(
                        (states) =>
                            Theme.of(context).colorScheme.primaryFixedDim,
                      ),
                      dataRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.white,
                      ),
                      columns: const [
                        DataColumn(label: Text('PRR Number')),
                        DataColumn(label: Text('Weight of Consignment')),
                        DataColumn(label: Text('Total Packages')),
                        DataColumn(label: Text('Current Package Number')),
                        DataColumn(label: Text('Destination Station Code')),
                        DataColumn(label: Text('Source Station Code')),
                        DataColumn(label: Text('Total Weight')),
                        DataColumn(label: Text('Commodity Type Code')),
                        DataColumn(label: Text('Booking Date')),
                        DataColumn(label: Text('Chargeable Weight for Current Package')),
                        DataColumn(label: Text('Total Chargeable Weight')),
                        DataColumn(label: Text('Packaging Description Code')),
                        DataColumn(label: Text('Train Scale Code')),
                        DataColumn(label: Text('Rajdhani Flag')),
                        DataColumn(label: Text('Estimated Unloading Time')),
                        DataColumn(label: Text('Transshipment Station')),
                        DataColumn(label: Text('Actions')), // New column for delete button
                      ],
                      rows: tableData.map((data) {
                        return DataRow(cells: [
                          DataCell(Text(data.prrNumber ?? 'N/A')),
                          DataCell(Text(data.weightOfConsignment ?? 'N/A')),
                          DataCell(Text(data.totalPackages ?? 'N/A')),
                          DataCell(Text(data.currentPackageNumber ?? 'N/A')),
                          DataCell(Text(data.destinationStationCode ?? 'N/A')),
                          DataCell(Text(data.sourceStationCode ?? 'N/A')),
                          DataCell(Text(data.totalWeight ?? 'N/A')),
                          DataCell(Text(data.commodityTypeCode ?? 'N/A')),
                          DataCell(Text(data.bookingDate ?? 'N/A')),
                          DataCell(Text(data.chargeableWeightForCurrentPackage ?? 'N/A')),
                          DataCell(Text(data.totalChargeableWeight ?? 'N/A')),
                          DataCell(Text(data.packagingDescriptionCode ?? 'N/A')),
                          DataCell(Text(data.trainScaleCode ?? 'N/A')),
                          DataCell(Text(data.rajdhaniFlag ?? 'N/A')),
                          DataCell(Text(data.estimatedUnloadingTime ?? 'N/A')),
                          DataCell(Text(data.transhipmentStation ?? 'N/A')),
                          DataCell(IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              provider.deleteParcelData(data);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'PRR ${data.prrNumber} deleted successfully'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                          )),
                        ]);
                      }).toList(),
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
  floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Insert dummy data
          final dummyData = ParcelData(
            prrNumber: 'PRR12345',
      weightOfConsignment: '200kg',
      totalPackages: '5',
      destinationStationCode: 'DST001',
      bookingDate: DateTime.now().toString(),
    );
          context.read<LocalDatabaseProvider>().insertParcelData(dummyData);

          context.read<LocalDatabaseProvider>().notifyListeners();







  },
  child: const Icon(Icons.add),
),
    );
  }
}




// import 'package:flutter/material.dart';
// import 'package:project/model/parcel.dart';
// import 'package:project/modules/providers/local_database_provider.dart';
// import 'package:project/modules/scan.dart';
// import 'package:project/utils/color_extensions.dart';
// import 'package:provider/provider.dart';

// class TableScreen extends StatelessWidget {
//   const TableScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         leading: IconButton(
//           icon: const Icon(Icons.menu),
//           onPressed: () {
//             Scaffold.of(context).openDrawer();
//           },
//         ),
//         title: Text(
//           'Database',
//           style: TextStyle(
//             color: AppColors.white,
//             fontWeight: FontWeight.bold,
//             fontSize: 22,
//           ),
//         ),
//         centerTitle: true,
//       ),
//       body: Consumer<LocalDatabaseProvider>(
//         builder: (context, provider, child) {
//           return FutureBuilder<List<ParcelData>>(
//             future: provider.getParcelData(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (snapshot.hasError) {
//                 return Center(child: Text('Error: ${snapshot.error}'));
//               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                 return const Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Uh oh.. No data found', style: TextStyle(fontSize: 20.0)),
//                       Text(
//                         'Please add some data to see it here',
//                         style: TextStyle(fontSize: 15.0, color: Colors.grey),
//                       ),
//                     ],
//                   ),
//                 );
//               } else {
//                 final tableData = snapshot.data!;

//                 return Container(
//                   padding: const EdgeInsets.all(15.0),
//                   height: MediaQuery.of(context).size.height * 0.8,
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.vertical,
//                       child: DataTable(
//                         columnSpacing: 20.0,
//                         dividerThickness: 1.2,
//                         border: TableBorder.all(
//                           color: const Color(0xFF000000),
//                           width: 1.0,
//                           style: BorderStyle.solid,
//                         ),
//                         headingRowColor: MaterialStateColor.resolveWith(
//                           (states) => Theme.of(context).colorScheme.primaryFixedDim,
//                         ),
//                         dataRowColor: MaterialStateColor.resolveWith(
//                           (states) => Colors.white,
//                         ),
//                         columns: const [
//                           DataColumn(label: Text('PRR Number')),
//                           DataColumn(label: Text('Weight of Consignment')),
//                           DataColumn(label: Text('Total Packages')),
//                           DataColumn(label: Text('Current Package Number')),
//                           DataColumn(label: Text('Destination Station Code')),
//                           DataColumn(label: Text('Source Station Code')),
//                           DataColumn(label: Text('Total Weight')),
//                           DataColumn(label: Text('Commodity Type Code')),
//                           DataColumn(label: Text('Booking Date')),
//                           DataColumn(label: Text('Chargeable Weight for Current Package')),
//                           DataColumn(label: Text('Total Chargeable Weight')),
//                           DataColumn(label: Text('Packaging Description Code')),
//                           DataColumn(label: Text('Train Scale Code')),
//                           DataColumn(label: Text('Rajdhani Flag')),
//                           DataColumn(label: Text('Estimated Unloading Time')),
//                           DataColumn(label: Text('Transshipment Station')),
//                           DataColumn(label: Text('Actions')), // New column for delete button
//                         ],
//                         rows: tableData.map((data) {
//                           return DataRow(cells: [
//                             DataCell(Text(data.prrNumber ?? 'N/A')),
//                             DataCell(Text(data.weightOfConsignment ?? 'N/A')),
//                             DataCell(Text(data.totalPackages ?? 'N/A')),
//                             DataCell(Text(data.currentPackageNumber ?? 'N/A')),
//                             DataCell(Text(data.destinationStationCode ?? 'N/A')),
//                             DataCell(Text(data.sourceStationCode ?? 'N/A')),
//                             DataCell(Text(data.totalWeight ?? 'N/A')),
//                             DataCell(Text(data.commodityTypeCode ?? 'N/A')),
//                             DataCell(Text(data.bookingDate ?? 'N/A')),
//                             DataCell(Text(data.chargeableWeightForCurrentPackage ?? 'N/A')),
//                             DataCell(Text(data.totalChargeableWeight ?? 'N/A')),
//                             DataCell(Text(data.packagingDescriptionCode ?? 'N/A')),
//                             DataCell(Text(data.trainScaleCode ?? 'N/A')),
//                             DataCell(Text(data.rajdhaniFlag ?? 'N/A')),
//                             DataCell(Text(data.estimatedUnloadingTime ?? 'N/A')),
//                             DataCell(Text(data.transhipmentStation ?? 'N/A')),
//                             DataCell(IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () {
//                                 // Delete this row from the database
//                                 provider.deleteParcelData(data);
//                               },
//                             )),
//                           ]);
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 );
//               }
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // Navigate to a new screen to add a parcel (e.g., ScanScreen or AddParcelScreen)
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const ScanScreen()),
//           );
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//   }
// }
