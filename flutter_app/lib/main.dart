import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_app/logic/cubit/counter_cubit.dart';
import 'package:flutter_app/presentation/router/app_router.dart';

import 'logic/cubit/internet_cubit.dart';

void main() {
  runApp(MyApp(
    appRouter: AppRouter(),
    connectivity: Connectivity(),
  ));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;
  final Connectivity connectivity;

  const MyApp({
    Key key,
    @required this.appRouter,
    @required this.connectivity,
  }) : super(key: key);

  @override
  Widget build(BuildContext myAppContext) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InternetCubit>(
          create: (internetCubitContext) =>
              InternetCubit(connectivity: connectivity),
        ),
        BlocProvider<CounterCubit>(
          create: (counterCubitContext) => CounterCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'PredEating',
        theme: ThemeData(
          primaryColor: Color.fromARGB(255, 23, 55, 115),
          secondaryHeaderColor: Color.fromARGB(255, 255, 199, 238),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Montserrat',
        ),
        onGenerateRoute: appRouter.onGenerateRoute,
      ),
    );
  }
}
