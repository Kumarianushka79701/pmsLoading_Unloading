class ParcelData {
  final String? weightOfConsignment;
  final String? prrNumber;
  final String? totalPackages;
  final String? currentPackageNumber;
  final String? destinationStationCode;
  final String? sourceStationCode;
  final String? totalWeight;
  final String? commodityTypeCode;
  final String? bookingDate;
  final String? chargeableWeightForCurrentPackage;
  final String? totalChargeableWeight;
  final String? packagingDescriptionCode;
  final String? trainScaleCode;
  final String? rajdhaniFlag;
  final String? estimatedUnloadingTime;
  final String? transhipmentStation;

  ParcelData({
    this.weightOfConsignment,
    this.prrNumber,
    this.totalPackages,
    this.currentPackageNumber,
    this.destinationStationCode,
    this.sourceStationCode,
    this.totalWeight,
    this.commodityTypeCode,
    this.bookingDate,
    this.chargeableWeightForCurrentPackage,
    this.totalChargeableWeight,
    this.packagingDescriptionCode,
    this.trainScaleCode,
    this.rajdhaniFlag,
    this.estimatedUnloadingTime,
    this.transhipmentStation,
  });

  @override
  String toString() {
    return '''
    Weight of Consignment: $weightOfConsignment grams
    PRR Number: $prrNumber
    Total Packages: $totalPackages
    Current Package Number: $currentPackageNumber
    Destination Station Code: $destinationStationCode
    Source Station Code: $sourceStationCode
    Total Weight: $totalWeight KG
    Commodity Type Code: $commodityTypeCode
    Booking Date: $bookingDate
    Chargeable Weight for Current Package: $chargeableWeightForCurrentPackage grams
    Total Chargeable Weight: $totalChargeableWeight KG
    Packaging Description Code: $packagingDescriptionCode
    Train Scale Code: $trainScaleCode
    Rajdhani Flag: $rajdhaniFlag
    Estimated Unloading Time: $estimatedUnloadingTime hours
    Transhipment Station: $transhipmentStation
    ''';
  }

  // Convert a Parcel into a Map.
  Map<String, dynamic> toMap() {
    return {
      'weightOfConsignment': weightOfConsignment,
      'prrNumber': prrNumber,
      'totalPackages': totalPackages,
      'currentPackageNumber': currentPackageNumber,
      'destinationStationCode': destinationStationCode,
      'sourceStationCode': sourceStationCode,
      'totalWeight': totalWeight,
      'commodityTypeCode': commodityTypeCode,
      'bookingDate': bookingDate,
      'chargeableWeightForCurrentPackage': chargeableWeightForCurrentPackage,
      'totalChargeableWeight': totalChargeableWeight,
      'packagingDescriptionCode': packagingDescriptionCode,
      'trainScaleCode': trainScaleCode,
      'rajdhaniFlag': rajdhaniFlag,
      'estimatedUnloadingTime': estimatedUnloadingTime,
      'transhipmentStation': transhipmentStation,
    };
  }

  factory ParcelData.fromMap(Map<String, dynamic> json) => ParcelData(
        weightOfConsignment: json['weightOfConsignment'],
        prrNumber: json['prrNumber'],
        totalPackages: json['totalPackages'],
        currentPackageNumber: json['currentPackageNumber'],
        destinationStationCode: json['destinationStationCode'],
        sourceStationCode: json['sourceStationCode'],
        totalWeight: json['totalWeight'],
        commodityTypeCode: json['commodityTypeCode'],
        bookingDate: json['bookingDate'],
        chargeableWeightForCurrentPackage:
            json['chargeableWeightForCurrentPackage'],
        totalChargeableWeight: json['totalChargeableWeight'],
        packagingDescriptionCode: json['packagingDescriptionCode'],
        trainScaleCode: json['trainScaleCode'],
        rajdhaniFlag: json['rajdhaniFlag'],
        estimatedUnloadingTime: json['estimatedUnloadingTime'],
        transhipmentStation: json['transhipmentStation'],
      );
}
