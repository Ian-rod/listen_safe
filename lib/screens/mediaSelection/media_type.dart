import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:listensafe/l10n/app_localizations.dart';
import 'package:listensafe/screens/mediaSelection/film_selection.dart';
import 'package:listensafe/screens/mediaSelection/song_selection.dart';

class SelectMedia extends StatefulWidget {
  const SelectMedia({super.key});

  @override
  State<SelectMedia> createState() => _SelectMediaState();
}

class _SelectMediaState extends State<SelectMedia> {
  //to be declared on the first page
  late AppLocalizations localizations; 
  @override
  Widget build(BuildContext context) {
    localizations = AppLocalizations.of(context)!;

    //For any window that wants to access outside context
    AppConstants.localizations=localizations;
    return Scaffold(
     body: Builder(builder: (context)=>
      LiquidSwipe(
        waveType: WaveType.liquidReveal,
        pages: [
        //Build the selection pages here
        FilmSelection(),
        SongSelection()
     ])), 
    );
}}