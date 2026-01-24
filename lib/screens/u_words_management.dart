import 'package:flutter/material.dart';
import 'package:listensafe/requests/listen_safe.dart';
import 'package:listensafe/screens/initialScreens/initial_screen_explicitwords.dart';

class UserWordsManagement extends StatefulWidget {
  const UserWordsManagement({super.key});

  @override
  State<UserWordsManagement> createState() => _UserWordsManagementState();
}

class _UserWordsManagementState extends State<UserWordsManagement> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: true?
      InitialScreenExplicitWordManagement():ListView.builder(
        itemCount:ListenSafe.userAddedwordsToFilter.length,
        itemBuilder:(context, index) {
        return ListTile(
          // show language 
          title:Text(ListenSafe.userAddedwordsToFilter[index]),
        );
      },),
    ));
  }
}