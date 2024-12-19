// import 'package:flutter/material.dart';
// import 'package:project/services/local_database.dart';

// class ReportView extends StatefulWidget {
//   const ReportView({Key? key}) : super(key: key);

//   @override
//   State<ReportView> createState() => _ReportViewState();
// }

// class _ReportViewState extends State<ReportView> {
//   Future<void> _saveLoginInfo() async {
//     await DatabaseService.instance.insertLoginInfo('AT', 'AT', 'NDLS');
//     setState(() {}); // Refresh FutureBuilder
//   }

//   Future<void> _debugTables() async {
//     await DatabaseService.instance.verifyTables();
//   }

//   @override
//   void initState() {
//     super.initState();
//     _debugTables(); // Logs available tables
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Report View')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             ElevatedButton(
//               onPressed: () async {
//                 await _saveLoginInfo();
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text('Login info saved successfully!')),
//                 );
//               },
//               child: const Text('Save Login Info'),
//             ),
//             const SizedBox(height: 20),
//             Expanded(
//               child: FutureBuilder<List<Map<String, dynamic>>>(
//                 future: DatabaseService.instance.getAllLoginInfo(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(child: CircularProgressIndicator());
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return const Center(
//                       child: Text('No data available. Add data to see here.'),
//                     );
//                   }

//                   final data = snapshot.data!;

//                   return SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         columns: const [
//                           DataColumn(label: Text('User ID')),
//                           DataColumn(label: Text('Password')),
//                           DataColumn(label: Text('Station Code')),
//                         ],
//                         rows: data.map((row) {
//                           return DataRow(
//                             cells: [
                              
//                               DataCell(Text(row['userId'] ?? '')),
//                               DataCell(Text(row['password'] ?? '')),
//                               DataCell(Text(row['stationCode'] ?? '')),
//                             ],
//                           );
//                         }).toList(),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:project/modules/providers/local_database_provider.dart';
import 'package:provider/provider.dart';

class ReportView extends StatelessWidget {
  const ReportView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Tables Report'),
      ),
      body: FutureBuilder<List<String>>(
        future: Provider.of<LocalDatabaseProvider>(context, listen: false)
            .getAllTableNames(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No tables found in the database.'));
          } else {
            final tableNames = snapshot.data!;
            return ListView.builder(
              itemCount: tableNames.length,
              itemBuilder: (context, index) {
                final tableName = tableNames[index];
                return ListTile(
                  title: Text(tableName),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TableDetailsView(tableName: tableName),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class TableDetailsView extends StatelessWidget {
  final String tableName;

  const TableDetailsView({required this.tableName, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details for Table: $tableName'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Provider.of<LocalDatabaseProvider>(context, listen: false)
            .getTableData(tableName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No data available in this table.'),
            );
          } else {
            final tableData = snapshot.data!;
            final columnNames = tableData.first.keys.toList();
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: columnNames
                      .map((colName) => DataColumn(label: Text(colName)))
                      .toList(),
                  rows: tableData.map((row) {
                    return DataRow(
                      cells: columnNames.map((colName) {
                        return DataCell(Text(row[colName]?.toString() ?? ''));
                      }).toList(),
                    );
                  }).toList(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

