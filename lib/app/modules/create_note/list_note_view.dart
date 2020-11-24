import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:note_app_pro/app/modules/home/home_controller.dart';
import 'package:note_app_pro/app/themes/style.dart';
import 'list_note/add_note_view.dart';
import 'package:intl/intl.dart';

class CreateScheduleView extends StatelessWidget {
  final HomeController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: ZoomIn(
          child: FloatingActionButton(
            onPressed: () {
              showDialogTest(context);
            },
            child: Icon(Icons.add_circle),
          ),
          preferences: AnimationPreferences(duration: Duration(seconds: 2)),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text('List'),
          centerTitle: false,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TITLE",
                  style: titleText24BLUE,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircularCheckBox(
                        inactiveColor: Colors.white,
                        checkColor: Colors.blue,
                        activeColor: Colors.white,
                        value: false,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        onChanged: (value) {},
                      ),
                      title: Text("Test List"),
                      subtitle: Text("subText"),
                      trailing: Icon(Icons.info),
                    );
                  },
                  itemCount: 5,
                )
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
                  title: 'New',
                ),
                InputText(
                  title: 'Note',
                ),
                SizedBox(height: 10),
                Container(
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
                          "formattedDate",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10),
                  color: Colors.white12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "List",
                        style: TextStyle(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          ">",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: (){},
                    child: Icon(Icons.save_alt),
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
