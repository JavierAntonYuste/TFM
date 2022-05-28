import 'package:flutter/material.dart';
import 'package:flutter_app/models/HomeArguments.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app/logic/cubit/counter_cubit.dart';

import 'package:flutter_app/presentation/screens/home_screen.dart';
import 'package:flutter_app/presentation/screens/third_screen.dart';
import 'package:flutter_app/presentation/screens/prediction_screen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(),
        );
      case '/prediction':
        final args = settings.arguments as HomeArguments;
        return MaterialPageRoute(
          builder: (_) => PredictionScreen(
            title: "Prediction",
            username: args.username,
            n_tweets: args.n_tweets,
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => ThirdScreen(
            title: "Thirst Screen",
            color: Colors.greenAccent,
          ),
        );
      default:
        return null;
    }
  }
}
