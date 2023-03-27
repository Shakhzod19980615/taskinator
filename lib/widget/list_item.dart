import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../model/task_model.dart';
import '../screens/update_page.dart';

class ListItem extends StatefulWidget {
   ListItem({Key? key, required this.taskList, required this.index1}) : super(key: key);
  final List<TaskModel>? taskList;
   final int index1;
  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool? isCompleted = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UpdatePage()
          ),
        );
      },
      child: Card(
        elevation: 5,

        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          child: Column(
            children: [
              Container(
                color: bottomNav,
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(widget.taskList![widget.index1].task_title??"",
                      style: TextStyle(color: Colors.white),),
                    ),
                    Icon(Icons.access_time_rounded,color: Colors.orange,),
                    Text(widget.taskList![widget.index1].start_time??"",
                    style: TextStyle(color: Colors.white),),
                    Icon(Icons.arrow_forward, color: Colors.orange,),
                    Text(widget.taskList![widget.index1].end_time??"",
                    style: TextStyle(color: Colors.white),)
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    Expanded(child: Text(widget.taskList![widget.index1].task_description??"")),
                    Checkbox(value: isCompleted , onChanged: (value){
                      setState(() {
                        value = isCompleted;
                      });
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
