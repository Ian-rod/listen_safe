import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:listensafe/AppConstants/current_state_objects.dart';
import 'package:listensafe/AppConstants/reusable_widgets.dart';
import 'package:listensafe/DataModels/film.dart';
import 'package:listensafe/l10n/app_localizations.dart';
import 'package:listensafe/requests/listen_safe_films.dart';

class FilmDetails extends StatefulWidget {
  const FilmDetails({super.key});

  @override
  State<FilmDetails> createState() => _FilmDetailsState();
}

class _FilmDetailsState extends State<FilmDetails> {
  Film currentFilm=Current.film;


  late double deviceHeight=MediaQuery.of(context).size.height;
  late double deviceWidth=MediaQuery.of(context).size.width;

bool queryingPlot=false;
  //query plot
  queryPlot() async 
{
  queryingPlot=true;
  if(currentFilm.plot.isEmpty){
    currentFilm.plot= await ListenSafeFilms.queryPlot(currentFilm.imdbID);
  }
  setState(() {
    queryingPlot=false;
  });
}

@override
  void initState() {
    queryPlot();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: FittedBox(
        fit: BoxFit.fitWidth,
        child: Text(localizations.filmDetails)),
    ),
    body: queryingPlot?ReusableWidgets.loadingAnimation(110):ListView(
      shrinkWrap: true,
      children: [  
        SizedBox(
            height: deviceHeight/2,
            width: deviceWidth,
            child: Image.network(
              currentFilm.thumbnailImageUrl,
              loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            
            return ReusableWidgets.loadingAnimationVar2(150);
                }
            ),
          ),
            Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
               title: Text(currentFilm.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 40),),
                          subtitle: Text('${currentFilm.type} (${currentFilm.year})',style: TextStyle(fontStyle: FontStyle.italic,fontSize: 20)),
                          trailing:Icon(Icons.movie),
            ),
          ),

          //Plot overview
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Center(
              child: Card(
                elevation: 10,
                  shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: AppConstants.secondary, width: 1), 
            ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(currentFilm.plot),
                )),
            ),
          )
      ],
    ),
    
    
    );
  }
}