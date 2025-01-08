class UserMasterRest {
  String? invalid;
  String? loggeduser;
  String? password;
  String? stncode;

  UserMasterRest({this.invalid, this.loggeduser, this.password, this.stncode});

  UserMasterRest.fromJson(Map<String, dynamic> json) {
    invalid = json['invalid'];
    loggeduser = json['loggeduser'];
    password = json['password'];
    stncode = json['stncode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['invalid'] = this.invalid;
    data['loggeduser'] = this.loggeduser;
    data['password'] = this.password;
    data['stncode'] = this.stncode;
    return data;
  }
}