import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class buildCompareBody extends StatefulWidget {
  const buildCompareBody(BuildContext context, {Key key}) : super(key: key);

  @override
  State<buildCompareBody> createState() => _buildBodyState();
}

class _buildBodyState extends State<buildCompareBody> {
  @override
  Widget build(BuildContext context) {
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
                      height: 32,
                      color: Colors.green,
                    ),
                    Container(
                      height: 64,
                      color: Colors.blue,
                    ),
                  ],
                ),
                TableRow(
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                  ),
                  children: <Widget>[
                    Container(
                      height: 64,
                      width: 128,
                      color: Colors.purple,
                    ),
                    Container(
                      height: 32,
                      color: Colors.yellow,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
