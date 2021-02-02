import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final IconData icon;
  final Function onClick;
  final Function onValid;

  CustomTextField(
      {@required this.onClick,
      @required this.icon,
      @required this.hint,
      @required this.onValid});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextFormField(
        onSaved: onClick,
        validator: onValid,
      ),
    );
  }
}
