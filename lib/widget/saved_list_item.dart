import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';
import '../model/task_model.dart';

class SavedListItem extends StatelessWidget {
  SavedListItem({Key? key, required this.savedTaskList,required this.onTap, required this.index}) : super(key: key);
  final List<TaskModel>? savedTaskList;
  final VoidCallback onTap;
  final int index;
  late String _taskCategory;
  @override
  Widget build(BuildContext context) {
    int? taskCategory = savedTaskList![index].category?.toInt();
    if(taskCategory.toString() =="0"){
      _taskCategory = "Ibodatlar";
    }else if(taskCategory.toString() == "1"){
      _taskCategory = "Oila";

    }else if(taskCategory.toString() =="2"){
      _taskCategory = "Ish";
    }else{
      _taskCategory = "Shaxsiy";
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 0,vertical: 5),
        decoration: BoxDecoration(
            color: bottomNav,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Text("Vazifa nomi",style: TextStyle(fontSize: 14,color: Colors.white),),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: const Text("-",style: TextStyle(fontSize: 14,color: Colors.white),)),
                Text(savedTaskList![index].task_title??"",style: const TextStyle(fontSize: 14,color: Colors.white),)
              ],
            ),
            Row(
              children: [
                const Text("Kategoriya",style: TextStyle(fontSize: 14,color: Colors.white)),
                Container(margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: const Text("-",style: TextStyle(fontSize: 14,color: Colors.white),)),
                Text(_taskCategory,style: const TextStyle(fontSize: 14,color: Colors.white),)
              ],
            ),
            Row(
              children: [
                const Text("Boshlanish vaqti",style: TextStyle(fontSize: 14,color: Colors.white)),
                Container(margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: const Text("-",style: TextStyle(fontSize: 14,color: Colors.white),)),
                Text(savedTaskList![index].start_time??"",style: const TextStyle(fontSize: 14,color: Colors.white),)
              ],
            ),
            Row(
              children: [
                const Text("Tugash vaqti",style: TextStyle(fontSize: 14,color: Colors.white)),
                Container(margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: const Text("-",style: TextStyle(fontSize: 14,color: Colors.white),)),
                Text(savedTaskList![index].end_time??"",style: const TextStyle(fontSize: 14,color: Colors.white),)
              ],
            )
          ],
        ),
      ),
    );
  }
}


