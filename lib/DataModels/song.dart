class Song {
  String thumbnailImageUrl = "";
  String imageUrl = "";
  String artistName = "";
  String songName = "";
  bool? hasBadWord;
  String lyricsResult="";
  List<String> unsafeWordsFound = [];
  bool completeListFetched=false;

  Song(Map<String, dynamic> songItem) {
    thumbnailImageUrl = songItem["header_image_thumbnail_url"];
    imageUrl=songItem["header_image_url"];
    artistName = songItem["artist_names"];
    songName = songItem["title"];
    lyricsResult=songItem["lyrics"];
  }
}
