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
  late final String? task_description;
  @override
  void initState() {
    // TODO: implement initState
    task_description = widget.taskList![widget.index1].task_description;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var takDescription = widget.taskList![widget.index1].task_description??"";
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  UpdatePage(taskId: widget.taskList![widget.index1].id,
                  )
          ),
        );
      },
      child: Container(

        margin: EdgeInsets.only(bottom: 10,left: 10,right: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
        ),
        child: Card(
          elevation: 5,
          child: Column(
            children: [
              Container(
                color: isCompleted ==true ? bottomNavLight : bottomNav,
                padding: EdgeInsets.all(20),

                child: Row(
                  children: [
                    Expanded(
                      child:Text(widget.taskList![widget.index1].task_title??"",
                      style: TextStyle(color: Colors.white,decoration: isCompleted == true? TextDecoration.lineThrough : null,decorationThickness: 3),)
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

                color: isCompleted == true? gray : Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  children: [
                    Expanded(
                        child: task_description!.isEmpty?
                        Text("Bu vazifa uchun tavsif qo‘shilmagan",
                            style: TextStyle(decoration: isCompleted == true? TextDecoration.lineThrough : null)):
                        Text(task_description!,
                    style: TextStyle(decoration: isCompleted == true? TextDecoration.lineThrough : null),)),
                    Checkbox(value: isCompleted , onChanged: (bool? value){
                      setState(() {
                        isCompleted = value!;
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
