import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';

class FilmSelection extends StatelessWidget {
  const FilmSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          width: 600,
          child: Image.asset("assets/imageAssets/film_select.jpg", fit: BoxFit.fitWidth,))
          
      ],
    );
  }
}