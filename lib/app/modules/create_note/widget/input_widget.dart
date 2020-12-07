import 'package:flutter/material.dart';

class InputText extends StatelessWidget {

  final String title;
  final TextEditingController textEditingController;

  const InputText({Key key, this.title, this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: TextField(
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
        controller: textEditingController,
        decoration: InputDecoration(
            labelText: title,
            hintText: title,
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 10.0),
            border: OutlineInputBorder()
        ),
      ),
    );
  }
}