import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ItemCalendar extends StatelessWidget {
  final Color colorIcon;
  final String title;
  final int count;
  final Function deleteNote;
  final Function updateNode;
  final Function onSelected;

  ItemCalendar(
      {this.colorIcon,
      this.title,
      this.count,
      this.deleteNote,
      this.updateNode, this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        child: InkWell(
          onTap: onSelected,
          child: Container(
            padding: EdgeInsets.only(bottom: 10, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: colorIcon,
                            borderRadius: BorderRadius.circular(25)),
                        child: Icon(
                          Icons.list,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      SizedBox(width: 10),
                      Flexible(
                        child: Text(
                          title,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      '',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                      color: Colors.grey,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Delete',
          color: Colors.red,
          icon: Icons.delete,
          onTap: deleteNote,
        ),
        IconSlideAction(
          caption: 'Update',
          color: Colors.blue,
          icon: Icons.system_update_alt_sharp,
          onTap: updateNode,
        ),
      ],
    );
  }
}
