import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_pro/app/data/model/list_model.dart';
import 'package:note_app_pro/app/modules/create_note/list_note_view.dart';
import 'package:note_app_pro/app/modules/home/home_controller.dart';
import 'package:note_app_pro/app/themes/style.dart';

import 'item_list.dart';

class SectionMyListCalendar extends StatefulWidget {
  final List<ListModel> calendars;

  SectionMyListCalendar({this.calendars});

  @override
  _SectionMyListCalendarState createState() => _SectionMyListCalendarState();
}

class _SectionMyListCalendarState extends State<SectionMyListCalendar> {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        reverse: true,
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.calendars.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            height: 1,
            color: Colors.grey,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          var item = widget.calendars[index];
          var arr =
          item.color.split(':')[1].split('(0x')[1].split(')')[0];
          int value = int.parse(arr, radix: 16);
          Color otherColor = new Color(value);
          int count = controller.getCountToList(item.title);
          return ItemCalendar(
              onSelected: () async {
                await Future.sync(() {
                  controller.createNote(name: item.title,otherColor: otherColor);
                  setState(() {});
                });
              },
              updateNode: (){
                Get.snackbar("Hello Guy!", "Tính năng đang phát triển",snackPosition: SnackPosition.BOTTOM,colorText: Colors.blue);
              },
              deleteNote:(){
                Get.defaultDialog(
                    title: 'Delete',
                    titleStyle: titleStyle,
                    middleText: 'Are you sure you delete the ${item.title}? ',
                    confirm: FlatButton(
                      onPressed: () {
                        controller.deleteNote(item);
                        Get.back();
                      },
                      child: Text(
                        'Delete',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    cancel: FlatButton(
                      onPressed:(){
                        Get.back();
                      },
                      child: Text('Cancel'),
                    ));
              },
              colorIcon: otherColor,
              title: item.title,
              count: count);
        });
  }
}