

import 'package:flutter/material.dart';

import 'select_item.dart';


class Section extends StatelessWidget {

  final Function onToday;
  final Function onSchedule;
  final int countToday;
  final int countSchedule;

  const Section({Key key, this.onToday, this.onSchedule, this.countToday = 0, this.countSchedule = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 9,
            child: GestureDetector(
                onTap: onToday,
                child: SectionCalender(
                    imgPath: "assets/calendar.png",
                    title: "Today",
                    count: countToday,
                    color: Colors.blue))),
        SizedBox(width: 20),
        Flexible(
            flex: 9,
            child: GestureDetector(
              onTap: onSchedule,
              child: SectionCalender(
                  imgPath: "assets/clock.png",
                  title: "Scheduled",
                  count: countSchedule,
                  color: Colors.amberAccent),
            ))
      ],
    );
  }
}
