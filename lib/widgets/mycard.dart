import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  MyCard({this.title, this.icon});

  final Widget title;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(bottom: 20.0),
        child: Card(
            child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0),
          child: Row(children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              child: this.icon,
            ),
            SizedBox(
              width: 20.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 0.5, horizontal: 1.0),
              margin: EdgeInsets.all(2.0),
              child: this.title,
            )
          ]),
        )));
  }
}
