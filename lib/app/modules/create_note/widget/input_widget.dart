import 'package:flutter/material.dart';

class InputText extends StatelessWidget {

  final String title;
  final TextEditingController textEditingController;

  const InputText({Key key, this.title, this.textEditingController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: Colors.white,
      child: TextField(
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.sentences,
        controller: textEditingController,
        decoration: InputDecoration(
            labelText: title,
            hintText: title,
            border: OutlineInputBorder()
        ),
      ),
    );
  }
}