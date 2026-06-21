import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:listensafe/AppConstants/current_state_objects.dart';
import 'package:listensafe/AppConstants/reusable_widgets.dart';
import 'package:listensafe/DataModels/song.dart';
import 'package:listensafe/l10n/app_localizations.dart';
import 'package:listensafe/requests/listen_safe_songs.dart';
import 'package:listensafe/requests/local_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SongDetails extends StatefulWidget {
  const SongDetails({super.key});

  @override
  State<SongDetails> createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {
 Song currentSong=Current.song;
 double chancesOfBadWord=1;
///Device height and width
late double deviceHeight=MediaQuery.of(context).size.height;
late double deviceWidth=MediaQuery.of(context).size.width;

///To get a full list of Badwords
getFullListBadWords() async 
{
  if(AppConstants.aimode)
  {
    chancesOfBadWord=await badWordHTMLFromModel(currentSong.lyricsResult);
    setState(() {
      currentSong.completeListFetched=true;
      retrievingBadWords=false;
    });
  }
  else{
      final receivePort=ReceivePort();
  await Isolate.spawn(badWordListIsolate,  {
    'lyricsResult': currentSong.lyricsResult,
    'sendPort': receivePort.sendPort,
    'wordsToFilter':ListenSafeSongs.wordsToFilter
  },);

  receivePort.listen((badwordsList){
  setState(() {
    retrievingBadWords=false;
    currentSong.unsafeWordsFound=badwordsList;
    currentSong.hasBadWord=badwordsList.isNotEmpty;
    currentSong.completeListFetched=true;
  });
  });
  }
}

//Show or Hide Bad Words
bool showBadwords=false;
bool retrievingBadWords=false;
  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localizations.songDetails),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () async{
              setState(() {
                AppConstants.aimode=!AppConstants.aimode;
              });
              saveAIModeStatus();
            },
             splashColor: Colors.transparent,
             highlightColor: Colors.transparent,
             hoverColor: Colors.transparent,
            
            child: CircleAvatar( 
              backgroundColor: AppConstants.aimode?AppConstants.primary:Colors.transparent,
              foregroundColor:  AppConstants.aimode?Colors.white:AppConstants.primary,
              child: Text("AI"),
            ),
          ),
        )
      ],
      ),
      body: ListView(
      shrinkWrap: true,
        children: [
          SizedBox(
            height: deviceHeight/2,
            width: deviceWidth,
            child: Image.network(
              currentSong.imageUrl,
              loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            
            return ReusableWidgets.loadingAnimationVar2(150);
                      }
                          ),
          ),
      
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
               title: Text(currentSong.songName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
                          subtitle: Text(currentSong.artistName,style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20)),
                          trailing:currentSong.hasBadWord==null?Icon(Icons.question_mark, color: AppConstants.primary):currentSong.hasBadWord!
                              ? Icon(Icons.cancel, color: AppConstants.error,size: 50,)
                              : Icon(
                                  Icons.check_circle,
                                  color: AppConstants.success,
                                  size: 50,
                                ),
            ),
          ),
      
          ///See list of bad words
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: ElevatedButton.icon(
              icon: Icon(showBadwords?Icons.hide_source_outlined:Icons.remove_red_eye),
              onPressed: ()async{
                ///call hasBadWordAndBadWordList in an isolate with an isDEtailed set to true
              if(showBadwords)
              {
                setState(() {
                  showBadwords=false;
                });
              }
              else{
                setState(() {
                  showBadwords=true;
                });
                if(!currentSong.completeListFetched)
                {
                setState(() {
                  retrievingBadWords=true;
                });
                getFullListBadWords();
                }
              }
               
            }, label: Text(showBadwords?localizations.hideExplicit:localizations.viewExplicit)),
          ),
      
          ///Chip list of the Items
          showBadwords?
          SizedBox(
            height: 250,
            width: deviceWidth,
            child: retrievingBadWords?
                        ReusableWidgets.loadingAnimationVar2(120)
                        : AppConstants.aimode? 
                   (chancesOfBadWord<0?
                   Center(child: SizedBox(child: Text(AppConstants.localizations.errorModel,style: TextStyle(fontWeight: FontWeight.bold,color: AppConstants.error),),)):
                        CircularPercentIndicator(
            radius: deviceWidth/4,
             lineWidth: 10.0,
             percent: chancesOfBadWord,
             center: Text("${AppConstants.localizations.explicitScore}: ${chancesOfBadWord*100}%",style: TextStyle(fontWeight: FontWeight.bold),),
             progressBorderColor: AppConstants.error,
             backgroundColor: Colors.grey,
                        ))
                        :Wrap(
              
              children: currentSong.unsafeWordsFound.map((word){
              return  Padding(
                padding: const EdgeInsets.all(3.0),
                child: Chip(
                  backgroundColor: AppConstants.primary,
                 shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), 
                              ),
                  label: Text(word,style: TextStyle(color: Colors.white),)),
              );
            
              }).toList(),
            ),
          ):SizedBox()
        ],
      ),
    );
  }
}