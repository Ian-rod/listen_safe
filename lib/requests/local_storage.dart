//Functions for the Local storage
import 'package:flutter/cupertino.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';


getLastSearched() async
{
  String? lastSearched="";
  try {
    final pref=await SharedPreferences.getInstance();
    lastSearched=pref.getString("lastSearched");
    AppConstants.lastSearched=lastSearched??"";
  } catch (e) {
     debugPrint("Error encountered: ${e.toString()}");
     return "";
  }
}

saveLastSearched() async{
try {
  final pref=await SharedPreferences.getInstance();
   pref.setString("lastSearched", AppConstants.lastSearched); 
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