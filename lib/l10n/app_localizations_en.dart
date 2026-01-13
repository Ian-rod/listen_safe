// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get isItSafe => 'Is it safe?';

  @override
  String get searchHintText => 'Enter an article to search..';

  @override
  String get viewExplicit => 'View explicit words';

  @override
  String get songDetails => 'Song details';

  @override
  String get hideExplicit => 'Hide explicit';

  @override
  String get letsCheck => 'Let\'s Check what\'s safe to listen to today';

  @override
  String get clickSearch => 'Click the search to begin';

  @override
  String get english => 'English';

  @override
  String get german => 'German';

  @override
  String get enterExplicit => 'Enter an explicit word';

  @override
  String get successExplicitAdd => 'Explicit word added';

  @override
  String get errorAddingExplicit => 'Error adding new explicit word';
}
