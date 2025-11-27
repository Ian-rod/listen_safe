import 'package:flutter/material.dart';

class AppConstants {
  ///Colors of the UI
  static Color primary = const Color(0xFF1E3A8A);
  static Color secondary = const Color(0xFFE5E7EB);
  static Color accent = const Color(0xFFDC2626);

  ///Errors and sucess
  static Color success = Colors.green[700]!;
  static Color error = Colors.red[700]!;

  ///App Constants
  static double borderRadiusWidth = 2;
  static double borderRadius = 15;

  static String clientSecret =
      "p1jBIHe2B7fq8hxZDrJLoMDKPBWoR-G1qm4vWVUHcLMATn4SEiF4T1adZ_W5WOxEvtofUFabMMkpAD65Unl4HA";
  static String clientID =
      "RwXZnsRo_PvYVoiPtFRwJcdJZ-CWRLJbs9G383ePeipp6evCtWIrhVAfDoepqzcJ";
  static String accessToken =
      "9qcWylUBZnTmNFM-QALdB7WSN5w0DYPKGpMDRdb6e5sgYbynPo2QzEpIcfkOyS75";
  static String redirectUrl = "https://github.com/Ian-rod";
  static String badWordsSource = "lib\\assets\\badWordsEn.txt";
}
