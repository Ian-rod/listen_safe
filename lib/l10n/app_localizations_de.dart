// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get isItSafe => 'Ist es sicher?';

  @override
  String get searchHintText => 'Geben Sie einen Artikel zur Suche ein..';

  @override
  String get viewExplicit => 'Explizite Wörter anzeigen';

  @override
  String get songDetails => 'Details zum Lied';

  @override
  String get hideExplicit => 'Explizite Wörter verstecken';
}
