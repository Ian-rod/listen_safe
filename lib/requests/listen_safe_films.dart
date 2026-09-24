/*
Used OMDb API documentation available at https://www.omdbapi.com/
*/

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:listensafe/AppConstants/app_constants.dart';

class ListenSafeFilms{
    static const String apiMainUrl = "http://www.omdbapi.com/";

  //Search for a film
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

  //Request plot using imdb ID
  static Future<String> queryPlot(String imdbID,{String plotLength="short"}) async
  {
    final url = Uri.parse('$apiMainUrl?apikey=${AppConstants.filmApiKey}&i=$imdbID&plot=$plotLength');
    String retStr="Encounterd an error";
    try {
      final response = await http.get(
        url,
      );

      if (response.statusCode == 200) {
        final jsonObj = jsonDecode(response.body);
        //Just returning the plot here but so many other values can be obtained
        retStr=jsonObj['Plot'];
        //Sample values that can be obtained
        /*
            "Title": "The Batman",
            "Year": "2022",
            "Rated": "PG-13",
            "Released": "04 Mar 2022",
            "Runtime": "176 min",
            "Genre": "Action, Crime, Drama",
            "Director": "Matt Reeves",
            "Writer": "Matt Reeves, Peter Craig, Bob Kane",
            "Actors": "Robert Pattinson, Zoë Kravitz, Jeffrey Wright",
            "Plot": "When a sadistic serial killer begins murdering key political figures in Gotham, the Batman is forced to investigate the city's hidden corruption and question his family's involvement.",
            "Language": "English, Spanish, Latin, Italian",
            "Country": "United States",
            "Awards": "Nominated for 3 Oscars. 40 wins & 176 nominations total",
            "Poster": "https://m.media-amazon.com/images/M/MV5BMmU5NGJlMzAtMGNmOC00YjJjLTgyMzUtNjAyYmE4Njg5YWMyXkEyXkFqcGc@._V1_QL75_UX380_CR0,0,380,562_.jpg",
            "Ratings": [
                {
                    "Source": "Internet Movie Database",
                    "Value": "7.8/10"
                },
                {
                    "Source": "Rotten Tomatoes",
                    "Value": "85%"
                },
                {
                    "Source": "Metacritic",
                    "Value": "72/100"
                }
            ],
            "Metascore": "72",
            "imdbRating": "7.8",
            "imdbVotes": "923,764",
            "imdbID": "tt1877830",
            "Type": "movie",
            "DVD": "N/A",
            "BoxOffice": "$369,801,546",
            "Production": "N/A",
            "Website": "N/A",
            "Response": "True"
        
        */ 
      } else {
        debugPrint('Error: ${response.statusCode}');
        retStr='Error: ${response.statusCode}';
      }
    } catch (e) {
      debugPrint('Exception encountered: $e');
      retStr='Exception encountered: $e';
    }
    return retStr;
  }
}