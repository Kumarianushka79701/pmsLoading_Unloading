class WagonMaster {
  String? code;
  int? capacity;
  String? codename;
  String? wagonType;

  WagonMaster({this.code, this.capacity, this.codename, this.wagonType});

  WagonMaster.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    capacity = json['capacity'];
    codename = json['codename'];
    wagonType = json['wagon_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['capacity'] = capacity;
    data['codename'] = codename;
    data['wagon_type'] = wagonType;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'capacity': capacity,
      'codename': codename,
      'wagon_type': wagonType,
    };
  }
}