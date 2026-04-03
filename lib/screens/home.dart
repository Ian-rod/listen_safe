import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:listensafe/AppConstants/current_state_objects.dart';
import 'package:listensafe/AppConstants/reusable_widgets.dart';
import 'package:listensafe/DataModels/song.dart';
import 'package:listensafe/l10n/app_localizations.dart';
import 'package:listensafe/requests/listen_safe.dart';
import 'package:listensafe/requests/local_storage.dart';
import 'package:listensafe/screens/initialScreens/initial_screen_search.dart';

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

  double deviceHeight=0;
  double deviceWidth=0;
  late ScaffoldMessengerState messenger;
  late AppLocalizations localizations; 

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
    deviceHeight=MediaQuery.of(context).size.height;
    deviceWidth=MediaQuery.of(context).size.width;
    messenger = ScaffoldMessenger.of(context);
    localizations = AppLocalizations.of(context)!;

    //For any window that wants to access outside context
    AppConstants.localizations=localizations;

    return Scaffold(
      appBar: AppBar(title: Text(localizations.isItSafe),
      actions: [IconButton(onPressed: (){
        //Open the user added word management screen
        Navigator.pushNamed(context, "/user_words_management");
      }, icon: Icon(Icons.miscellaneous_services_sharp))],),
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
                filled: true,
                fillColor: AppConstants.secondary, 
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
       AppConstants.lastSearched.isEmpty?Expanded(child: Center(child: InitialScreenSearch()),):Expanded(
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
      floatingActionButton: FloatingActionButton(
        tooltip: localizations.enterExplicit,
        onPressed: (){
        //Pop up to add a word to be filtered
        showModalBottomSheet(context: context, builder: (context) {
          bool englishSelected=true;
          bool germanSelected=false;
          TextEditingController explicitWordcontroller = TextEditingController();
          GlobalKey<FormState> formKey=GlobalKey();
          return StatefulBuilder(
            builder: (context,setState) {
              return SizedBox(
                height: deviceHeight/4,
                width: deviceWidth,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [   
                        //Englisch
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 2, 8),
                          child: ChoiceChip(label: Text(localizations.english),
                          labelStyle: TextStyle(color: englishSelected?Colors.white:Colors.black),
                           selected: englishSelected,
                           backgroundColor: englishSelected?AppConstants.primary:Colors.white,
                           selectedColor: AppConstants.primary,
                           checkmarkColor: Colors.white,                      
                           onSelected: (isSelected){
                            setState(() {
                              englishSelected=isSelected;
                              germanSelected=!isSelected;
                            });
                           },),
                        ),
                        ///Deutsch
                        Padding(
                          padding: const EdgeInsets.fromLTRB(2, 8, 8, 8),
                          child: ChoiceChip(label: Text(localizations.german),
                          labelStyle: TextStyle(color: germanSelected?Colors.white:Colors.black),
                           selected: germanSelected,
                           backgroundColor:germanSelected? AppConstants.primary:Colors.white,
                           selectedColor: AppConstants.primary,
                           checkmarkColor: Colors.white,
                           onSelected: (isSelected){
                            setState(() {
                              germanSelected=isSelected;
                              englishSelected=!isSelected;
                            });
                           },),
                        ),
                      ],
                    ),
                    //Text Box for the Explicit Word
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                  controller: explicitWordcontroller,
                  autocorrect: true,
                  decoration: InputDecoration(
                    hint: Text(localizations.enterExplicit),
                    prefixIcon: Icon(Icons.my_library_add_outlined),
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
                 validator: (value) {
                  if (value == null || value.isEmpty) {
                  return localizations.enterExplicit;
                  }
                   return null;
                 },
                  ),
                ),
              ),
              //Save or Cancel
              Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(onPressed:()async{
                  if(!formKey.currentState!.validate()) return;
                   ReusableWidgets.operationResultSnackbar(await ListenSafe.addNewBadWord(explicitWordcontroller.text,englishSelected?"En":"De"), messenger);
                   if(context.mounted)
                   {
                     Navigator.of(context).pop();
                   }
                  } ,
                   label: Text("Save"),
                   icon: Icon(Icons.save_rounded),
                   ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton.icon(style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppConstants.error)),
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, label: Text("Cancel"),
                  icon: Icon(Icons.cancel_rounded)),
                )
              ],)
                  ],
                ),
              );
            }
          );
        },);
      },child: Icon(Icons.add_moderator_rounded),),
    );
  }
}
