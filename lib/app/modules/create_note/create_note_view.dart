import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_pro/app/themes/style.dart';

class CreateScheduleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            IconButton(
              onPressed: (){
                Get.back();
              },
              icon: Icon(Icons.arrow_back,color: Colors.blue,),
            ),
            Text('List',style: titleText,)
          ],
        ),
      ),
      body: Container(
        child: Text('My Body'),
      ),
    );
  }
}
