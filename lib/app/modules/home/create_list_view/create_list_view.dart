import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_pro/app/data/model/list_model.dart';
import 'package:note_app_pro/app/modules/home/home_controller.dart';

class CreateListView extends StatefulWidget {

  @override
  _CreateListViewState createState() => _CreateListViewState();
}

class _CreateListViewState extends State<CreateListView> {
  final HomeController controller = Get.find();

  final textEditingController = TextEditingController();

  Color colorBg = Colors.lightBlue;
  Color borderColor = Colors.black26;

  final List<Color> listColor = [
    Colors.deepOrange,
    Colors.amber,
    Colors.amberAccent,
    Colors.green,
    Colors.lightBlue,
    Colors.deepPurpleAccent,
    Colors.brown
  ];

  void doneAction() {
    var item = ListModel();
    if (textEditingController.text.isNotEmpty) {
      item.title = textEditingController.text;
      item.color = colorBg.toString();
      controller.calendars.value.add(item);
      controller.addList(item);
      controller.update();
      Get.back();
    } else {
      Get.snackbar('Error', 'Text input is empty!',
          snackPosition: SnackPosition.BOTTOM, colorText: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.black87,
        automaticallyImplyLeading: false,
        title: Text(
          "New list",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading:IconButton(
          onPressed:() => Get.back(),
          icon: Icon(Icons.arrow_back_ios,color: Colors.blue,),
        ),
        centerTitle: true,
        actions: [
          Obx((){
            return FlatButton(
              onPressed: controller.titleList.value.isEmpty ? null : doneAction,
              child: Text(
                "Done",
                style: TextStyle(
                    color:controller.titleList.value.isEmpty ? Colors.grey : Colors.blue,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            );
          })
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: colorBg, borderRadius: BorderRadius.circular(60)),
                padding: EdgeInsets.all(15),
                child: Icon(
                  Icons.list,
                  size: 50,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey[800],
                    borderRadius: BorderRadius.circular(10)),
                child: TextFormField(
                    onChanged: (value){
                      controller.onTextChangeTitleList(value);
                    },
                    maxLength: 30,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.sentences,
                    textAlign: TextAlign.center,
                    controller: textEditingController,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                        hintText: 'Enter title',
                        border: InputBorder.none),
                ),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: listColor
                    .map((item) => GestureDetector(
                  onTap: () {
                    colorBg = item;
                    setState(() {});
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        color: item,
                        border: Border.all(color: borderColor),
                        borderRadius: BorderRadius.circular(25)),
                  ),
                ))
                    .toList()
                    .cast<Widget>(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}