import 'package:flutter/material.dart';
import 'package:flutter_app/constants/strings.dart' as s;
import 'package:flutter_app/models/HomeArguments.dart';

class hometitle extends StatelessWidget {
  const hometitle(BuildContext context, {Key key}) : super(key: key);

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
                s.homeTitle,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  fontFamily: 'LibreBaskerville',
                ),
              )),
        ),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 25),
            child: Text(
              s.homeDescription,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
              ),
            )),
        SizedBox(
          height: 25,
        ),
        homeform(context),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Text(
              s.homeDisclaimer,
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 15,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
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
  int dropDownValue = 1000;

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();

    return Form(
      key: _formKey,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your user name.';
                      } else if (value.contains('@')) {
                        return 'Please don\'t use the @ char.';
                      }
                      return null;
                    },
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
                Text(
                  'Nº of tweets to analyse',
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
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
                      items: <int>[1000, 2500, 5000].map((value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString()),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() => dropDownValue = value);
                      },
                      elevation: 16,
                    )),
              ],
            ),
            Text(
              '(The highest number, the more accurate the prediction is)',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(
              height: 35,
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
                  'Perform the analysis',
                  style:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                ),
              ),
              onPressed: () {
                print(dropDownValue);
                Navigator.pushNamed(context, '/prediction',
                    arguments: HomeArguments(
                        usernameController.text.toString(), dropDownValue));
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
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: Text(
                    s.wantMoreDescription,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 25,
                // ),
                // Row(
                //   children: [
                //     Image.asset('assets/images/logo-upm.png'),
                //   ],
                // ),
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                  child: Text(
                    s.wantMoreDescription2,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Theme.of(context).secondaryHeaderColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            )),
      ],
    ));
  }
}
