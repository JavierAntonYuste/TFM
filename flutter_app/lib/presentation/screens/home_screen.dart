import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/home_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/constants/enums.dart';
import 'package:flutter_app/logic/cubit/counter_cubit.dart';
import 'package:flutter_app/logic/cubit/internet_cubit.dart';

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
    return Scaffold(
        appBar: AppBar(
            backgroundColor: widget.color,
            title: Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                widget.title,
                style: TextStyle(
                    color: Theme.of(context).secondaryHeaderColor,
                    fontFamily: 'Libre Baskerville'),
              ),
            )),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
                delegate: SliverChildListDelegate([
              Container(
                color: Color(0xF9C3E3FD),
                //height: (MediaQuery.of(context).size.height) - 75,
                child: hometitle(context),
              ),
              Container(
                color: Theme.of(context).primaryColor,
                width: double.infinity,
                child: wantmore(context),
              )
            ]))
          ],
        ));
  }
}
