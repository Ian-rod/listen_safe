import 'dart:convert';
import 'dart:io';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:flutter/services.dart' show rootBundle;

class ListenSafe {
  static const String apiMainUrl = "https://api.genius.com/";
  static List<String> wordsToFilter = [];

  /// Takes in a search string and returns a list of JSON objects (as Map (String, dynamic))
  static Future<List<Map<String, dynamic>>> search(String searchString) async {
    final encodedQuery = Uri.encodeComponent(searchString);
    final url = Uri.parse('$apiMainUrl/search?q=$encodedQuery');
    final List<Map<String, dynamic>> searchResult = [];

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer ${AppConstants.accessToken}'},
      );

      if (response.statusCode == 200) {
        final jsonObj = jsonDecode(response.body);
        final hits = jsonObj['response']['hits'] as List;

        /// Initialize bad words list
        if (wordsToFilter.isEmpty) {
          wordsToFilter = await getExplicitWords();
        }

        ///Iterate the result
        for (var hit in hits) {
          final result = hit['result'];
          Map<String, dynamic> songResult = Map<String, dynamic>.from(result);

          ///Add hasBad and List of bad words
          String songLyricsUrl = result["url"];
          String lyricsResult = await getLyrics(songLyricsUrl);

          //add lyrics result to map for later operation and use
          songResult["lyrics"]=lyricsResult;

          ///Add the badwords Result
          searchResult.add(songResult);
        }
      } else {
        debugPrint('Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Exception encountered: $e');
    }
    return searchResult;
  }

  /// Retrieve lyrics from the given URL
  static Future<String> getLyrics(String lyricsUrl) async {
    try {
      final response = await http.get(
        Uri.parse(lyricsUrl),
        headers: {'Authorization': 'Bearer ${AppConstants.accessToken}'},
      );

      if (response.statusCode == 200) {
        return response.body.toLowerCase();
      } else {
        debugPrint('Error fetching lyrics: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Exception encountered: $e');
    }
    return '';
  }

  /// Retrieve explicit words from file
  static Future<List<String>> getExplicitWords() async {
    List<String> result = [];

    try {
      final lines = await rootBundle.loadString(AppConstants.badWordsSource);

      ///Convert to a list of string
      result = lines.split(RegExp(r'\r?\n'));
      result = result.where((line) => line.trim().isNotEmpty).toList();
    } catch (e) {
      debugPrint('Error reading bad words: $e');
    }

    return result;
  }

  /// Add a new bad word to the list and file
  static Future<void> addNewBadWord(String badWord) async {
    if (badWord.trim().isEmpty) return;

    wordsToFilter.add(badWord.toLowerCase());

    try {
      final file = File(AppConstants.badWordsSource);
      await file.writeAsString('$badWord\n', mode: FileMode.append);
    } catch (e) {
      debugPrint('Error appending to file: $e');
    }
  }
}

  ///List of bad words with isolate
  void badWordListIsolate(Map<String, dynamic> args) 
  {
    String lyricsResult =args['lyricsResult'];
    final SendPort sendPort = args['sendPort'];
    final List<String> wordsToFilter=args['wordsToFilter'];
    final List<String> badWordsFound = [];

    for (final badWord in wordsToFilter) {
      if (lyricsResult.contains(" $badWord ")) {
        badWordsFound.add(badWord);
      }
    }
     sendPort.send(badWordsFound);
  }
