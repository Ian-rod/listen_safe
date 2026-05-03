class Film {
  String title = "";
  String year="";
  String imdbID="";
  String type="";
  String plot="";

  String thumbnailImageUrl = "";

  Film(Map<String, dynamic> filmItem) {
    title = filmItem["title"];
    year=filmItem["Year"];
    imdbID=filmItem["imdbID"];
    type=filmItem["Type"];
    thumbnailImageUrl = filmItem["Poster"];
  }
}