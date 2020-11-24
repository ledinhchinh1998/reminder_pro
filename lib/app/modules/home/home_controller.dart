import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:note_app_pro/app/data/helper/mldb_helper.dart';
import 'package:note_app_pro/app/data/model/list_model.dart';
import 'package:note_app_pro/app/data/model/schedule_model.dart';
import 'package:note_app_pro/app/modules/create_note/list_note_view.dart';

class HomeController extends GetxController {
  var focus = FocusNode();
  var textController = TextEditingController();

  //textController man hinh add Note
  var textCTLTitle = TextEditingController();
  var textCTLNote = TextEditingController();

  var isClear = true.obs;
  var calendars = List<ListModel>().obs;
  DateTime now = DateTime.now();
  var items = List<ScheduleModel>().obs;
  var itemsToTitle = List<ScheduleModel>().obs;

  // khong search nua
  void cancelSearch() {
    textController.text = '';
    focus.unfocus();
    isClear.value = true;
    update();
  }

  // clearText search
  void onChangText(String value) {
    if (value.isEmpty) {
      isClear.value = true;
    } else {
      isClear.value = false;
    }
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
    super.onInit();
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
    await MLDBHelper.deleteItemList(listModel);
    getMyList();
  }

  // khi click vao today,get danh sach note

  Future<void> getListNote({String titleID}) async {
    items.value.clear();
    List<Map<String, dynamic>> noteList = await MLDBHelper.query();
    items.value = noteList.map((data) => ScheduleModel.fromJson(data)).toList();
    if (titleID == null) {
      return;
    }
    itemsToTitle.value.clear();
    items.value.forEach((note) {
      if (titleID == note.list) {
        itemsToTitle.value.add(note);
      }
    });
  }

  void getNoteToList(String titleID) {
    itemsToTitle.value.clear();
    if (titleID == null) {
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
    getListNote(titleID: titleID);
    textCTLNote.clear();
    textCTLTitle.clear();
    update();
  }

  void updateNotes({String titleID,ScheduleModel noteModel}) async {
    await MLDBHelper.update(noteModel);
    getListNote(titleID: titleID);
  }

  void createNote({String name,Color otherColor}) {
    getNoteToList(name);
    Get.to(CreateScheduleView(
      titleID: name,
      otherColor: otherColor,
    ));
  }


}
