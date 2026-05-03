/*
Used OMDb API documentation available at https://www.omdbapi.com/
*/

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listensafe/AppConstants/app_constants.dart';
import 'package:listensafe/DataModels/film.dart';

class ListenSafeFilms{
    static const String apiMainUrl = "http://www.omdbapi.com/";

    static Future<List<Film>> search(String searchString) async {
    final encodedQuery = Uri.encodeComponent(searchString);
    final url = Uri.parse('$apiMainUrl?apikey=${AppConstants.filmApiKey}&s=$encodedQuery');
    final List<Film> searchResult = [];

    try {
      final response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        final jsonObj = jsonDecode(response.body);
        final results = jsonObj['response']['Search'] as List;

        /// Initialize bad words list
        //   wordsToFilter = await getExplicitWords();
        // }

        ///Iterate the result
        for (var hit in results) {
          Map<String, dynamic> filmResult = Map<String, dynamic>.from(hit);
          searchResult.add(Film(filmResult));
        }
      } else {
        debugPrint('Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Exception encountered: $e');
    }
    return searchResult;
  }
}