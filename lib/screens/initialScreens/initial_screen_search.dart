//This is the initial screen when the user hasn't searched any word 
//Most of them should follow the same template  of an image with a localized text


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:listensafe/l10n/app_localizations.dart';

class InitialScreenSearch extends StatelessWidget {
  const InitialScreenSearch({super.key});

  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
          width:  MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height/2 ,
            child: Image(image: AssetImage("assets/imageAssets/RacoonDJ.jpg"),fit: BoxFit.fitHeight,),
          ),
        ),
        Text(localizations.letsCheck),
        Text(localizations.clickSearch)
      ],
    );
  }
}