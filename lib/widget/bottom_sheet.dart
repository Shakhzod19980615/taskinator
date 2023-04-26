import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskinatoruz/widget/saved_list_item.dart';

import '../db/db_helper.dart';
import '../model/task_model.dart';

class BottomSheetTask extends StatelessWidget {
  const BottomSheetTask({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _sqliteService = SqliteService();
    return SingleChildScrollView(

      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                Text("Ro'yxatdan tanlang",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700),),
                Spacer(),
                GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel))
              ],
            ),
            Container(
                alignment: AlignmentDirectional.centerStart,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Text("Tanlash uchun vazifalar ustiga bosing")),
            FutureBuilder<List<TaskModel>>(
                future:  _sqliteService.getSavedTasks(),
                builder: (context,snapshot){
                  if(snapshot.data!.isEmpty){
                    return Container(
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Text("Saqlangan vazifa yo'q",style: TextStyle(fontSize: 30,fontWeight: FontWeight.w500),));
                  }else{
                    var list =  snapshot.data;
                    return Container(
                      width: 300,
                      height: 300,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: list?.length,
                          itemBuilder: (context,index){
                            return SavedListItem(
                              savedTaskList: list,
                              savedTaskIndex: index,
                            );
                          }),
                    );
                  }
                })
          ],
        ),
      ),
    );
  }
}
