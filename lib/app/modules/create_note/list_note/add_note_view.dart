import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_app_pro/app/modules/create_note/widget/input_widget.dart';
import 'package:note_app_pro/app/modules/home/home_controller.dart';
import 'package:note_app_pro/app/themes/style.dart';

class AddNoteView extends StatelessWidget {

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(controller.now.value);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("ADD NOTE",style: styleText24,),
            SizedBox(height: 50),
            InputText(title: 'New',),
            InputText(title: 'Note',),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.white12,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Alarm",style: TextStyle(
                    fontSize: 18
                  ),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Text(
                      formattedDate,
                      style: TextStyle(
                        color: Colors.grey
                      ),
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
                    "Repeat",style: TextStyle(
                      fontSize: 18
                  ),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Text(
                      "Not >",
                      style: TextStyle(
                          color: Colors.grey
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

