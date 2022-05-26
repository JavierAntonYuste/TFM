import 'package:flutter/material.dart';
import 'package:flutter_app/constants/strings.dart' as s;

class hometitle extends StatelessWidget {
  const hometitle(BuildContext context, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 8),
            child: Text(
              s.homeTitle,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 40,
                fontFamily: 'LibreBaskerville',
              ),
            )),
        Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              s.homeDescription,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
              ),
            )),
        homeform(context),
      ],
    ));
  }
}

class homeform extends StatefulWidget {
  const homeform(BuildContext context, {Key key}) : super(key: key);

  @override
  State<homeform> createState() => _homeformState();
}

class _homeformState extends State<homeform> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    int dropDownValue = 1000;
    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text('Introduce your username'),
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
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                      labelText: 'Enter your username',
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Text('Nº of tweets to analyse'),
                Container(
                    width: 100,
                    padding: const EdgeInsets.all(8),
                    child: DropdownButtonFormField(
                      alignment: Alignment.center,
                      value: dropDownValue,
                      icon: const Icon(Icons.arrow_downward),
                      style: TextStyle(color: Theme.of(context).primaryColor),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      items: <int>[1000, 1500, 200]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (int newValue) {
                        setState(() {
                          dropDownValue = newValue;
                        });
                      },
                      elevation: 16,
                    )),
              ],
            ),
            MaterialButton(
              color: Colors.greenAccent,
              child: Text(
                'Go to Third Screen',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/third');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class wantmore extends StatelessWidget {
  const wantmore(BuildContext context, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Text(
                s.wantMoreTitle,
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontFamily: 'LibreBaskerville',
                ),
              ),
            )),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              child: Text(
                s.WantMoreDescription,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Theme.of(context).secondaryHeaderColor,
                  fontSize: 20,
                ),
              )),
        ),
      ],
    ));
  }
}