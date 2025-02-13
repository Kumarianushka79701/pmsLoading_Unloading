import 'package:flutter/material.dart';
import 'package:project/modules/lodingScreen/loading_screen/add_pwb_prr_form.dart';

class ScanDataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Data'),
        backgroundColor: Colors.blue[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row with train details
            Text(
              '02420     Scale: R    07-Oct-2024 01:41    FCFSLR',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Data header row
            Container(
              color: Colors.blueGrey[100],
              padding: EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('SELECT', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('ID', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('PRR Number',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('FRMS', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('DEST', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('PKG', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('WGT', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            SizedBox(height: 10),

            // Total package/weight display
            Text(
              'Total guidance pkg/weight: 0/0',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Buttons
            Expanded(
              child: Column(
                children: [
                  // Start Scanning Button
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScanDataScreen()),
                      );
                    },
                    icon: Icon(Icons.qr_code_scanner),
                    label: Text('START SCANNING'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: Size(double.infinity, 50),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Scan Barcode Button
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScanDataScreen()),
                      );
                    },
                    icon: Icon(Icons.camera_alt),
                    label: Text('SCAN BARCODE THROUGH CAMERA'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(double.infinity, 50),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Add Button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Navigate to the AddPwbPrrForm when "Add" button is clicked
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddPwbPrrForm()),
                      );
                    },
                    icon: Icon(Icons.add_circle),
                    label: Text('ADD'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize: Size(double.infinity, 50),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Edit Button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Action for edit
                    },
                    icon: Icon(Icons.edit),
                    label: Text('EDIT'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      minimumSize: Size(double.infinity, 50),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Next Button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Action for next
                    },
                    icon: Icon(Icons.navigate_next),
                    label: Text('NEXT'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(double.infinity, 50),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Exit Button
                  ElevatedButton.icon(
                    onPressed: () {
                      // Action for exit
                      Navigator.pop(
                          context); // Example: go back to previous screen
                    },
                    icon: Icon(Icons.exit_to_app),
                    label: Text('EXIT'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      minimumSize: Size(double.infinity, 50),
                      textStyle: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
