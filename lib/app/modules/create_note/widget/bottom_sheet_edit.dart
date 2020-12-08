import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_pro/app/data/model/schedule_model.dart';
import 'package:note_app_pro/app/modules/home/create_list_view/create_list_view.dart';
import 'package:note_app_pro/app/modules/home/home_controller.dart';
import 'package:note_app_pro/app/modules/home/widgets/button_border.dart';
import 'package:note_app_pro/app/themes/style.dart';

import 'bottom_sheet.dart';
import 'input_widget.dart';
import 'package:intl/intl.dart';



class ShowBottomSheetNote extends StatefulWidget {
  final ScheduleModel item;
  final String titleID;
  final Function onDelete;
  final Function onUpdate;

  ShowBottomSheetNote(
      {Key key, this.item, this.onDelete, this.onUpdate, this.titleID})
      : super(key: key);

  @override
  _ShowBottomSheetNoteState createState() => _ShowBottomSheetNoteState();
}

class _ShowBottomSheetNoteState extends State<ShowBottomSheetNote> {
  final TextEditingController textTitleCTL = TextEditingController();
  final TextEditingController textNoteCTL = TextEditingController();
  var isShow = false;
  HomeController controller = Get.find();
  var dateTime = DateTime.now();
  var nameFolder = '';


  void _showDemoPicker({
    @required BuildContext context,
    @required Widget child,
  }) {
    final themeData = CupertinoTheme.of(context);
    final dialogBody = CupertinoTheme(
      data: themeData,
      child: child,
    );

    showCupertinoModalPopup<void>(
      context: context,
      builder: (context) => dialogBody,
    );
  }

  @override
  Widget build(BuildContext context) {
    textTitleCTL.text = widget.item.title;
    textNoteCTL.text = widget.item.note;
    return Container(
      color: Colors.black87,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${widget.item.title}', style: styleText24,),
                  SizedBox(
                    height: 20,
                  ),
                  InputText(
                    title: 'Title', textEditingController: textTitleCTL,),
                  InputText(title: 'Note', textEditingController: textNoteCTL,),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Notification",
                        style: TextStyle(color: Colors.white, fontSize: 18),),
                      Switch.adaptive(
                        value: widget.item.isScheduled == 0 ? false : true,
                        onChanged: (value) async {
                          if (value) {
                            print('Check ${dateTime.minute}');
                            widget.item.isScheduled = 1;
                            await controller.zonedScheduleNotification(
                                year: dateTime.year,
                                month: dateTime.month,
                                day: dateTime.day,
                                hour: dateTime.hour,
                                minute: dateTime.minute,
                                title: 'Công việc của bạn ',
                                body: widget.item.title);
                          }else{
                            print('Check $value');
                            widget.item.isScheduled = 0;
                            await controller.cancelAllNotifications();
                          }
                          setState(() {});
                        },
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Date Time",
                        style: TextStyle(color: Colors.white, fontSize: 18),),
                      InkWell(
                          onTap: () {
                            _showDemoPicker(
                              context: context,
                              child: BottomPicker(
                                child: CupertinoDatePicker(
                                  backgroundColor: Colors.white30,
                                  mode: CupertinoDatePickerMode.dateAndTime,
                                  initialDateTime: DateTime.now(),
                                  onDateTimeChanged: (newDateTime) {
                                    dateTime = newDateTime;
                                    setState(() {});
                                  },
                                ),
                              ),
                            );
                          },
                          child: Text("${DateFormat('yyyy-MM-dd kk:mm')
                              .format(dateTime)}"))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      //Show dialog
                      Get.dialog(Dialog(
                        child: Obx((){
                          return Container(
                            padding: EdgeInsets.all(10),
                            height: 400,
                            child: Column(
                              children: [
                                Text('Choose List', style: titleText24BLUE,),
                                Expanded(
                                  child: controller.calendars
                                      .value.length > 0 ? ListView.separated(
                                    itemCount: controller.calendars.value.length,
                                    separatorBuilder: (BuildContext context,
                                        int index) {
                                      return Divider();
                                    },
                                    itemBuilder: (BuildContext context,
                                        int index) {
                                      var item = controller.calendars
                                          .value[index];
                                      return ListTile(
                                        onTap: () {
                                          nameFolder = item.title;
                                          setState(() {});
                                          Get.back();
                                        },
                                        leading: Icon(Icons.folder_open_outlined),
                                        title: Text('${item.title}'),
                                      );
                                    },
                                  ) : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/box.png",width: 100,height: 100,color: Colors.white,),
                                      RaisedButton(
                                        onPressed: () async{
                                          var res = await Get.to(CreateListView());
                                          print(res);
                                          setState(() {});
                                        },
                                        child: Text('Create List'),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      ));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Move to List", style: TextStyle(color: Colors
                            .white, fontSize: 18),),
                        Text("${nameFolder.isEmpty ? (widget.item.list == null ? "" : widget.item.list.isEmpty) : nameFolder} >  ")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ButtonBorder(
                          title: "Delete",
                          color: Colors.red,
                          onPressed:(){
                            controller.deleteNotes(
                                titleID: widget.titleID, noteModel: widget.item);
                            Get.back();
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Flexible(
                        child: ButtonBorder(
                          title: "Save",
                          color: Colors.blue,
                          onPressed:(){
                            var itemNote = ScheduleModel(
                              id: widget.item.id,
                              list: nameFolder.isEmpty ? widget.titleID : nameFolder,
                              isScheduled: widget.item.isScheduled,
                              title: textTitleCTL.text,
                              note: textNoteCTL.text,
                              momentOfReminding: DateFormat('yyyy-MM-dd kk:mm')
                                  .format(dateTime),
                              dateTime: DateFormat('yyyy-MM-dd kk:mm')
                                  .format(dateTime),
                            );
                            controller.updateNotes(titleID: widget.titleID,noteModel: itemNote);
                            Get.back();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}