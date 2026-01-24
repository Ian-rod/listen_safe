import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:listensafe/AppConstants/reusable_widgets.dart';
import 'package:listensafe/requests/listen_safe.dart';
import 'package:listensafe/screens/initialScreens/initial_screen_explicitwords.dart';

class UserWordsManagement extends StatefulWidget {
  const UserWordsManagement({super.key});

  @override
  State<UserWordsManagement> createState() => _UserWordsManagementState();
}

class _UserWordsManagementState extends State<UserWordsManagement> {
  late ScaffoldMessengerState messenger;
  @override
  Widget build(BuildContext context) {
    messenger = ScaffoldMessenger.of(context);
    return SafeArea(child: Scaffold(
      body: ListenSafe.userAddedwordsToFilter.isEmpty?
      InitialScreenExplicitWordManagement():ListView.builder(
        itemCount:ListenSafe.userAddedwordsToFilter.length,
        itemBuilder:(context, index) {
        String badWord=ListenSafe.userAddedwordsToFilter[index];
        String language=ListenSafe.userAddedwordsToFilterEn.contains(badWord)?"En":"De";
        return Dismissible(
          key: ValueKey<int>(index),
          direction: DismissDirection.horizontal,   
          background: ColoredBox(color: AppConstants.error,
          child: Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(Icons.delete, color: Colors.white),
            ),
          ),                                    
          ),

          onDismissed: (direction)  async{
            if(direction==DismissDirection.endToStart)
            {
              //Deletion logic
              //check the language
              int badwordListIndex=0;
              if(language=="En")
              {
                badwordListIndex=ListenSafe.userAddedwordsToFilterEn.indexOf(badWord);
              }
              else{
                badwordListIndex=ListenSafe.userAddedwordsToFilterDe.indexOf(badWord);
              }
              ReusableWidgets.operationResultSnackbar(await ListenSafe.deleteBadWord(badwordListIndex,language), messenger);
            }
          },
          child: ListTile(
          leading: CircleAvatar(child: Text(language),),
            // show language 
            title:Text(badWord),
          ),
        );
      },),
    ));
  }
}