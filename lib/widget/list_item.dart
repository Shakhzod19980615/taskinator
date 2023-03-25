import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/task_model.dart';

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
      onTap: (){},
      child: Container(
        child: Column(
          children: [
            Row(
              children: [
                Text(widget.taskList![widget.index1].task_title??""),
                Icon(Icons.access_time_rounded,color: Colors.orange,),
                Text(widget.taskList![widget.index1].start_time??""),
                Icon(Icons.arrow_forward, color: Colors.orange,),
                Text(widget.taskList![widget.index1].end_time??"")
              ],
            ),
            Row(
              children: [
                Text(widget.taskList![widget.index1].task_description??""),
                Checkbox(value: isCompleted, onChanged: (value){
                  setState(() {
                    value = isCompleted;
                  });
                })
              ],
            )
          ],
        ),
      ),
    );
  }
}
