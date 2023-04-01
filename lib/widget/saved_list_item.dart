import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskinatoruz/screens/adding_page.dart';

import '../colors/colors.dart';
import '../model/task_model.dart';

class SavedListItem extends StatefulWidget {
  SavedListItem({Key? key, required this.savedTaskList, required this.savedTaskIndex}) : super(key: key);
  final List<TaskModel>? savedTaskList;
  final int savedTaskIndex;
  @override
  State<SavedListItem> createState() => _SavedListItemState();
}

class _SavedListItemState extends State<SavedListItem> {
   late String _taskCategory;
  @override
  Widget build(BuildContext context) {
    int? taskCategory = widget.savedTaskList?[widget.savedTaskIndex].category?.toInt();
    if(taskCategory.toString() =="0"){
      _taskCategory = "Islam";
    }else if(taskCategory.toString() == "1"){
      _taskCategory = "Work";

    }else if(taskCategory.toString() =="2"){
      _taskCategory = "Family";
    }else{
      _taskCategory = "Personal";
    }
   /* switch(widget.savedTaskList?.first.category??0){
      case 0 : taskCategory = "Islam";
      break;
      case 1: taskCategory = "Work";
      break;
      case 2: taskCategory = "Family";
      break;
      case 3: taskCategory = "Personal";
      break;
    }*/
    return GestureDetector(
      onTap: () async{ await
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  AddingPage(savedTaskId: widget.savedTaskList![widget.savedTaskIndex].id,
                  )
          ),
        );
        Navigator.of(context).pop();
        //Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.symmetric(horizontal: 0,vertical: 5),
        decoration: BoxDecoration(
            color: bottomNav,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text("Name",style: TextStyle(fontSize: 14,color: Colors.white),),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Text("-",style: TextStyle(fontSize: 14,color: Colors.white),)),
                Text(widget.savedTaskList![widget.savedTaskIndex].task_title??"",style: TextStyle(fontSize: 14,color: Colors.white),)
              ],
            ),
            Row(
              children: [
                Text("Category",style: TextStyle(fontSize: 14,color: Colors.white)),
                Container(margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Text("-",style: TextStyle(fontSize: 14,color: Colors.white),)),
                Text(_taskCategory,style: TextStyle(fontSize: 14,color: Colors.white),)
              ],
            ),
            Row(
              children: [
                Text("Start time",style: TextStyle(fontSize: 14,color: Colors.white)),
                Container(margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Text("-",style: TextStyle(fontSize: 14,color: Colors.white),)),
                Text(widget.savedTaskList?[widget.savedTaskIndex].start_time??"",style: TextStyle(fontSize: 14,color: Colors.white),)
              ],
            ),
            Row(
              children: [
                Text("End time",style: TextStyle(fontSize: 14,color: Colors.white)),
                Container(margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Text("-",style: TextStyle(fontSize: 14,color: Colors.white),)),
                Text(widget.savedTaskList?[widget.savedTaskIndex].end_time??"",style: TextStyle(fontSize: 14,color: Colors.white),)
              ],
            )
          ],
        ),
      ),
    );
  }
}
