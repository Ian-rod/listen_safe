import 'package:flutter/cupertino.dart';
import 'package:listensafe/l10n/app_localizations.dart';

class InitialScreenExplicitWordManagement extends StatelessWidget {
  const InitialScreenExplicitWordManagement
({super.key});

  @override
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
            child: Image(image: AssetImage("assets/imageAssets/catDJ.jpg"),fit: BoxFit.fitHeight,),
          ),
        ),
        Text(localizations.emptyUserDefinedWords),
      ],
    );
  }
}