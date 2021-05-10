import 'package:flutter/material.dart';
import 'package:flutter_api/models/api_movie.dart';
import 'package:flutter_api/models/movie.dart';
import 'package:flutter_api/widgets/chargement.dart';
import 'package:flutter_api/widgets/erreur.dart';

import 'models/movie.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Movie> movies = [];
  StatusApi _statusApi;

  @override
  void initState() {
    getPopularMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: getPopularMovies)
        ],
      ),
      body: choixDuBody(),
    );
  }

  Widget choixDuBody() {
    if (_statusApi == StatusApi.chargement) {
      return Chargement();
    } else if (_statusApi == StatusApi.error) {
      return Erreur();
    } else {
      //Todo : Faire un ListView Builder puis un Grid View pour le paysage
      return Center(child: OrientationBuilder(builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? scrollListMovies()
            : gridViewMovies();
      }));
    }
  }

  Widget scrollListMovies() {
    return OrientationBuilder(builder: (context, orientation) {
      return ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: Image.network(
                      "https://image.tmdb.org/t/p/w500${movies[index].movieImageUrl}"),
                  title: Text(movies[index].movieTitle),
                  subtitle:
                      Text(movies[index].movieReleaseDate.toIso8601String()),
                )
              ],
            ),
          );
        },
      );
    });
  }

  Widget gridViewMovies() {
    return GridView.builder(
      itemCount: movies.length,
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        Movie movie = movies[index];
        return GridTile(
          header: Text(
            movie.movieTitle,
            textAlign: TextAlign.center,
          ),
          child: Padding(
            child: Image.network(
                "https://image.tmdb.org/t/p/w500${movie.movieImageUrl}"),
            padding: EdgeInsets.all(25),
          ),
          footer: Text(movie.movieReleaseDate.toString()),
        );
      },
    );
  }

  Future<void> getPopularMovies() async {
    setState(() {
      _statusApi = StatusApi.chargement;
    });
    ApiMovie api = ApiMovie();
    Map<String, dynamic> mapMovie = await api.getPopular();
    if (mapMovie["code"] == 0) {
      // Je peux concevoir ma liste de Movie
      setState(() {
        movies = Movie.moviesFromApi(mapMovie["body"]);
        _statusApi = StatusApi.ok;
      });
    } else {
      setState(() {
        _statusApi = _statusApi = StatusApi.error;
      });
    }
  }
}

enum StatusApi { chargement, error, ok }
