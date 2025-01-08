class PlatformMaster {
  String? code;
  String? detail;

  PlatformMaster({this.code, this.detail});

  PlatformMaster.fromJson(Map<String, dynamic> json) {
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