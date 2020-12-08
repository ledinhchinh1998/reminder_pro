import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_pro/app/data/model/schedule_model.dart';
import 'package:note_app_pro/app/modules/home/home_controller.dart';
import 'package:note_app_pro/app/modules/home/widgets/button_border.dart';
import 'package:note_app_pro/app/themes/style.dart';
import 'package:intl/intl.dart';
import 'widget/bottom_sheet.dart';
import 'widget/bottom_sheet_edit.dart';
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: ZoomIn(
          child: FloatingActionButton(
            backgroundColor: widget.otherColor != null ? widget.otherColor : Colors.blue,
            onPressed: () {
              showBottomCreate();
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
          title: Text('List', style: TextStyle(color: widget.otherColor != null ? widget.otherColor : Colors.blue),
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
                      physics: NeverScrollableScrollPhysics(),
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
                              await Get.bottomSheet(
                                  ShowBottomSheetNote(
                                    item: item,
                                    titleID: widget.titleID,
                                  )).then((value) {
                                    setState(() {});
                              });
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

  void showBottomCreate(){
    Get.bottomSheet(Obx((){
      return Container(
        padding: const EdgeInsets.all(20),
        color: Colors.black87,
        child: ListView(
          children: [
            Text(
              "NEW NOTE",
              style: styleText24,
            ),
            SizedBox(height: 20),
            InputText(
              textEditingController: controller.textCTLTitle,
              title: 'New title',
            ),
            InputText(
              textEditingController: controller.textCTLNote,
              title: 'New description',
            ),
            SizedBox(height: 10),
            Card(
              child: Container(
                padding: EdgeInsets.all(12),
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
            ButtonBorder(
              title: "Save",
              onPressed: (){
                var title = controller.textCTLTitle.text.trimLeft().trimRight();
                if (title.isEmpty) {
                  Get.snackbar("Error", "Title is empty",colorText: Colors.red,snackPosition: SnackPosition.BOTTOM);
                  return;
                }
                var item = ScheduleModel(
                    list: widget.titleID == null ? "All" : widget.titleID,
                    isScheduled: 0,
                    title: title,
                    momentOfReminding: DateFormat('yyyy-MM-dd kk:mm')
                        .format(controller.now.value),
                    note: controller.textCTLNote.text,
                    dateTime: DateFormat('yyyy-MM-dd kk:mm')
                        .format(controller.now.value));
                controller.addNote(titleID: widget.titleID == null ? "All" : widget.titleID, scheduleModel: item);
                Get.back();
              },
            )
          ],
        ),
      );
    })).then((value){
      print("vao day");
      controller.now.value = DateTime.now();
      setState(() {});
    });
  }
}
