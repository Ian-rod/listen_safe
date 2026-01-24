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

  @override
  String get letsCheck => 'Lasst uns überprüfen, was man heute gefahrlos anhören kann';

  @override
  String get clickSearch => 'Klicken Sie auf Suchen, um zu beginnen.';

  @override
  String get english => 'Englisch';

  @override
  String get german => 'Deutsch';

  @override
  String get enterExplicit => 'Geben Sie ein explizites Wort ein';

  @override
  String get successExplicitAdd => 'Explizites Wort hinzugefügt';

  @override
  String get errorAddingExplicit => 'Fehler beim Hinzufügen eines neuen expliziten Worts';

  @override
  String get emptyUserDefinedWords => 'Hier können Sie explizite Wörter für die Filterung verwalten';

  @override
  String get successDeletingWord => 'Erfolgreich gelöscht';

  @override
  String get errorDeletingWord => 'Fehler beim Löschen';
}
