import 'package:flutter/material.dart';

class ButtonBorder extends StatelessWidget {
  final Function() onPressed;
  final Color color;
  final String title;

  const ButtonBorder({Key key, this.onPressed, this.color, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 48,
      child: FlatButton(
        color: color ?? null,
        onPressed: onPressed,
        child: Text(title),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}