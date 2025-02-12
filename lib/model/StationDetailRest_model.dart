class StationDetailRest {
  String? sTATE;
  String? tOTPLTFRMS;
  String? pBOOKING;
  String? jUNCTIONSTNFLAG;
  String? rLYCODE;
  String? sCTN;
  String? sTNCLASS;
  String? wHARFRATETYPE;
  String? eXTRAOUTCHRGREASON;
  String? gAUGE;
  String? dETAIL;
  String? dISTCODE;
  String? eXTRAOUTCHRG;
  String? sRV;
  String? pRICEOFINITIALWT;
  String? cODE;
  String? cODENAME;
  String? tRANSHMNTSTN;
  String? oUTAGENCY;
  String? aREA;
  String? pOLICEVI;
  String? oAPROADDR;
  String? iNITIALWT;
  String? dIVNO;
  String? pRICEOFADDLWT;
  String? wHARFSLAB;
  String? zONE;
  String? cRISSTNNO;
  String? dIVCODE;
  String? rPFI;
  String? sQUARE;
  String? oAPROPNAME;
  String? sTNNUMBER;
  String? aDDLWT;
  String? aDD3;
  String? aDD2;
  String? aDD1;

  StationDetailRest(
      {this.sTATE,
      this.tOTPLTFRMS,
      this.pBOOKING,
      this.jUNCTIONSTNFLAG,
      this.rLYCODE,
      this.sCTN,
      this.sTNCLASS,
      this.wHARFRATETYPE,
      this.eXTRAOUTCHRGREASON,
      this.gAUGE,
      this.dETAIL,
      this.dISTCODE,
      this.eXTRAOUTCHRG,
      this.sRV,
      this.pRICEOFINITIALWT,
      this.cODE,
      this.cODENAME,
      this.tRANSHMNTSTN,
      this.oUTAGENCY,
      this.aREA,
      this.pOLICEVI,
      this.oAPROADDR,
      this.iNITIALWT,
      this.dIVNO,
      this.pRICEOFADDLWT,
      this.wHARFSLAB,
      this.zONE,
      this.cRISSTNNO,
      this.dIVCODE,
      this.rPFI,
      this.sQUARE,
      this.oAPROPNAME,
      this.sTNNUMBER,
      this.aDDLWT,
      this.aDD3,
      this.aDD2,
      this.aDD1});

  StationDetailRest.fromJson(Map<String, dynamic> json) {
    sTATE = json['STATE'];
    tOTPLTFRMS = json['TOT_PLTFRMS'];
    pBOOKING = json['PBOOKING'];
    jUNCTIONSTNFLAG = json['JUNCTION_STN_FLAG'];
    rLYCODE = json['RLY_CODE'];
    sCTN = json['SCTN'];
    sTNCLASS = json['STN_CLASS'];
    wHARFRATETYPE = json['WHARF_RATE_TYPE'];
    eXTRAOUTCHRGREASON = json['EXTRA_OUT_CHRG_REASON'];
    gAUGE = json['GAUGE'];
    dETAIL = json['DETAIL'];
    dISTCODE = json['DIST_CODE'];
    eXTRAOUTCHRG = json['EXTRA_OUT_CHRG'];
    sRV = json['SRV'];
    pRICEOFINITIALWT = json['PRICEOFINITIALWT'];
    cODE = json['CODE'];
    cODENAME = json['CODENAME'];
    tRANSHMNTSTN = json['TRANSHMNT_STN'];
    oUTAGENCY = json['OUTAGENCY'];
    aREA = json['AREA'];
    pOLICEVI = json['POLICE_VI'];
    oAPROADDR = json['OA_PRO_ADDR'];
    iNITIALWT = json['INITIALWT'];
    dIVNO = json['DIV_NO'];
    pRICEOFADDLWT = json['PRICEOFADDLWT'];
    wHARFSLAB = json['WHARF_SLAB'];
    zONE = json['ZONE'];
    cRISSTNNO = json['CRIS_STNNO'];
    dIVCODE = json['DIV_CODE'];
    rPFI = json['RPF_I'];
    sQUARE = json['SQUARE'];
    oAPROPNAME = json['OA_PROP_NAME'];
    sTNNUMBER = json['STN_NUMBER'];
    aDDLWT = json['ADDLWT'];
    aDD3 = json['ADD3'];
    aDD2 = json['ADD2'];
    aDD1 = json['ADD1'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['STATE'] = this.sTATE;
    data['TOT_PLTFRMS'] = this.tOTPLTFRMS;
    data['PBOOKING'] = this.pBOOKING;
    data['JUNCTION_STN_FLAG'] = this.jUNCTIONSTNFLAG;
    data['RLY_CODE'] = this.rLYCODE;
    data['SCTN'] = this.sCTN;
    data['STN_CLASS'] = this.sTNCLASS;
    data['WHARF_RATE_TYPE'] = this.wHARFRATETYPE;
    data['EXTRA_OUT_CHRG_REASON'] = this.eXTRAOUTCHRGREASON;
    data['GAUGE'] = this.gAUGE;
    data['DETAIL'] = this.dETAIL;
    data['DIST_CODE'] = this.dISTCODE;
    data['EXTRA_OUT_CHRG'] = this.eXTRAOUTCHRG;
    data['SRV'] = this.sRV;
    data['PRICEOFINITIALWT'] = this.pRICEOFINITIALWT;
    data['CODE'] = this.cODE;
    data['CODENAME'] = this.cODENAME;
    data['TRANSHMNT_STN'] = this.tRANSHMNTSTN;
    data['OUTAGENCY'] = this.oUTAGENCY;
    data['AREA'] = this.aREA;
    data['POLICE_VI'] = this.pOLICEVI;
    data['OA_PRO_ADDR'] = this.oAPROADDR;
    data['INITIALWT'] = this.iNITIALWT;
    data['DIV_NO'] = this.dIVNO;
    data['PRICEOFADDLWT'] = this.pRICEOFADDLWT;
    data['WHARF_SLAB'] = this.wHARFSLAB;
    data['ZONE'] = this.zONE;
    data['CRIS_STNNO'] = this.cRISSTNNO;
    data['DIV_CODE'] = this.dIVCODE;
    data['RPF_I'] = this.rPFI;
    data['SQUARE'] = this.sQUARE;
    data['OA_PROP_NAME'] = this.oAPROPNAME;
    data['STN_NUMBER'] = this.sTNNUMBER;
    data['ADDLWT'] = this.aDDLWT;
    data['ADD3'] = this.aDD3;
    data['ADD2'] = this.aDD2;
    data['ADD1'] = this.aDD1;
    return data;
  }
}