import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';

class FilmSelection extends StatelessWidget {
  const FilmSelection({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceWidth=MediaQuery.of(context).size.width;
     double deviceHeight=MediaQuery.of(context).size.height;
    return Container(
      color: AppConstants.accent,
      width: deviceWidth,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
            width: deviceWidth/2,
            height: deviceWidth/2,
            decoration: BoxDecoration(
              color: AppConstants.primary,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(deviceWidth/2), // Equal to width
              topRight: Radius.circular(deviceWidth/2),),),
             child: Image.asset("assets/imageAssets/film_select.jpg", fit: BoxFit.
              fill,)),
          ),
            AnimatedTextKit(
              animatedTexts:[
              ColorizeAnimatedText("Is the film safe?", textStyle: TextStyle(fontSize: 35,fontStyle: FontStyle.italic), colors: [AppConstants.secondary,AppConstants.accent])
            ] )
        ],
      )
    );
  }
}