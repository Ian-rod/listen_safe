import 'package:flutter/material.dart';
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:listensafe/AppConstants/reusable_widgets.dart';
import 'package:listensafe/l10n/app_localizations.dart';
import 'package:listensafe/requests/listen_safe.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  ///CheckText before request search
  makeRequest() async {
    if (controller.text.isEmpty) {
      return;
    } else {
      //Set to is searching state
      setState(() {
        isPageRefreshing = true;
      });
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
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localizations.isItSafe), centerTitle: true),
      body: Column(
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
                  onPressed: () => makeRequest(),
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
              onSubmitted: (value) => makeRequest(),
            ),
          ),
          //Main application Body
          Expanded(
            child: isPageRefreshing
                ? ReusableWidgets.loadingAnimation(110)
                : ListView.builder(
                    itemCount: listOfItems.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> songItem = listOfItems[index];
                      String imageUrl = songItem["header_image_thumbnail_url"];
                      String artistName = songItem["artist_names"];
                      String songName = songItem["title"];
                      return ListTile(
                        leading: Image(image: NetworkImage(imageUrl)),
                        title: Text(songName),
                        subtitle: Text(artistName),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
