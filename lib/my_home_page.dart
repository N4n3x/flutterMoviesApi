
import 'package:flutter/material.dart';
import 'package:flutter_api/models/api_movie.dart';
import 'package:flutter_api/models/movie.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> movies = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Interroger API"),
          onPressed: getPopularMovies,
        ),
      ),
    );
  }

  Future<void> getPopularMovies() async {
    ApiMovie api = ApiMovie();
    Map<String, dynamic> mapMovie = await api.getPopular();
    if(mapMovie["code"] == 0){
      // Je peux concevoir ma liste de Movie
      movies = Movie.moviesFromApi(mapMovie["body"]);
      movies.forEach((Movie movie) {
        print(movie.movieTitle);
      });

    }else{
      //Todo afficher erreur
    }

  }

}