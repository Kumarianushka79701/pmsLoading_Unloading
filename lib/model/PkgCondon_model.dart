class PkgCondnMaster {
  String? code;
  String? detail;

  PkgCondnMaster({this.code, this.detail});

  PkgCondnMaster.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['detail'] = this.detail;
    return data;
  }
}