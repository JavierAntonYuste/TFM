import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_app/constants/strings.dart' as s;

import 'package:flutter_app/presentation/widgets/predict_widgets.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({Key key, this.title, this.username, this.n_tweets})
      : super(key: key);
  final String title;
  final String username;
  final int n_tweets;

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                s.appBarTitle,
                style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontFamily: 'Libre Baskerville'),
              ),
            )),
        body: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                color: Color(0xF9C3E3FD),
                child: buildBody(context, widget),
              ),
            ]))
          ],
        ));
  }
}
