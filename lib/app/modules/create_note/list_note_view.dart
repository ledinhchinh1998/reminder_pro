import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_pro/app/data/model/schedule_model.dart';
import 'package:note_app_pro/app/modules/home/home_controller.dart';
import 'package:note_app_pro/app/themes/style.dart';
import 'package:intl/intl.dart';
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
              color: widget.otherColor != null ? widget.otherColor : Colors.blue,
            ),
          ),
          backgroundColor: Colors.transparent,
          title: Text(
            'List',
            style:
                TextStyle(color: widget.otherColor != null ? widget.otherColor : Colors.blue),
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
                  "${widget.titleID ?? "All"}",
                  style: GoogleFonts.nunito(
                      color: widget.otherColor != null ? widget.otherColor : Colors.blue,
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
                            color: Colors.white,
                            height: 150,
                            width: 150,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text("List của bạn đang bị rỗng")
                        ],
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var item = controller.itemsToTitle.value[index];
                        return ListTile(
                          leading: CircularCheckBox(
                            inactiveColor: Colors.white,
                            checkColor: Colors.blue,
                            activeColor: Colors.white,
                            value: item.isScheduled == 0 ? false : true,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            onChanged: (value) {
                              controller.setCheckBox(widget.titleID, item);
                              controller.update();
                              setState(() {});
                            },
                          ),
                          title: Text('${item.title ?? ''}'),
                          subtitle: Text('${item.momentOfReminding ?? ''}'),
                          trailing: IconButton(
                            onPressed: () {
                              Get.bottomSheet(ShowBottomSheetNote(item: item,));
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

  void showDialogTest(context) {
    showGeneralDialog(
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: Duration(milliseconds: 700),
      context: context,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Dialog(
          child: Container(
            height: 400,
            padding: const EdgeInsets.all(20),
            child: Column(
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
                          onTap: () {},
                          child: Text(
                            DateFormat('yyyy-MM-dd – kk:mm')
                                .format(controller.now),
                            style: TextStyle(color: Colors.grey),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    onPressed: () {
                      var item = ScheduleModel(
                          list: widget.titleID,
                          isScheduled: 0,
                          title: controller.textCTLTitle.text,
                          momentOfReminding: DateFormat('yyyy-MM-dd – kk:mm')
                              .format(controller.now),
                          note: controller.textCTLNote.text,
                          dateTime: DateFormat('yyyy-MM-dd – kk:mm')
                              .format(controller.now));
                      controller.addNote(titleID: widget.titleID, scheduleModel: item);
                      Get.back();
                    },
                    child: Icon(
                      Icons.save_alt,
                      color: Colors.blue,
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      transitionBuilder: (_, anim, __, child) {
        return SlideTransition(
          position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
          child: child,
        );
      },
    );
  }
}

class ShowBottomSheetNote extends StatefulWidget {

  final ScheduleModel item;
  final Function onDelete;
  final Function onUpdate;

  ShowBottomSheetNote({Key key, this.item, this.onDelete, this.onUpdate}) : super(key: key);

  @override
  _ShowBottomSheetNoteState createState() => _ShowBottomSheetNoteState();
}

class _ShowBottomSheetNoteState extends State<ShowBottomSheetNote> {
  final TextEditingController textTitleCTL = TextEditingController();
  final TextEditingController textNoteCTL = TextEditingController();
  var isShow = false;
  HomeController controller  = Get.find();

  @override
  Widget build(BuildContext context) {
    textTitleCTL.text = widget.item.title;
    textNoteCTL.text = widget.item.note;
    return Container(
      child: Column(
        children: [
          AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              onPressed: widget.onDelete,
              icon: Icon(Icons.delete,color: Colors.red,),
            ),
            title: Text('${widget.item.title}',style: styleText24,),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: widget.onUpdate,
                icon: Icon(Icons.done_outline_rounded,color: Colors.green,),
              )
            ],
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                InputText(title: 'Title',textEditingController: textTitleCTL,),
                InputText(title: 'Note',textEditingController: textNoteCTL,),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Notification",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Switch.adaptive(
                      value: isShow,
                      onChanged: (value) async {
                        isShow = value;
                        setState(() {
                        });
                      },
                    )
                  ],
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    Get.dialog(Dialog(
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 400,
                        child: Column(
                          children: [
                            Text('Choose List',style: titleText24BLUE,),
                            Expanded(
                              child: ListView.separated(
                                itemCount: controller.calendars.value.length,
                                separatorBuilder: (BuildContext context, int index) {
                                  return Divider();
                                },
                                itemBuilder: (BuildContext context, int index) {
                                  var item = controller.calendars.value[index];
                                  return ListTile(
                                    leading: Icon(Icons.folder_open_outlined),
                                    title: Text('${item.title}'),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Move to List",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      Icon(Icons.navigate_next,color: Colors.white,)
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

