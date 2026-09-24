//Functions for the Local storage
import 'package:flutter/cupertino.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


getLastSearched({bool isFilm=false}) async
{
  String? lastSearched="";
  try {
    final pref=await SharedPreferences.getInstance();
    if(isFilm){
      lastSearched=pref.getString("lastSearchedFilm");
      AppConstants.lastSearchedFilm=lastSearched??""; 
    }
    else{
      lastSearched=pref.getString("lastSearched");
      AppConstants.lastSearchedSong=lastSearched??"";  
    }
  
  } catch (e) {
     debugPrint("Error encountered: ${e.toString()}");
     return "";
  }
}

saveLastSearched({bool isFilm=false}) async{
try {
   final pref=await SharedPreferences.getInstance();
   if(isFilm){
    pref.setString("lastSearchedFilm", AppConstants.lastSearchedFilm); 
   }
   else{
     pref.setString("lastSearched", AppConstants.lastSearchedSong); 
   }

   debugPrint("Last searched set succesfully");
} catch (e) {
  debugPrint("Error encountered: ${e.toString()}");
}
}

//get AI_MODE status
getAIModeStatus() async
{
  try {
    final pref=await SharedPreferences.getInstance();
    AppConstants.aimode=bool.parse(pref.getString("ai_mode")??"false");
  } catch (e) {
     debugPrint("Error encountered: ${e.toString()}");
     return "";
  }
}

saveAIModeStatus() async{
try {
  final pref=await SharedPreferences.getInstance();
   pref.setString("ai_mode", AppConstants.aimode.toString()); 
   debugPrint("AI_mode set succesfully");
} catch (e) {
  debugPrint("Error encountered: ${e.toString()}");
}
}