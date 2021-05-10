import 'package:flutter/material.dart';

class Chargement extends StatelessWidget {
  const Chargement({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Chargement en cours ...", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),);
  }

}
