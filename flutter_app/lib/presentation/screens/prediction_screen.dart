import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/logic/cubit/counter_cubit.dart';
import 'package:flutter_app/constants/strings.dart' as s;

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({Key key, this.title}) : super(key: key);
  final String title;

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
      body: Text('body'),
    );
  }
}
