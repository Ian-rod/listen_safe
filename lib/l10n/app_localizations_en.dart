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
}
