import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/constants/enums.dart';
import 'package:flutter_app/logic/cubit/counter_cubit.dart';
import 'package:flutter_app/logic/cubit/internet_cubit.dart';

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
  Widget build(BuildContext homeScreenContext) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Center(child: Text(widget.title)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Center(child: titlewidget)],
        ),
      ),
    );
  }
}
