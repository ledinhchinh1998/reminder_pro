import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class ItemListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircularCheckBox(
            value: true,
            onChanged: (value) {

            }
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
            SizedBox(height: 10),
            Text(
              "Time",
              style: TextStyle(
                color: Colors.red,
                fontSize: 14
              ),
            ),
            SizedBox(height: 10),
          ],
        )
      ],
    );
  }
}
