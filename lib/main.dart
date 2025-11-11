import 'package:flutter/material.dart';
import 'package:listensafe/app_constants.dart';
import 'package:listensafe/l10n/app_localizations.dart';
import 'package:listensafe/screens/home.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      supportedLocales: const [
        Locale('en', ''), // English
        Locale('de', ''), // German
      ],
      localizationsDelegates: const [AppLocalizations.delegate],

      ///Some basic theme data for the app
      theme: ThemeData(
        primaryColor: AppConstants.primary,
        appBarTheme: AppBarTheme(
          backgroundColor: AppConstants.primary,
          foregroundColor: AppConstants.secondary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppConstants.primary,
            foregroundColor: AppConstants.secondary,
          ),
        ),
      ),

      routes: {"/": ((context) => const Homescreen())},
    ),
  );
}
