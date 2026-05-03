import 'package:flutter/material.dart';

class SongSelection extends StatelessWidget {
  const SongSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 600,
          width: 600,
          child: Image.asset("assets/imageAssets/song_select.jpg", fit: BoxFit.fitWidth,))
      ],
    );
  }
}