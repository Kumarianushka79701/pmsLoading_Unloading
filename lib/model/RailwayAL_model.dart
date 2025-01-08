
////for get railway Rl zone details

class RailwayAL {
  final int? zone;
  final String? code;
  final String? detail;
  final String? add1;
  final String? add2;
  final String? add3;
  final String? add4;
  final String? pin;
  final String? serviceTaxRegNo;

  RailwayAL({
    this.zone,
    this.code,
    this.detail,
    this.add1,
    this.add2,
    this.add3,
    this.add4,
    this.pin,
    this.serviceTaxRegNo,
  });

  // Factory method for JSON deserialization
  factory RailwayAL.fromJson(Map<String, dynamic>? json) {
    if (json == null) return RailwayAL();
    return RailwayAL(
      zone: json['zone'] as int?,
      code: json['code'] as String?,
      detail: json['detail'] as String?,
      add1: json['add1'] as String?,
      add2: json['add2'] as String?,
      add3: json['add3'] as String?,
      add4: json['add4'] as String?,
      pin: json['pin'] as String?,
      serviceTaxRegNo: json['serviceTaxRegNo'] as String?,
    );
  }

  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'zone': zone,
      'code': code,
      'detail': detail,
      'add1': add1,
      'add2': add2,
      'add3': add3,
      'add4': add4,
      'pin': pin,
      'serviceTaxRegNo': serviceTaxRegNo,
    };
  }
}
