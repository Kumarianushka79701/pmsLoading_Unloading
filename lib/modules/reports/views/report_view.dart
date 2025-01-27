import 'package:flutter/material.dart';
import 'package:project/modules/databseReport/views/table.dart';
import 'package:project/modules/providers/local_database_provider.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/common_app_bar.dart';
import 'package:project/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ReportView extends StatelessWidget {
  const ReportView({Key? key}) : super(key: key);

 
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context,
          title:  getTableListAppBarTitle(context),
          actions: [
            IconButton(
            icon: const Icon(Icons.refresh,color: ParcelColors.white,size: 30,),
            onPressed: () {
              Provider.of<LocalDatabaseProvider>(context, listen: false)
                  .getAllTableNames()
                  .then((_) {
                (context as Element).reassemble();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings,color: ParcelColors.white,size: 30),
            onPressed: () {
                // Add your settings logic here
               
            },
          ),
          ], onTap: () {
            Navigator.pop(context);
      }),
     
       
   
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<String>>(
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
              return const Center(
                  child: Text('No tables found in the database.'));
            } else {
              final tableNames = snapshot.data!;
              return ListView.builder(
                itemCount: tableNames.length,
                itemBuilder: (context, index) {
                  final tableName = tableNames[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    color: Colors.amberAccent[80], // Enhanced color
                    child: ListTile(
                      title: Text(tableName),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                TableDetailsView(tableName: tableName),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
          },
        ),
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
        title: Text('Details for Table: $tableName',style: TextStyle(color: ParcelColors.white,fontSize: 18,fontWeight: FontWeight.w700),),
        backgroundColor: Colors.blueAccent, // Enhanced color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
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
      ),
    );
  }
}
Widget getTableListAppBarTitle(BuildContext context) {
  return const TextWidget(
    label: "Table List",
    textColor: ParcelColors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
}