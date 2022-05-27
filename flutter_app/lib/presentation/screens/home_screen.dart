import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/home_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/constants/enums.dart';
import 'package:flutter_app/logic/cubit/counter_cubit.dart';
import 'package:flutter_app/logic/cubit/internet_cubit.dart';

import 'package:flutter_app/constants/strings.dart' as s;

import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 400.0,
          floating: false,
          pinned: true,
          snap: false,
          elevation: 50,
          backgroundColor: Colors.pink,
          // leading: IconButton(
          //   icon: Icon(Icons.filter_1),
          //   onPressed: () {},
          // ),
          flexibleSpace: _MyAppSpace(),
        ),
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
            //height: (MediaQuery.of(context).size.height),
            child: wantmore(context),
          )
        ]))
      ],
    ));
  }
}

class _MyAppSpace extends StatelessWidget {
  const _MyAppSpace({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final settings = context
            .dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final deltaExtent = settings.maxExtent - settings.minExtent;
        final t =
            (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
                .clamp(0.0, 1.0) as double;
        final fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
        const fadeEnd = 1.0;
        final opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);

        return Opacity(
          opacity: opacity,
          child: Column(
            children: [
              Flexible(
                child: Container(
                  width: double.infinity,
                  child: Image.network(
                    'https://images.pexels.com/photos/1250452/pexels-photo-1250452.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940&blur=25',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  s.appBarTitle,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
