import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'package:flutter_app/constants/strings.dart' as s;
import 'package:flutter_app/models/apiModel.dart';
import 'package:flutter_app/presentation/widgets/compare_widgets.dart';

class CompareScreen extends StatefulWidget {
  const CompareScreen(
      {Key key, this.title, this.username, this.previousPrediction})
      : super(key: key);
  final String title;
  final String username;
  final ApiModel previousPrediction;

  @override
  State<CompareScreen> createState() => _CompareScreenState();
}

class _CompareScreenState extends State<CompareScreen> {
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
                height: MediaQuery.of(context).size.height,
                color: Color(0xF9C3E3FD),
                child: buildCompareBody(context),
              ),
            ]))
          ],
        ));
  }
}
