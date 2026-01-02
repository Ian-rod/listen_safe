import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:listensafe/AppConstants/current_state_objects.dart';
import 'package:listensafe/AppConstants/reusable_widgets.dart';
import 'package:listensafe/DataModels/song.dart';
import 'package:listensafe/l10n/app_localizations.dart';
import 'package:listensafe/requests/listen_safe.dart';
import 'package:listensafe/requests/local_storage.dart';
import 'package:listensafe/screens/initial_screen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  ///CheckText before request search
  makeRequest([bool withSave=false]) async {
    if (controller.text.isEmpty) {
      return;
    } else {
      //Set to is searching state
      setState(() {
      ///set last searched
      AppConstants.lastSearched=controller.text;
        isPageRefreshing = true;
      });
      if (withSave)
      {
        saveLastSearched();
      }
      List<Map<String, dynamic>> refreshedItems = await ListenSafe.search(
        controller.text,
      );
      setState(() {
        listOfItems = refreshedItems;
        isPageRefreshing = false;
      });
    }
  }

  //Page variables
  List<Map<String, dynamic>> listOfItems = [];
  bool isPageRefreshing = false;

  ///The search Input Controller
  TextEditingController controller = TextEditingController();

@override
  void initState() {
    super.initState();
    //Initial call for get last
     initializeLastSong();
  }

  initializeLastSong() async{
   await getLastSearched();
    setState(() {
      controller.text=AppConstants.lastSearched;
    });
    if(AppConstants.lastSearched.isNotEmpty)
    {
      makeRequest();
    }
  }
  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localizations.isItSafe), centerTitle: true),
       body:
       Column(
        children: [
          ///The search bar
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: controller,
              autocorrect: true,
              decoration: InputDecoration(
                hint: Text(localizations.searchHintText),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  color: AppConstants.primary,
                  onPressed: () => makeRequest(true),
                ),
                enabled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius,
                  ),
                  borderSide: BorderSide(
                    color: AppConstants.primary,
                    width: AppConstants.borderRadiusWidth,
                  ),
                ),
              ),
              onSubmitted: (value) => makeRequest(true),
            ),
          ),
          //Main application Body
       AppConstants.lastSearched.isEmpty?Expanded(child: Center(child: InitialScreen()),):Expanded(
            child: isPageRefreshing
                ? ReusableWidgets.loadingAnimation(110)
                : ListView.builder(
                    itemCount: listOfItems.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> songItem = listOfItems[index];
                      Song currentSong = Song(songItem);
                      return ListTile(
                        onTap: (){
                          Current.song=currentSong;
                          ///Navigate to the song details page
                          Navigator.pushNamed(context, "/song_details");
                        } ,
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.network(
                              currentSong.thumbnailImageUrl,
                              loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                          
                            return ReusableWidgets.loadingAnimationVar2(50);
                          },
                            ),
                        ),
                        title: Text(currentSong.songName),
                        subtitle: Text(currentSong.artistName),
                        trailing:Icon(Icons.music_note_sharp,color: AppConstants.primary,)
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
