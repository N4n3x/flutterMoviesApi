
import 'package:flutter/material.dart';
import 'package:flutter_api/models/api_movie.dart';
import 'package:flutter_api/models/movie.dart';
import 'package:flutter_api/widgets/chargement.dart';
import 'package:flutter_api/widgets/erreur.dart';

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
          IconButton(
              icon: Icon(Icons.refresh),
              onPressed: getPopularMovies
          )
        ],
      ),
      body: choixDuBody(),
    );
  }


  Widget choixDuBody(){
    if(_statusApi == StatusApi.chargement){
      return Chargement();
    }else if(_statusApi == StatusApi.error){
      return Erreur();
    }else{
      //Todo : Faire un ListView Builder puis un Grid View pour le paysage
      return Center();
    }
  }


  Future<void> getPopularMovies() async {
    setState(() {
      _statusApi = StatusApi.chargement;
    });
    ApiMovie api = ApiMovie();
    Map<String, dynamic> mapMovie = await api.getPopular();
    if(mapMovie["code"] == 0){
      // Je peux concevoir ma liste de Movie
      setState(() {
        movies = Movie.moviesFromApi(mapMovie["body"]);
        _statusApi = StatusApi.ok;
      });
    }else{
      setState(() {
        _statusApi = _statusApi = StatusApi.error;
      });
    }

  }

}

enum StatusApi {
  chargement,
  error,
  ok
}