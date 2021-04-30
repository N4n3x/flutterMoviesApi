import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiMovie{
  final String Url = "https://api.themoviedb.org/3";
  final String Key = "f5a8a486fb069fcb10396a7a3e49ceb4";
  final String Lang = "fr-FR";

  // Méthode qui interroge les films populaire : /movie/popular
  // Cette méthode retourne un body JSON
  // PLusieurs cas de figure :
  //  - Le Body est ok
  //  - Le Body est vide
  //  - Le body n'a rien à voir (message d'erreur)

  // Notre méthode doit retourner 2 choses :
  //  - Le code HTTP ou code interne à vous
  //  - Le contenu (message erreur, body json etc.)
  // ça s'appelle une Map

  Future<Map<String, dynamic>> getPopular() async{
    http.Response response;
    String completeUrl = Url + "/movie/popular?api_key=" + Key + "&language=" + Lang;
    print(completeUrl);

    response = await http.get(Uri.parse(completeUrl));

    Map<String, dynamic> map = {
      "code":1,
      "body":""
    };

    if(response.statusCode==200){
      //todo tester les # cas de figure retournée par l'API
      map["code"] = 0;
      map["body"]= jsonDecode(response.body);
    }else{
      map["code"] = 1;
      map["body"]="Error http etc.";
    }

    return map;
  }




}