import 'package:flutter/material.dart';
import 'package:flutter_app/logic/cubit/img_converter.dart';
import 'package:flutter_app/models/CompareArguments.dart';
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
        print(snapshot.data.meanwords);
        print(prediction.prediction.toString());
        return buildPrediction(context, prediction: prediction);
      } else {
        return Container(
          height: (MediaQuery.of(context).size.height),
          child: Padding(
            padding: EdgeInsets.all((MediaQuery.of(context).size.width) / 8),
            child: Center(
              child: LinearProgressIndicator(
                color: Colors.pink,
                semanticsLabel: 'Loading, please wait...',
              ),
            ),
          ),
        );
      }
    },
  );
}

class buildPrediction extends StatefulWidget {
  final ApiModel prediction;

  const buildPrediction(BuildContext context, {Key key, this.prediction})
      : super(key: key);

  @override
  State<buildPrediction> createState() => buildPredictionState();
}

class buildPredictionState extends State<buildPrediction> {
  @override
  Widget build(BuildContext context) {
    String recommendation;
    if (widget.prediction.prediction.toString() == '1') {
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
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Container(
              width: double.infinity,
              child: convertIMG(widget.prediction.wordcloud.toString())),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          child: comparingform(prediction: widget.prediction),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.all(15),
          child: Container(
              width: double.infinity,
              child: convertIMG(widget.prediction.graph.toString())),
        ),
      ],
    ));
  }
}

class comparingform extends StatefulWidget {
  final ApiModel prediction;

  const comparingform({Key key, this.prediction}) : super(key: key);

  @override
  State<comparingform> createState() => _comparingformState();
}

class _comparingformState extends State<comparingform> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();

    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text('Do you want to compare your profile with another one?',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 20,
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    '@',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  width: 300,
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    controller: usernameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Enter the other username',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              hoverColor: Colors.pink,
              hoverElevation: 15,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Make the comparison',
                  style:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/compare',
                    arguments: CompareArguments(
                        usernameController.text.toString(), widget.prediction));
              },
            ),
          ],
        ),
      ),
    );
  }
}
