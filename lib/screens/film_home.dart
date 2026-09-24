//This is the film home screen

import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:listensafe/AppConstants/current_state_objects.dart';
import 'package:listensafe/AppConstants/reusable_widgets.dart';
import 'package:listensafe/DataModels/film.dart';
import 'package:listensafe/requests/listen_safe_films.dart';
import 'package:listensafe/screens/staticScreens/empty_result_screen.dart';
import 'package:listensafe/screens/staticScreens/initialScreens/initial_screen_search.dart';

class FilmHomeScreen extends StatefulWidget {
  const FilmHomeScreen({super.key});

  @override
  State<FilmHomeScreen> createState() => _FilmHomeScreenState();
}

class _FilmHomeScreenState extends State<FilmHomeScreen> {

    ///The search Input Controller
  TextEditingController controller = TextEditingController();

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
        //TODO:Implement last searched for films
        //saveLastSearched();
      }
      List<Map<String, dynamic>> refreshedItems = await ListenSafeFilms.search(
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

  double deviceHeight=0;
  double deviceWidth=0;
  late ScaffoldMessengerState messenger;

  GlobalKey<FormState> formKey=GlobalKey();

  @override
  Widget build(BuildContext context) {
    deviceHeight=MediaQuery.of(context).size.height;
    deviceWidth=MediaQuery.of(context).size.width;
    messenger = ScaffoldMessenger.of(context);

    return  Scaffold(
      appBar: AppBar(title: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(AppConstants.localizations.isItSafe)),
      actions: [IconButton(onPressed: (){
        //Open the user added word management screen
        Navigator.pushNamed(context, "/user_words_management");
      }, icon: Icon(Icons.miscellaneous_services_sharp))],),
      body: Column(
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
                hint: Text(AppConstants.localizations.searchHintText),
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
                : listOfItems.isEmpty? EmptyResultScreen(): ListView.builder(
                    itemCount: listOfItems.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> filmItem = listOfItems[index];
                      Film currentFilm = Film(filmItem);
                      return ListTile(
                        onTap: (){
                          Current.film=currentFilm;
                          ///Navigate to the song details page
                          Navigator.pushNamed(context, "/film_details");
                        } ,
                        leading: SizedBox(
                          height: 50,
                          width: 50,
                          child: Image.network(
                              currentFilm.thumbnailImageUrl,
                              loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                          
                            return ReusableWidgets.loadingAnimationVar2(50);
                          },
                            ),
                        ),
                        title: Text("${currentFilm.title} (${currentFilm.year})"),
                        subtitle: Text(currentFilm.type),
                        trailing:Icon(Icons.movie_rounded,color: AppConstants.primary,)
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}