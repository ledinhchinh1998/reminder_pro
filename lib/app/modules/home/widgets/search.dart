import 'package:flutter/material.dart';
import 'package:note_app_pro/app/themes/style.dart';



class HeaderView extends StatelessWidget {
  final TextEditingController controller;
  final Function onCancel;
  final FocusNode focusNode;
  final bool isClear;
  final Function(String value) onChange;

  const HeaderView({Key key,this.controller, this.onCancel, this.focusNode, this.isClear, this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 9,
          child: TextFormField(
            focusNode: focusNode,
            controller: controller,
            onChanged: (value){
              onChange(value);
            },
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
                hintText: 'Search',
              suffixIcon: isClear ? Text('') : IconButton(
                onPressed: onCancel,
                icon: Icon(Icons.clear),
              ),
            ),
          ),
        ),
      ],
    );
  }
}