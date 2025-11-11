import 'package:flutter/material.dart';
import 'package:listensafe/app_constants.dart';
import 'package:listensafe/l10n/app_localizations.dart';
import 'package:listensafe/requests/listen_safe.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    AppLocalizations localizations = AppLocalizations.of(context)!;
    TextEditingController controller = TextEditingController();
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
                suffix: Icon(Icons.search, color: AppConstants.primary),
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
              onChanged: (value) async {
                var output = await ListenSafe.search(value);
                debugPrint(output.toString());
              },
            ),
          ),
        ],
      ),
    );
  }
}
