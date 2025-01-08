class PlatformMaster {
  String? code;
  String? detail;

  PlatformMaster({this.code, this.detail});

  PlatformMaster.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    detail = json['detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['detail'] = detail;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'detail': detail,
    };
  }
}