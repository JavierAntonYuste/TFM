import 'package:flutter/material.dart';
import 'package:flutter_app/logic/cubit/img_converter.dart';
import 'package:flutter_app/models/apiModel.dart';

import 'package:flutter_app/logic/cubit/api_provider.dart';
import 'package:flutter_app/presentation/screens/prediction_screen.dart';

import 'package:flutter_app/constants/strings.dart' as s;

FutureBuilder<ApiModel> buildBody(
    BuildContext context, PredictionScreen widget) {
  final ApiProvider httpService = ApiProvider();
  return FutureBuilder<ApiModel>(
    future: httpService.fetchPrediction(widget.username),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final ApiModel prediction = snapshot.data;
        print(snapshot);
        print(prediction.prediction.toString());
        return _buildPrediction(context, prediction: prediction);
      } else {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  );
}

class _buildPrediction extends StatefulWidget {
  final ApiModel prediction;

  const _buildPrediction(BuildContext context, {Key key, this.prediction})
      : super(key: key);

  @override
  State<_buildPrediction> createState() => _buildPredictionState();
}

class _buildPredictionState extends State<_buildPrediction> {
  @override
  Widget build(BuildContext context) {
    String recommendation;
    if (widget.prediction.prediction.toString() == '0') {
      recommendation = s.positiveRecommendation;
    } else {
      recommendation = s.negativeRecommendation;
    }
    return Container(
        child: Column(
      children: <Widget>[
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
                child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(
                    'Results of your profile @' + widget.prediction.username,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      fontFamily: 'LibreBaskerville',
                    ),
                  )),
            )),
            Expanded(
              child: Align(
                //alignment: Alignment.topRight,
                child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        widget.prediction.pic.toString(),
                      ),
                      radius: 130,
                    )),
              ),
            )
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            child: Text(
              recommendation,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
              ),
            )),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              s.wordcloudIntroduction,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Container(
            width: double.infinity,
            child: convertIMG(widget.prediction.wordcloud.toString())),
      ],
    ));
  }
}
