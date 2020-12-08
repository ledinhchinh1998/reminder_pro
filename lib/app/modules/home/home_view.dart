import 'dart:io';

import 'package:flutter/material.dart';
import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:note_app_pro/app/modules/create_note/list_note_view.dart';
import 'package:note_app_pro/app/modules/home/home_controller.dart';
import 'package:note_app_pro/app/modules/home/widgets/section.dart';
import 'package:note_app_pro/app/themes/style.dart';
import 'package:note_app_pro/app/utils/color_extension.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../main.dart';
import 'create_list_view/create_list_view.dart';
import 'widgets/list_schedule.dart';
import 'widgets/search.dart';
import 'widgets/select_item.dart';

class HomeView extends StatefulWidget {

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final controller = Get.put(HomeController());



  @override
  void initState() {
    super.initState();
    _requestPermissions();
    _configureDidReceiveLocalNotificationSubject();
  }

  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationSubject.stream
        .listen((ReceivedNotification receivedNotification) async {
      await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: receivedNotification.title != null
              ? Text(receivedNotification.title)
              : null,
          content: receivedNotification.body != null
              ? Text(receivedNotification.body)
              : null,
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: () async {
                Navigator.of(context, rootNavigator: true).pop();
                await Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        CreateScheduleView(),
                  ),
                );
              },
              child: const Text('Ok'),
            )
          ],
        ),
      );
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Hello!',style: titleText24BLUE,),
                  Text('Have a good day')
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Setting'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.star_rate),
              title: Text('Rate me'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app_sharp),
              title: Text('Exit'),
              onTap: () {
                exit(0);
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => _scaffoldKey.currentState.openDrawer(),
                    child: Text('REMINDER',style: bodyText,)),
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
                Obx((){
                  if(controller.key.value.isEmpty){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(() {
                          return Section(
                            onToday: () {
                              controller.createNote(name: 'Today');
                              FocusScope.of(context).requestFocus(FocusNode());
                            },
                            countToday: controller.getCount(),
                            onSchedule: () {
                              FocusScope.of(context).requestFocus(FocusNode());
                              controller.schedule();
                            },
                            countSchedule: controller.getCountSchedule(),
                          );
                        }),
                        SizedBox(
                          height: 20,
                        ),
                        Obx(() {
                          return SectionCalender(
                              onclick: () {
                                FocusScope.of(context).requestFocus(FocusNode());
                                controller.createNote(name: "All");
                              },
                              imgPath: "assets/zip.png",
                              title: "  All",
                              count: controller.items.length ?? 0,
                              color: HexColor.fromHex("#9E9E9E"));
                        }),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'My List',
                          style: bodyText,
                        ),
                        Obx(() {
                          if (controller.calendars.value.isEmpty) {
                            return Container(
                              margin: const EdgeInsets.only(top: 50),
                              width: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/box.png',
                                    color: Colors.white,
                                    width: 150,
                                    height: 150,
                                  ),
                                  SizedBox(height: 10),
                                  Text('List is Empty')
                                ],
                              ),
                            );
                          } else {
                            return SectionMyListCalendar(
                              calendars: controller.calendars.value,
                            );
                          }
                        }),
                      ],
                    );
                  }else {
                    return controller.itemsFilter.value.length > 0 ? ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var item = controller.itemsFilter.value[index];
                        return ListTile(
                          onTap: (){
                            controller.createNote(name: item.list);
                          },
                          leading: CircularCheckBox(
                            inactiveColor: Colors.white,
                            checkColor: Colors.blue,
                            activeColor: Colors.white,
                            value: item.isScheduled == 0 ? false : true,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            onChanged: (value) {
                              controller.setCheckBox("", item);
                              controller.update();
                            },
                          ),
                          title: Text('${item.title ?? ''}', style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold),),
                          subtitle: Text('${item.momentOfReminding ?? ''}'),
                        );
                      },
                      itemCount: controller.itemsFilter.value.length,
                    ) : Center(child: Text('Không có kết quả nào cả'),);
                  }
                })
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: ZoomIn(
        preferences: AnimationPreferences(duration: Duration(seconds: 5)),
        child: FloatingActionButton(
          onPressed: () async{
            await Get.to(CreateListView());
            controller.titleList.value = "";
          },
          child: Icon(Icons.add_circle),
        ),
      ),
    );
  }
  _launchURL() async {
    const url = 'https://google.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}
