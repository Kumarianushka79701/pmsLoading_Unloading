import 'package:flutter/foundation.dart'; // For ChangeNotifier
import 'package:project/model/parcel.dart';
import 'package:project/services/local_database.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService.instance;

  List<ParcelData> _parcels = [];
  List<ParcelData> get parcels => _parcels;

  Future<void> addParcelData(ParcelData parcelData) async {
    await _databaseService.addParcel(parcelData);
    _parcels.add(parcelData);
    notifyListeners();
    print('Parcel added. Total parcels: ${_parcels.length}');
  }

  Future<void> fetchAllParcels() async {
    _parcels = await _databaseService.getAllParcels();
    notifyListeners();
    print('Fetched all parcels. Total parcels: ${_parcels.length}');
  }

  List<ParcelData> getParcelData() {
    return _parcels;
  }

  Future<void> clearDatabase() async {
    await _databaseService.clearDatabase();
    _parcels = [];
    notifyListeners();
    print('Database cleared. State updated.');
  }
}
