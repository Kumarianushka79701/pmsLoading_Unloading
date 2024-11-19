import 'package:project/model/parcel.dart';

enum DataStatus {
  initial,
  loading,
  success,
  error,
}

class ScanState {
  final DataStatus status;
  final ParcelData? data;

  ScanState({
    this.status = DataStatus.initial,
    this.data,
  });

  ScanState copyWith({
    DataStatus? status,
    ParcelData? data,
  }) {
    return ScanState(
      status: status ?? this.status,
      data: data ?? this.data,
    );
  }
}
