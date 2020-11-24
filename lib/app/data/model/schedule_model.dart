
class ScheduleModel {
  int id;
  String list;
  int isScheduled;
  String title;
  String momentOfReminding;
  String dateTime;
  String note;

  ScheduleModel({this.id,this.list,this.isScheduled, this.title, this.momentOfReminding, this.note, this.dateTime});


   ScheduleModel.fromJson(Map<String, dynamic> map) {
     id = map['id'];
     list = map['list'];
     isScheduled = map['isScheduled'];
     title = map['title'];
     momentOfReminding = map['momentOfReminding'];
     dateTime = map['dateTime'] ;
     note = map['note'];
  }

  Map<String, dynamic> toJson() {
    // ignore: unnecessary_cast
    return {
      'id': this.id,
      'list': this.list,
      'isScheduled': this.isScheduled,
      'title': this.title,
      'momentOfReminding': this.momentOfReminding,
      'dateTime': this.dateTime,
      'note': this.note,
    } as Map<String, dynamic>;
  }

}