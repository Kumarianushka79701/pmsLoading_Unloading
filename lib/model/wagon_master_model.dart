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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['capacity'] = this.capacity;
    data['codename'] = this.codename;
    data['wagon_type'] = this.wagonType;
    return data;
  }
}