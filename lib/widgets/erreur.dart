import 'package:flutter/material.dart';

class Erreur extends StatelessWidget {
  const Erreur({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Erreur lors de l'appel API", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: Colors.red),);
  }

}
