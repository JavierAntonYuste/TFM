import 'package:flutter/material.dart';
// import 'package:flutter_app/blocs/api_bloc.dart';
import 'package:flutter_app/models/apiModel.dart';

import 'package:flutter_app/logic/cubit/api_provider.dart';
import 'package:flutter_app/presentation/screens/prediction_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

FutureBuilder<ApiModel> buildBody(
    BuildContext context, PredictionScreen widget) {
  final ApiProvider httpService = ApiProvider();
  return FutureBuilder<ApiModel>(
    future: httpService.fetchPrediction(widget.username),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final ApiModel prediction = snapshot.data;
        print(snapshot);
        print(prediction);
        return _buildPosts(context, prediction);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

ListView _buildPosts(BuildContext context, ApiModel prediction) {
  return ListView.builder(
    itemCount: 1,
    padding: EdgeInsets.all(8),
    itemBuilder: (context, index) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(
            prediction.prediction.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(prediction.toString()),
        ),
      );
    },
  );
}
