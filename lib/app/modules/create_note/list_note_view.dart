import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_pro/app/data/model/schedule_model.dart';
import 'package:note_app_pro/app/modules/home/create_list_view/create_list_view.dart';
import 'package:note_app_pro/app/modules/home/home_controller.dart';
import 'package:note_app_pro/app/themes/style.dart';
import 'package:intl/intl.dart';
import 'widget/bottom_sheet.dart';
import 'widget/input_widget.dart';

class CreateScheduleView extends StatefulWidget {
  final String titleID;
  final Color otherColor;

  CreateScheduleView({Key key, this.titleID, this.otherColor})
      : super(key: key);

  @override
  _CreateScheduleViewState createState() => _CreateScheduleViewState();
}

class _CreateScheduleViewState extends State<CreateScheduleView> {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
        floatingActionButton: ZoomIn(
          child: FloatingActionButton(
            backgroundColor: widget.otherColor != null
                ? widget.otherColor
                : Colors.blue,
            onPressed: () {
              showDialogTest(context);
            },
            child: Icon(Icons.add_circle),
          ),
          preferences: AnimationPreferences(duration: Duration(seconds: 2)),
        ),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: widget.otherColor != null ? widget.otherColor : Colors
                  .blue,
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text('List', style: TextStyle(
              color: widget.otherColor != null ? widget.otherColor : Colors
                  .blue),
          ),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  " ${widget.titleID ?? "All"}",
                  style: GoogleFonts.nunito(
                      color: widget.otherColor != null
                          ? widget.otherColor
                          : Colors.blue,
                      fontSize: 36,
                      fontWeight: FontWeight.bold),
                ),
                Obx(() {
                  if (controller.itemsToTitle.value.isEmpty) {
                    return Container(
                      width: size.width,
                      height: size.height * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/box.png",
                            color: widget.otherColor != null
                                ? widget.otherColor
                                : Colors.white,
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("Your list is empty", style: TextStyle(
                              color: widget.otherColor != null ? widget
                                  .otherColor : Colors.white),)
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      reverse: true,
                      itemBuilder: (context, index) {
                        var item = controller.itemsToTitle.value[index];
                        return ListTile(
                          leading: CircularCheckBox(
                            inactiveColor: widget.otherColor != null ? widget
                                .otherColor : Colors.white,
                            checkColor: widget.otherColor != null
                                ? Colors.white
                                : Colors.blue,
                            activeColor: widget.otherColor != null ? widget
                                .otherColor : Colors.white,
                            value: item.isScheduled == 0 ? false : true,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            onChanged: (value) {
                              controller.setCheckBox(widget.titleID, item);
                              controller.update();
                              setState(() {});
                            },
                          ),
                          title: Text('${item.title ?? ''}', style: TextStyle(
                              color: widget.otherColor != null ? widget
                                  .otherColor : Colors.white,
                              fontWeight: FontWeight.bold),),
                          subtitle: Text('${item.momentOfReminding ?? ''}'),
                          trailing: IconButton(
                            onPressed: () async {
                              var reso = await Get.bottomSheet(
                                  ShowBottomSheetNote(
                                    item: item,
                                    titleID: widget.titleID,
                                  ));
                              setState(() {});
                            },
                            icon: Icon(Icons.info),
                          ),
                        );
                      },
                      itemCount: controller.itemsToTitle.value.length,
                    );
                  }
                })
              ],
            ),
          ),
        ));
  }
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

  void showDialogTest(context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (_, __, ___) {
        return Dialog(
          child: Container(
            height: 400,
            padding: const EdgeInsets.all(20),
            child: Obx((){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "ADD NOTE",
                    style: styleText24,
                  ),
                  SizedBox(height: 20),
                  InputText(
                    textEditingController: controller.textCTLTitle,
                    title: 'New title',
                  ),
                  InputText(
                    textEditingController: controller.textCTLNote,
                    title: 'New note',
                  ),
                  SizedBox(height: 10),
                  Card(
                    elevation: 5,
                    shadowColor: Colors.white,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.white12,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Alarm",
                            style: TextStyle(fontSize: 18),
                          ),
                          GestureDetector(
                            onTap: () {
                              _showDemoPicker(
                                context: context,
                                child: BottomPicker(
                                  child: CupertinoDatePicker(
                                    backgroundColor: Colors.white30,
                                    mode: CupertinoDatePickerMode.dateAndTime,
                                    initialDateTime: DateTime.now(),
                                    onDateTimeChanged: (newDateTime) {
                                      controller.now.value = newDateTime;
                                      setState(() {});
                                    },
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              DateFormat('yyyy-MM-dd kk:mm').format(controller.now.value),
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 10),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: () {
                          var title = controller.textCTLTitle.text.trimLeft().trimRight();
                          var item = ScheduleModel(
                              list: widget.titleID,
                              isScheduled: 0,
                              title: title,
                              momentOfReminding: DateFormat('yyyy-MM-dd kk:mm')
                                  .format(controller.now.value),
                              note: controller.textCTLNote.text,
                              dateTime: DateFormat('yyyy-MM-dd kk:mm')
                                  .format(controller.now.value));
                          controller.addNote(
                              titleID: widget.titleID, scheduleModel: item);
                          Get.back();
                        },
                        child: Icon(
                          Icons.save_alt,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    ).then((value) {
      setState(() {});
      controller.now.value = DateTime.now();
    });
  }
}

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
      color: Colors.black54,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () {
                  controller.deleteNotes(
                      titleID: widget.titleID, noteModel: widget.item);
                  Get.back();
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
              title: Text('${widget.item.title}', style: styleText24,),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
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
                  icon: Icon(
                    Icons.done_outline_rounded,
                    color: Colors.green,
                  ),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
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
                        Text("${nameFolder.isEmpty ? widget.item.list : nameFolder} >  ")
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
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
