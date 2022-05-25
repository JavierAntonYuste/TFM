import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/constants/enums.dart';
import 'package:flutter_app/logic/cubit/counter_cubit.dart';
import 'package:flutter_app/logic/cubit/internet_cubit.dart';

import 'dart:math' as math;

import 'package:flutter_app/l10n/l10n.dart';

Widget titlewidget = Container(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget>[
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Holaa",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          )),
      Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Holaa",
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          )),
    ],
  ),
);

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
        appBar: AppBar(
            backgroundColor: widget.color,
            title: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(widget.title),
            )),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                color: Color(0xF9C3E3FD),
                height: (MediaQuery.of(context).size.height) - 100,
                child: titlewidget,
              ),
              Container(
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          l10n.counterAppBarTitle,
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Holaa",
                          style: TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        )),
                  ],
                ),
              )
            ]))
          ],
        ));
  }
}
