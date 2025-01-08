class MpkgDesc {
  String? pkgDesc;
  int? slNumber;

  MpkgDesc({this.pkgDesc, this.slNumber});

  MpkgDesc.fromJson(Map<String, dynamic> json) {
    pkgDesc = json['pkgDesc'];
    slNumber = json['slNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pkgDesc'] = this.pkgDesc;
    data['slNumber'] = this.slNumber;
    return data;
  }
}