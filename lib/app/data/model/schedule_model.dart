
import 'package:flutter/cupertino.dart';

class ScheduleModel {
  int id;
  int isScheduled;
  String title;
  String momentOfReminding;
  FocusNode focusNode;
  String dateTime;
  String note;

  ScheduleModel({this.id,this.isScheduled, this.title, this.momentOfReminding, this.focusNode, this.note, this.dateTime});


   ScheduleModel.fromJson(Map<String, dynamic> map) {
     id = map['id'];
     isScheduled = map['isScheduled'];
     title = map['title'];
     momentOfReminding = map['momentOfReminding'];
     focusNode =  map['focusNode'] ;
     dateTime = map['dateTime'] ;
     note = map['note'];
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'isScheduled': this.isScheduled,
      'title': this.title,
      'momentOfReminding': this.momentOfReminding,
      'focusNode': this.focusNode,
      'dateTime': this.dateTime,
      'note': this.note,
    } as Map<String, dynamic>;
  }

}