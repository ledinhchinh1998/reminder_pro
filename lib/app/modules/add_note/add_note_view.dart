import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:note_app_pro/app/modules/home/home_controller.dart';

class AddNoteView extends StatelessWidget {

  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(controller.now);
    return Scaffold(
      backgroundColor: Colors.black54,
      appBar: AppBar(
        leadingWidth: 100,
        backgroundColor: Colors.black54,
        leading: Row(
          children: [
            IconButton(
              onPressed: (){
                Get.back();
              },
              icon: Icon(Icons.arrow_back,color: Colors.blue,),
            )
          ],
        )
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.white12,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "New",
                        focusedBorder: InputBorder.none
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.white12,
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Note",
                      focusedBorder: InputBorder.none
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
