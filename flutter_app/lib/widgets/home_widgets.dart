import 'package:flutter/material.dart';
import 'package:flutter_app/constants/strings.dart' as s;

Widget hometitle(BuildContext context) {
  return Container(
      child: Column(
    children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Text(
            s.homeTitle,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          )),
      Padding(
          padding: const EdgeInsets.all(8),
          child: Text(
            s.homeDescription,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
            ),
          )),
    ],
  ));
}

Widget wantmore(BuildContext context) {
  return Container(
      child: Column(
    children: <Widget>[
      Padding(
          padding: const EdgeInsets.only(top: 25, bottom: 25),
          child: Text(
            s.wantMoreTitle,
            style: TextStyle(
              color: Theme.of(context).secondaryHeaderColor,
              fontWeight: FontWeight.bold,
              fontSize: 40,
            ),
          )),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            s.WantMoreDescription,
            style: TextStyle(
              color: Theme.of(context).secondaryHeaderColor,
              fontSize: 20,
            ),
          )),
    ],
  ));
}
