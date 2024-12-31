class AppURLs {
  static String baseUrl = 'https://parcel.indianrail.gov.in';

  static const String loginURL =
      'appBaseURL/PMSRestServices/services/PMSStatus/validateUser/';

  static const String signUpURL =
      'appBaseURL/PMSRestServices/services/PMSStatus/registerUser/';

  static const String versioninfoUrl =
      "appBaseURL/PMSRestServicesv23/services/PMSStatus/getHhtUpdates/";

  static const String verifyHHTSerialnoUrl =
      "appBaseURL/PMSRestNRAD/services/PMSStatus/verifyDevice/";

  static const String apiUrl =
      "appBaseURL/PMSRestServices/services/PMSStatus/validateUser/";

  static const String icmsUrl =
      "appBaseURL/PMSRestServicesv23/services/PMSStatus/ntesRestServices/";

  static const String loadingSummaryUrl =
      "appBaseURL/PMSRestServices/services/PMSStatus/DataFromICMSToPMSRest/";

  static const String syncUnLoadServeUrl =
      "appBaseURL/PMSRestServicesv23/services/PMSStatus/saveUnLoadingSummary/";

  static const String syncServeUrl =
      "appBaseURL/PMSRestServicesv23/services/PMSStatus/saveLoadingSummary/";

  static const String serachPrrLoadUrl =
      "appBaseURL/PMSRestServicesv23/services/PMSStatus/searchPwbLoad";

  static const String serachPrrUnLoadUrl =
      "appBaseURL/PMSRestServicesv23/services/PMSStatus/searchPwbUnload/";

  static const String showGuidanceUrl =
      "appBaseURL/PMSRestServicesv23/services/PMSStatus/getActualLoadDtls/";

  static const String showUnLoadGuidanceUrl =
      "appBaseURL/PMSRestServicesv23/services/PMSStatus/getPropUnloadDtls/";

  static const String prrStatusUrl =
      "appBaseURL/PMSRestServices/services/PMSStatus/BookingRecNonSysInclRest/";

  static const String stationdetailUrl =
      "appBaseURL/PMSRestServices/services/PMSStatus/StationDetailRest/";

  static const String validateTrainUnloadUrl =
      "appBaseURL/PMSRestServicesv23/services/PMSStatus/validateTrainUnload/";

  static const String validateTrainLoadUrl =
      "appBaseURL/PMSRestServicesv23/services/PMSStatus/validateTrainLoad/";

  static const String trnDtlsUrl =
      "appBaseURL/PMSRestServices/services/PMSStatus/getTrndtls/";

  static const String userMasterUrl =
      "appBaseURL/PMSRestServices/services/PMSStatus/UserMasterRest";

  static const String railwayALUrl =
      "appBaseURL/PMSRestServices/services/PMSStatus/getRailwayAL/";

  static const String wagonMasterUrl =
      "appBaseURL/PMSRestServices/services/PMSStatus/getWagonMaster/";

  static const String wagtypeALUrl =
      "appBaseURL/PMSRestServices/services/PMSStatus/getWagTypeAL/";

  static const String plateformMasterUrl =
      "appBaseURL/PMSRestServices/services/PMSStatus/getPlatformMaster/";

  static const String m_pkg_descUrl =
      "appBaseURL/PMSRestServices/services/PMSStatus/getM_PKG_DESC/";

  static const String m_pkg_condnUrl =
      "appBaseURL/PMSRestServices/services/PMSStatus/getPkgCondnMaster/";

  static const String barcodeDetailsUrl =
      "appBaseURL/HHPWSDLServices/services/BarCode/get_item_details/";

  static const String getbcodeDetailsUrl =
      "appBaseURL//HHPWSDLServices/services/BarCode/get_barcodeRest/";
}
