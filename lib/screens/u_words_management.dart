import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:listensafe/AppConstants/reusable_widgets.dart';
import 'package:listensafe/l10n/app_localizations.dart';
import 'package:listensafe/requests/listen_safe.dart';
import 'package:listensafe/screens/initialScreens/initial_screen_explicitwords.dart';

class UserWordsManagement extends StatefulWidget {
  const UserWordsManagement({super.key});

  @override
  State<UserWordsManagement> createState() => _UserWordsManagementState();
}

class _UserWordsManagementState extends State<UserWordsManagement> {
  late ScaffoldMessengerState messenger;
   late AppLocalizations localizations; 
   
  @override
  Widget build(BuildContext context) {
    messenger = ScaffoldMessenger.of(context);
    localizations = AppLocalizations.of(context)!;
    return SafeArea(child: Scaffold(
      appBar: AppBar(title: Text(localizations.manageWords)),
      body: ListenSafe.userAddedwordsToFilter.isEmpty?
      InitialScreenExplicitWordManagement():Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
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
        
            confirmDismiss: (direction) async{
              if(direction==DismissDirection.endToStart)
              {
                //Deconstletion logic maybe after a confirm dialog box 
                final bool result = await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title:  Text(localizations.youSure),
                      content: Text(localizations.confirmDeleteMsg),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text(localizations.cancel),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text(localizations.delete),
                        ),
                      ],
                    ),
                  );

                if(result)
                {
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
                return result;
              }
            },
            child: Card(
              elevation: 10,
              margin: EdgeInsets.all(6),
              child: ListTile(
              leading: CircleAvatar(child: Text(language),),
                // show language 
                title:Text(badWord),
              ),
            ),
          );
        },),
      ),
    ));
  }
}