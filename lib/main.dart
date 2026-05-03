import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:listensafe/l10n/app_localizations.dart';
import 'package:listensafe/screens/home.dart';
import 'package:listensafe/screens/mediaSelection/media_type.dart';
import 'package:listensafe/screens/song_details.dart';
import 'package:listensafe/screens/u_words_management.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('de', ''), // German
      ],
      localizationsDelegates: const [AppLocalizations.delegate],

      debugShowCheckedModeBanner: false,

      ///Some basic theme data for the app
      theme: ThemeData(
        primaryColor: AppConstants.primary,
        appBarTheme: AppBarTheme(
          titleTextStyle:TextStyle(fontWeight: FontWeight.bold,fontSize: 30,color: AppConstants.primary) ,
          foregroundColor: AppConstants.primary,
          backgroundColor: Colors.transparent,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.primary,
            foregroundColor: AppConstants.secondary,
          ),
        ),
      ),

      routes: {
      "/": ((context) => const SelectMedia()),
      "/song_details": ((context) => const SongDetails()),
      "/user_words_management":((context)=>const UserWordsManagement())
      },
    ),
  );
}
