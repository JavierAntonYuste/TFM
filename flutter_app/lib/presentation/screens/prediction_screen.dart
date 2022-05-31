import 'dart:html';

import 'package:flutter/material.dart';
// import 'package:flutter_app/blocs/api_bloc.dart';

import 'package:flutter_app/models/HomeArguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/logic/cubit/counter_cubit.dart';
import 'package:flutter_app/constants/strings.dart' as s;

import 'package:flutter_app/widgets/predict_widgets.dart';

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
  //final ApiBloc _newsBloc = ApiBloc();

  // @override
  // void initState() {
  //   _newsBloc.add(GetPrediction(widget.username));
  //   super.initState();
  // }

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
        body: buildBody(context, widget));
    //buildPrediction(context, widget, _newsBloc));
  }
}
