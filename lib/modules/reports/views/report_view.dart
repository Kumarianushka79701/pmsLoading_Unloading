import 'package:flutter/material.dart';
import 'package:project/services/local_database.dart';

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report View'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseService.instance.getAllLoginInfo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available.'));
          }

          final data = snapshot.data!;

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: const [
                DataColumn(label: Text('User ID')),
                DataColumn(label: Text('Password')),
                DataColumn(label: Text('Station Code')),
              ],
              rows: data.map((row) {
                return DataRow(
                  cells: [
                    DataCell(Text(row['userId'] ?? '')),
                    DataCell(Text(row['password'] ?? '')),
                    DataCell(Text(row['stationCode'] ?? '')),
                  ],
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
