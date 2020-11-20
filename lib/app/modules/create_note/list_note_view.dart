import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_pro/app/modules/home/home_controller.dart';
import 'package:note_app_pro/app/themes/style.dart';
import 'list_note/add_note_view.dart';


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
        backgroundColor: Colors.transparent,
        leadingWidth: 80,
        title: Text('List'),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("TITLE",style: titleText24BLUE,),
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
                      onChanged: (value) {

                      },
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
      )
    );
  }
}
