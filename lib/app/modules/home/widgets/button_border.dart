import 'package:flutter/material.dart';

class ButtonBorder extends StatelessWidget {
  final Function() onPressed;

  const ButtonBorder({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      child: FlatButton(
        onPressed: onPressed,
        child: Text('Save'),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.white
          ),
          borderRadius: BorderRadius.circular(15)
        ),
      ),
    );
  }
}