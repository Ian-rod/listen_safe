import 'package:flutter/cupertino.dart';
import 'package:listensafe/l10n/app_localizations.dart';

class EmptyResultScreen extends StatelessWidget {
  const EmptyResultScreen({super.key});

@override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: SizedBox(
          width:  MediaQuery.of(context).size.width,
          height:MediaQuery.of(context).size.height/2 ,
            child: Image(image: AssetImage("assets/imageAssets/Oops.png"),fit: BoxFit.fitHeight,),
          ),
        ),
        Center(child: Text(localizations.missingMedia)),
        Center(child: Text(localizations.forNow))
      ],
    );
  }
}