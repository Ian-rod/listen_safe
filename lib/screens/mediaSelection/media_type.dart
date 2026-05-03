import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:listensafe/screens/mediaSelection/film_selection.dart';
import 'package:listensafe/screens/mediaSelection/song_selection.dart';

class SelectMedia extends StatefulWidget {
  const SelectMedia({super.key});

  @override
  State<SelectMedia> createState() => _SelectMediaState();
}

class _SelectMediaState extends State<SelectMedia> {
  String infoText="Swipe to search for a song";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Builder(builder: (context)=>
      LiquidSwipe(
        waveType: WaveType.circularReveal,
        slideIconWidget:TextButton.icon(onPressed: (){}, label: Text(infoText),icon:Icon(Icons.swipe_sharp),),
        currentUpdateTypeCallback: (updateType) {
          if(updateType.index==0)
          {
            setState(() {
              infoText="Swipe to search for a song";
            });
          }
          else{
            setState(() {
              infoText="Swipe to search for a Film";
            });
          }
        },
        pages: [
        //Build the selection pages here
        FilmSelection(),
        SongSelection()
     ])), 
    );
}}