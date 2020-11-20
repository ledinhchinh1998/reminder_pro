import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_pro/app/modules/add_note/add_note_view.dart';
import 'package:note_app_pro/app/modules/create_list/create_list_view.dart';
import 'package:note_app_pro/app/modules/create_note/widget/item_list_view.dart';
import 'package:note_app_pro/app/modules/home/home_controller.dart';
import 'package:note_app_pro/app/themes/style.dart';

class CreateScheduleView extends StatelessWidget {
  final HomeController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(AddNoteView());
        },
        child: Icon(Icons.add_circle),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black54,
        leadingWidth: 80,
        leading: Row(
          children: [
            IconButton(
              onPressed: (){
                Get.back();
              },
              icon: Icon(Icons.arrow_back,color: Colors.blue,),
            ),
            Text('List',style: TextStyle(
              color: Colors.blue,
              fontSize: 18
            ))
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ItemListView();
            },
            itemCount: 5,
          ),
        ),
      )
    );
  }
}
