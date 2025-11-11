import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:listensafe/app_constants.dart';

class ListenSafe {
  static const String apiMainUrl = "https://api.genius.com/";
  static List<String> wordsToFilter = [];

  /// Initialize bad words list
  static Future<void> init() async {
    wordsToFilter = await getExplicitWords();
  }

  /// Takes in a search string and returns a list of JSON objects (as Map<String, dynamic>)
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

        for (var hit in hits) {
          final result = hit['result'];
          searchResult.add(Map<String, dynamic>.from(result));
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
    final List<String> result = [];

    try {
      final file = File(AppConstants.badWordsSource);

      if (await file.exists()) {
        final lines = await file.readAsLines();
        result.addAll(lines.map((e) => e.trim().toLowerCase()));
      } else {
        debugPrint('Bad words file not found: ${AppConstants.badWordsSource}');
      }
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

  /// Return a map of whether the lyrics contain a bad word and the list of them
  static Map<bool, List<String>> checkIfHasBadWord(String lyricsBody) {
    bool found = false;
    final List<String> badWordsFound = [];

    for (final badWord in wordsToFilter) {
      if (lyricsBody.contains(badWord)) {
        found = true;
        badWordsFound.add(badWord);
      }
    }

    return {found: badWordsFound};
  }
}
