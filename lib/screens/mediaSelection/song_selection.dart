import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';

class SongSelection extends StatelessWidget {
  const SongSelection({super.key});

  @override
  Widget build(BuildContext context) {
      double deviceWidth=MediaQuery.of(context).size.width;
     double deviceHeight=MediaQuery.of(context).size.height;
    return Container(
      color: AppConstants.primary,
      width: deviceWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: deviceHeight/8,
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                width: deviceWidth/2,
                height: deviceWidth/2,
                decoration: BoxDecoration(
                  color: AppConstants.accent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(deviceWidth/2), // Equal to width
                  topRight: Radius.circular(deviceWidth/2),),),
                 child: Image.asset("assets/imageAssets/song_select.jpg", fit: BoxFit.
                  fill,)),
              ),
                          AnimatedTextKit(
              animatedTexts:[
              ColorizeAnimatedText(AppConstants.localizations.songSafe, textStyle: TextStyle(fontSize: 35,fontStyle: FontStyle.italic), colors: [AppConstants.secondary,AppConstants.primary])
            ] ),
            ],
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(onPressed: ()
              {
                Navigator.pushReplacementNamed(context, "/song_home");
              }, label:Text(AppConstants.localizations.findOut),icon: Icon(Icons.search),iconAlignment: IconAlignment.end, style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(AppConstants.accent)
              ),),
            )
        ],
      ),
    );
  }
}