import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';

class ItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        CircularCheckBox(
            value: true,
            onChanged: null
        ),
        Column(
          children: [
            Text(
              "Title",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Time",
              style: TextStyle(
                color: Colors.red,
                fontSize: 14
              ),
            )
          ],
        )
      ],
    );
  }
}
