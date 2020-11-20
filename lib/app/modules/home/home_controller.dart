import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:note_app_pro/app/data/helper/mldb_helper.dart';
import 'package:note_app_pro/app/data/model/list_model.dart';

class HomeController extends GetxController {
  var focus = FocusNode();
  var textController = TextEditingController();
  var isClear = true.obs;
  var calendars = List<ListModel>().obs;
  DateTime now = DateTime.now();

  void cancelSearch(){
    textController.text = '';
    focus.unfocus();
    isClear.value = true;
    update();
  }

  void onChangText(String value){
    if (value.isEmpty) {
      isClear.value = true;
    }  else{
      isClear.value = false;
    }
  }

  @override
  void onInit() async {
    getMyList();
    super.onInit();
  }


  Future<void> getMyList() async {
    List<Map<String, dynamic>> noteList = await MLDBHelper.queryList();
    calendars.value = noteList.map((data) => ListModel.fromMap(data)).toList();
  }

  Future<void> addNote(ListModel listModel) async {
    await MLDBHelper.insertList(listModel);
    getMyList();
  }

  Future<void> deleteNote(ListModel listModel) async {
    await MLDBHelper.deleteItemList(listModel);
    getMyList();
  }

}