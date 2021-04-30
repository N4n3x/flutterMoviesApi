
import 'dart:convert';

class Movie {
  final int movieId;
  final String movieTitle;
  final String movieOverview;
  final DateTime movieReleaseDate;
  final String movieImageUrl;
  final double movieVote;

  Movie({this.movieId, this.movieTitle, this.movieOverview, this.movieReleaseDate, this.movieImageUrl, this.movieVote});


  static List<Movie> moviesFromApi(Map<String, dynamic> body){
    List<Movie> l =[];
    // Le body API nous retourne 4 noeud dont un qui est intéressant : results
    List<dynamic> results = body["results"];
    results.forEach((value) {
      Movie movie = Movie(
        movieId: value["id"],
        movieTitle: value["title"],
        movieOverview: value["overview"],
        movieImageUrl: value["poster_path"],
        movieReleaseDate: DateTime.parse(value["release_date"]),
        movieVote: double.tryParse(value["vote_average"].toString())
      );

      l.add(movie);
    });
    return l;
  }

}