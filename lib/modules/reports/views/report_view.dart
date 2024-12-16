import 'package:flutter/material.dart';
import 'package:project/services/local_database.dart';

class ReportView extends StatefulWidget {
  const ReportView({super.key});

  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  late Future<List<Map<String, dynamic>>> loginInfoFuture;

  @override
  void initState() {
    super.initState();
    loginInfoFuture = DatabaseService.instance.getAllLoginInfo();
  }

  Future<void> _saveLoginInfo() async {
    await DatabaseService.instance.insertLoginInfo(
      'user123',
      'password123',
      'ST123',
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Login info saved successfully!')),
    );

    // Refresh the FutureBuilder
    setState(() {
      loginInfoFuture = DatabaseService.instance.getAllLoginInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: _saveLoginInfo,
              child: const Text('Save Login Info'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: loginInfoFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data available. Please add some using the "Save Login Info" button.'));
                  }

                  final data = snapshot.data!;

                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
