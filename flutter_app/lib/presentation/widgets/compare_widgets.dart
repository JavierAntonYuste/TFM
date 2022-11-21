import 'package:flutter/material.dart';
import 'package:flutter_app/logic/cubit/api_provider.dart';
import 'package:flutter_app/models/apiModel.dart';
import 'package:flutter_app/presentation/screens/compare_screen.dart';

import 'package:flutter_app/constants/strings.dart' as s;

FutureBuilder<ApiModel> buildBodyCompare(
    BuildContext context, CompareScreen widget, ApiModel previousPrediction) {
  final ApiProvider httpService = ApiProvider();
  return FutureBuilder<ApiModel>(
    future: httpService.fetchPrediction(widget.username),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        final ApiModel prediction = snapshot.data;
        print(snapshot.data.meanwords);
        print(prediction.prediction.toString());
        return buildTable(context,
            prediction: prediction, previousPrediction: previousPrediction);
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

class buildTable extends StatefulWidget {
  final ApiModel prediction;
  final ApiModel previousPrediction;

  const buildTable(BuildContext context,
      {Key key, this.prediction, this.previousPrediction})
      : super(key: key);

  @override
  State<buildTable> createState() => _buildTableState();
}

class _buildTableState extends State<buildTable> {
  @override
  Widget build(BuildContext context) {
    String previousPredictionString;
    String predictionString;
    if (widget.previousPrediction.prediction.toString() == '1') {
      previousPredictionString = s.positivePrediction;
    } else {
      previousPredictionString = s.negativePrediction;
    }

    if (widget.prediction.prediction.toString() == '1') {
      predictionString = s.positivePrediction;
    } else {
      predictionString = s.negativePrediction;
    }

    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: Table(
              border: TableBorder.all(),
              // columnWidths: const <int, TableColumnWidth>{
              //   0: IntrinsicColumnWidth(),
              //   1: FlexColumnWidth(),
              //   2: FixedColumnWidth(64),
              // },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    Container(
                      child: Text('Username'),
                    ),
                    Container(
                      child:
                          Text(widget.previousPrediction.username.toString()),
                    ),
                    Container(
                      child: Text(widget.prediction.username.toString()),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Container(
                      child: Text('Profile picture'),
                    ),
                    Container(
                      child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.previousPrediction.pic.toString(),
                            ),
                            radius: 130,
                          )),
                    ),
                    Container(
                      child: Padding(
                          padding: const EdgeInsets.all(25),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                              widget.prediction.pic.toString(),
                            ),
                            radius: 130,
                          )),
                    ),
                  ],
                ),
                TableRow(
                  children: <Widget>[
                    Container(
                      child: Text('Prediction'),
                    ),
                    Container(
                      child: Text(previousPredictionString),
                    ),
                    Container(
                      child: Text(predictionString),
                    ),
                  ],
                ),
                TableRow(children: <Widget>[
                  Container(
                    child: Text('Mean words per tweet'),
                  ),
                  Container(
                    child: Text(widget.previousPrediction.meanwords.toString()),
                  ),
                  Container(
                    child: Text(widget.prediction.meanwords.toString()),
                  ),
                ]),
                TableRow(children: <Widget>[
                  Container(
                    child: Text('Most mentioned users'),
                  ),
                  Container(
                    child: Text(
                        widget.previousPrediction.mentioned_users.toString()),
                  ),
                  Container(
                    child: Text(widget.prediction.mentioned_users.toString()),
                  ),
                ]),
              ],
            ),
          )
        ],
      ),
    );
  }
}
