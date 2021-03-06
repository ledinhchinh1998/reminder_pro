import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:note_app_pro/app/data/helper/mldb_helper.dart';
import 'package:note_app_pro/app/data/model/list_model.dart';
import 'package:note_app_pro/app/data/model/schedule_model.dart';
import 'package:note_app_pro/app/modules/create_note/list_note_view.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../../main.dart';

class HomeController extends GetxController {
  var focus = FocusNode();
  var textController = TextEditingController();

  //textController man hinh add Note
  var textCTLTitle = TextEditingController();
  var textCTLNote = TextEditingController();

  var isClear = true.obs;
  var calendars = List<ListModel>().obs;
  var now = DateTime.now().obs;
  var items = List<ScheduleModel>().obs;
  var itemsFilter = List<ScheduleModel>().obs;
  var itemsToTitle = List<ScheduleModel>().obs;
  var key= "".obs;
  var titleList = "".obs;
  var countToList = 0.obs;

  // khong search nua
  void cancelSearch() {
    textController.text = '';
    focus.unfocus();
    isClear.value = true;
    key.value = "";
    update();
  }

  // filter search
  void filterSearchResult(String query) {
    if (query.isEmpty) {
      return;
    } else {
      itemsFilter.value.clear();
      items.value.forEach((element) {
        if (element.title.toLowerCase().contains(query)) {
          itemsFilter.value.add(element);
        }
      });
    }
  }

  void onTextChangeTitleList(value){
    titleList.value = value;
  }

  // clearText search
  void onChangText(String value) {
    if (value.isEmpty) {
      isClear.value = true;
    } else {
      isClear.value = false;
    }
    key.value = value;
    filterSearchResult(value);
  }

  // update trang thai stick
  void setCheckBox(String titleID,ScheduleModel scheduleModel){
    if (scheduleModel.isScheduled == 0) {
      scheduleModel.isScheduled = 1;
    }  else {
      scheduleModel.isScheduled = 0;
    }
    print("TEST ${scheduleModel.isScheduled}");
    updateNotes(titleID: titleID,noteModel: scheduleModel);
  }

  @override
  void onInit() async {
    getMyList();
    getListNote();
    itemsFilter.addAll(items);
    _configureLocalTimeZone();
    super.onInit();
  }


  // get count today man hinh homeview
  int getCount(){
    var itemsToTitle = List<ScheduleModel>().obs;
    items.value.forEach((note) {
      if ("Today" == note.list && note.isScheduled == 0) {
        itemsToTitle.value.add(note);
      }
    });
    update();
    return itemsToTitle.value.length;
  }
  int getCountSchedule(){
    var itemsToTitle = List<ScheduleModel>().obs;
    items.value.forEach((note) {
      if (note.isScheduled == 0) {
        itemsToTitle.value.add(note);
      }
    });
    update();
    return itemsToTitle.value.length;
  }

  int getCountToList(String list){
    var itemsToTitle = List<ScheduleModel>().obs;
    items.value.forEach((note) {
      if (note.list == list) {
        itemsToTitle.value.add(note);
      }
    });
    update();
    return itemsToTitle.value.length;
  }

  // get danh sach note hien thi ben ngoai minh hinh Home view
  Future<void> getMyList() async {
    List<Map<String, dynamic>> noteList = await MLDBHelper.queryList();
    calendars.value = noteList.map((data) => ListModel.fromMap(data)).toList();
  }

  Future<void> addList(ListModel listModel) async {
    await MLDBHelper.insertList(listModel);
    getMyList();
  }

  Future<void> deleteNote(ListModel listModel) async {
    items.value.forEach((note) async {
      if (listModel.title == note.list) {
        await MLDBHelper.delete(note);
      }
    });
    await MLDBHelper.deleteItemList(listModel);
    getMyList();
    getNotes();
  }

  // khi click vao today,get danh sach note

  Future<void> getNotes() async {
    List<Map<String, dynamic>> noteList = await MLDBHelper.query();
    items.value = noteList.map((data) => ScheduleModel.fromJson(data)).toList();
  }

  Future<void> getListNote({String titleID}) async {
    //items.value.clear();
    List<Map<String, dynamic>> noteList = await MLDBHelper.query();
    items.value = noteList.map((data) => ScheduleModel.fromJson(data)).toList();
    itemsToTitle.value.clear();
    if (titleID == "All") {
      itemsToTitle.value.addAll(items.value);
    }else if (titleID == "Scheduled"){
      items.value.forEach((note) {
        if (0 == note.isScheduled) {
          itemsToTitle.value.add(note);
        }
      });
    }else{
      items.value.forEach((note) {
        if (titleID == note.list) {
          itemsToTitle.value.add(note);
        }
      });
    }
  }

  void getNoteToList(String titleID) {
    itemsToTitle.value.clear();
    if (titleID == null || titleID == "All") {
      itemsToTitle.addAll(items);
      return;
    }
    items.value.forEach((note) {
      if (titleID == note.list) {
        itemsToTitle.value.add(note);
      }
    });
  }

  Future<void> addNote({String titleID, ScheduleModel scheduleModel}) async {
    await MLDBHelper.insert(scheduleModel);
    await getListNote(titleID: titleID);
    textCTLNote.clear();
    textCTLTitle.clear();
    update();
  }
  void updateNotes({String titleID,ScheduleModel noteModel}) async {
    await MLDBHelper.update(noteModel);
    await getListNote(titleID: titleID).then((value) {
      update();
    });
  }
  void deleteNotes({String titleID,ScheduleModel noteModel}) async {
    await MLDBHelper.delete(noteModel);
    await getListNote(titleID: titleID).then((value) {
      update();
    });
  }

  // chuyen man hinh va loc list
  void createNote({String name,Color otherColor}) {
    getNoteToList(name);
    Get.to(CreateScheduleView(
      titleID: name,
      otherColor: otherColor,
    ));
    update();
  }

  void schedule() {
    itemsToTitle.value.clear();
    items.value.forEach((note) {
      if (0 == note.isScheduled) {
        itemsToTitle.value.add(note);
      }
    });
    Get.to(CreateScheduleView(
      otherColor: Colors.yellow,
      titleID: "Scheduled",
    ));
  }

  // push notification

  Future<void> zonedScheduleNotification({int year, int month,int day,int hour,int minute,String title,String body,}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        title,
        body,
        _nextInstanceOfTenAM(year: year,month: month,day: day,hour: hour,minute: minute),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }
  tz.TZDateTime _nextInstanceOfTenAM({int year, int month,int day,int hour,int minute}) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, year,month, day, hour,minute);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    var timeZoneName = await platform.invokeMethod('getTimeZoneName');
    print(timeZoneName);
    if (timeZoneName.toString() == "Asia/Saigon") {
      timeZoneName = "Asia/Ho_Chi_Minh";
    }
    tz.setLocalLocation(tz.getLocation(timeZoneName.toString()));
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }


}
