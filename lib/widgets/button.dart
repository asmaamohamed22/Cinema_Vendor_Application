import 'package:cinema_vendor_app/constant.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function onPressed;
  final String name;
  MyButton({this.onPressed, this.name});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        padding: EdgeInsets.symmetric(horizontal: 90.0, vertical: 16.0),
        onPressed: onPressed,
        child: Text(
          name,
          style: TextStyle(color: Colors.white, fontSize: 20.0),
        ),
        color: kBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
      ),
    );
  }
}
