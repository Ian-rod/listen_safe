import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';

class SongSelection extends StatelessWidget {
  const SongSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConstants.primary,
      child: Column(
        children: [
          SizedBox(
            height: 600,
            width: 600,
            child: Image.asset("assets/imageAssets/song_select.jpg", fit: BoxFit.fitWidth,)),
            AnimatedTextKit(animatedTexts:[
              ColorizeAnimatedText("Is the song safe", textStyle: TextStyle(fontSize: 35), colors: [AppConstants.secondary,AppConstants.accent,AppConstants.success])
            ] )
        ],
      ),
    );
  }
}