class Song {
  String imageUrl = "";
  String artistName = "";
  String songName = "";
  bool hasBadWord = true;
  List<String> unsafeWordsFound = [];

  Song(Map<String, dynamic> songItem) {
    imageUrl = songItem["header_image_thumbnail_url"];
    artistName = songItem["artist_names"];
    songName = songItem["title"];
    hasBadWord = songItem["hasBad"];
    unsafeWordsFound = songItem["listOfBadWords"];
  }
}
