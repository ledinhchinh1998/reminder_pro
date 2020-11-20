import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddNoteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            ),
            Text('Back',style: TextStyle(
                color: Colors.blue,
                fontSize: 18
            ))
          ],
        )
      ),
      body: Container(
        // margin: EdgeInsets.all(10),
        // padding: EdgeInsets.all(10),
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
                children: [
                  Text(
                    "Alarm",style: TextStyle(

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
