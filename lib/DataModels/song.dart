class Song {
  String thumbnailImageUrl = "";
  String imageUrl = "";
  String artistName = "";
  String songName = "";
  bool hasBadWord = false;
  String lyricsResult="";
  List<String> unsafeWordsFound = [];

  Song(Map<String, dynamic> songItem) {
    thumbnailImageUrl = songItem["header_image_thumbnail_url"];
    imageUrl=songItem["header_image_url"];
    artistName = songItem["artist_names"];
    songName = songItem["title"];
    hasBadWord = songItem["hasBad"];
    unsafeWordsFound = songItem["listOfBadWords"];
    lyricsResult=songItem["lyrics"];
  }
}
