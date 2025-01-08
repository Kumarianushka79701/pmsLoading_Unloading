class WagonTypeAl {
  String? type;
  String? detail;
  String? gauge;
  String? shortdet;

  WagonTypeAl({this.type, this.detail, this.gauge, this.shortdet});

  WagonTypeAl.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    detail = json['detail'];
    gauge = json['gauge'];
    shortdet = json['shortdet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['detail'] = this.detail;
    data['gauge'] = this.gauge;
    data['shortdet'] = this.shortdet;
    return data;
  }
}