import 'package:flutter/material.dart';
// import 'package:flutter_app/blocs/api_bloc.dart';
import 'package:flutter_app/models/apiModel.dart';

import 'package:flutter_app/logic/cubit/api_provider.dart';
import 'package:flutter_app/presentation/screens/prediction_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

FutureBuilder<List<ApiModel>> buildBody(
    BuildContext context, PredictionScreen widget) {
  final ApiProvider httpService = ApiProvider();
  return FutureBuilder<List<ApiModel>>(
    future: httpService.fetchPrediction(widget.username),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final List<ApiModel> prediction = snapshot.data;
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

ListView _buildPosts(BuildContext context, List<ApiModel> prediction) {
  return ListView.builder(
    itemCount: 1,
    padding: EdgeInsets.all(8),
    itemBuilder: (context, index) {
      return Card(
        elevation: 4,
        child: ListTile(
          title: Text(
            prediction.toString(),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(prediction.toString()),
        ),
      );
    },
  );
}

// Widget buildPrediction(
//     BuildContext context, PredictionScreen widget, ApiBloc newsBloc) {
//   return Container(
//     margin: EdgeInsets.all(8.0),
//     child: BlocProvider(
//       create: (_) => newsBloc,
//       child: BlocListener<ApiBloc, ApiState>(
//         listener: (context, state) {
//           if (state is ApiError) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text(state.message),
//               ),
//             );
//           }
//         },
//         child: BlocBuilder<ApiBloc, ApiState>(
//           builder: (context, state) {
//             if (state is ApiInitial) {
//               return _buildLoading(widget.username);
//             } else if (state is ApiLoading) {
//               return _buildLoading(widget.username);
//             } else if (state is ApiLoaded) {
//               return _buildCard(context, state.apiModel);
//             } else if (state is ApiError) {
//               return Container();
//             } else {
//               return Container();
//             }
//           },
//         ),
//       ),
//     ),
//   );
// }

// Widget _buildCard(BuildContext context, ApiModel model) {
//   return Text('hola');
//   // ListView.builder(
//   //   itemCount: model.countries!.length,
//   //   itemBuilder: (context, index) {
//   //     return Container(
//   //       margin: EdgeInsets.all(8.0),
//   //       child: Card(
//   //         child: Container(
//   //           margin: EdgeInsets.all(8.0),
//   //           child: Column(
//   //             children: <Widget>[
//   //               Text("Country: ${model.countries![index].country}"),
//   //               Text(
//   //                   "Total Confirmed: ${model.countries![index].totalConfirmed}"),
//   //               Text("Total Deaths: ${model.countries![index].totalDeaths}"),
//   //               Text(
//   //                   "Total Recovered: ${model.countries![index].totalRecovered}"),
//   //             ],
//   //           ),
//   //         ),
//   //       ),
//   //     );
//   //   },
//   // );
// }

// Widget _buildLoading(username) => Center(child: CircularProgressIndicator());
