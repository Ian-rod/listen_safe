/*
Used OMDb API documentation available at https://www.omdbapi.com/
*/

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listensafe/AppConstants/app_constants.dart';

class ListenSafeFilms{
    static const String apiMainUrl = "http://www.omdbapi.com/";

    static Future<List<Map<String, dynamic>>> search(String searchString) async {
    final encodedQuery = Uri.encodeComponent(searchString.trim());
    final url = Uri.parse('$apiMainUrl?apikey=${AppConstants.filmApiKey}&s=$encodedQuery');
    final List<Map<String, dynamic>> searchResult = [];

    try {
      final response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        final jsonObj = jsonDecode(response.body);

        //Add a case to handle movie not found
        if(jsonObj['Search']!=null)
        {
           final results = (jsonObj['Search'] as List).cast<Map<String, dynamic>>(); //;
           searchResult.addAll(results);
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