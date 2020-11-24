import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:get/get.dart';
import 'package:note_app_pro/app/modules/home/home_controller.dart';
import 'package:note_app_pro/app/modules/home/widgets/section.dart';
import 'package:note_app_pro/app/themes/style.dart';
import 'package:note_app_pro/app/utils/color_extension.dart';
import 'create_list_view/create_list_view.dart';
import 'widgets/list_schedule.dart';
import 'widgets/search.dart';
import 'widgets/select_item.dart';

class HomeView extends StatelessWidget {

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('REMINDER',style: bodyText,),
                SizedBox(height: 20,),
                Obx(() {
                  return HeaderView(
                    onCancel: controller.cancelSearch,
                    onChange: (value) => controller.onChangText(value),
                    focusNode: controller.focus,
                    controller: controller.textController,
                    isClear: controller.isClear.value,
                  );
                }),
                SizedBox(height: 20,),
                Section(onToday: (){
                  controller.createNote(name :'Today');
                },onSchedule: (){}  ,),
                SizedBox(height: 20,),
                Obx((){
                  return SectionCalender(
                      onclick: () => controller.createNote(),
                      imgPath: "assets/zip.png",
                      title: "  All",
                      count: controller.items.length ?? 0,
                      color: HexColor.fromHex("#9E9E9E"));
                }),
                SizedBox(height: 20,),
                Text('My List',style: bodyText,),
                Obx(() {
                  if (controller.calendars.value.isEmpty) {
                    return Container(
                      margin: const EdgeInsets.only(top: 50),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/box.png',color: Colors.white,width: 200,height: 200,),
                          Text('List is Empty')
                        ],
                      ),
                    );
                  }  else {
                    return SectionMyListCalendar(
                      calendars: controller.calendars.value,
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ZoomIn(
        preferences: AnimationPreferences(duration: Duration(seconds: 5)),
        child: FloatingActionButton(
          onPressed: () async{
            var text = await Get.to(CreateListView());
          },
          child: Icon(Icons.add_circle),
        ),
      ),
    );
  }
}
