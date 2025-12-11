import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:listensafe/AppConstants/current_state_objects.dart';
import 'package:listensafe/DataModels/song.dart';

class SongDetails extends StatefulWidget {
  const SongDetails({super.key});

  @override
  State<SongDetails> createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {
 Song currentSong=Current.song;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              height:400,
              width: 400,
              child: Hero(tag:"songImage", child: Image(
                              image: NetworkImage(currentSong.imageUrl),
                            ),),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
               title: Text(currentSong.songName,style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text(currentSong.artistName,style: TextStyle(fontStyle: FontStyle.italic)),
                          trailing: currentSong.hasBadWord
                              ? Icon(Icons.cancel, color: AppConstants.error)
                              : Icon(
                                  Icons.check_circle,
                                  color: AppConstants.success,
                                ),
            ),
          ),

          ///See list of bad words
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton.icon(
              icon: Icon(Icons.remove_red_eye),
              onPressed: (){
                ///call hasBadWordAndBadWordList in an isolate with an isDEtailed set to true
            }, label: Text("View explicit words")),
          )
        ],
      )
      ),
    );
  }
}