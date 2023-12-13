import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../colors/colors.dart';
import '../db/db_helper.dart';
import '../main.dart';
import '../model/task_model.dart';
import '../settings/main_provider.dart';
import '../utils/notification_service.dart';
import 'home_page.dart';

class UpdatePage extends StatefulWidget {
  UpdatePage({Key? key, required this.taskId, }) : super(key: key);
  final int? taskId;
  //final int index;
  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  final _titleKey = GlobalKey<FormState>();
  String endTime = "";
  String startTime = "";
  TaskModel? taskById;
  var _sqliteService = SqliteService();

  final titleController = TextEditingController();
  final titleDescriptionController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  late final NotificationService service;
  @override
  void initState() {
    service = NotificationService();
    service.initNotification();
    service.notificationDetails();
    listenNotification();
    setState(() {

    });
    super.initState();
    getList();
  }
  void listenNotification()=>service.onNotificationClick.stream.listen((onNotificationListener));
  void onNotificationListener (String? payload){
    if(payload !=null && payload.isNotEmpty){
      print("payload $payload");

      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
  }
  getList()async{
     taskById =await _sqliteService.getTaskById(widget.taskId);
     titleController.text = taskById?.task_title??"";
     titleDescriptionController.text = taskById?.task_description??"";
     startTimeController.text = taskById?.start_time??"";
     endTimeController.text = taskById?.end_time??"";
     setState(() {

     });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: bkground,
      appBar: AppBar(
        title: Row(
          children: [
            Text("Vazifani tahrirlash", style: TextStyle(fontSize: 20,color: Colors.orange,fontWeight: FontWeight.w500),),
            Spacer(),
            InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MyHomePage()
                    ),
                  );
                  //Navigator.of(context).pop();
                },
                child: Icon(Icons.cancel,color: Colors.orange,))
          ],
        ),
        elevation: 0,
        backgroundColor: bkground,
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(left: 15,right: 15),
          child: Column(
            children: [
              Container(
                  alignment: AlignmentDirectional.centerStart,
                  margin: EdgeInsets.only(top: 30,bottom: 10),
                  child: Text(taskById?.task_date??"",
                    style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.w700),)),
              Form(
                key: _titleKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: TextFormField(
                    controller: titleController,
                    validator: (value){
                      if(value ==null || value.isEmpty ){
                        return 'Iltimos, sarlavha kiriting';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black38 )
                        ),
                        disabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: CupertinoColors.inactiveGray)
                        ),
                        labelText: 'Vazifa nomi*',
                        labelStyle: TextStyle(color:  Colors.black38)
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  controller: titleDescriptionController,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black38 )
                      ),
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CupertinoColors.inactiveGray)
                      ),
                      labelText: "Vazifa tavsifi",
                      labelStyle: TextStyle(color:  Colors.black38)
                  ),
                ),
              ),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: DateTimePicker(
                    type: DateTimePickerType.time,
                    controller: startTimeController,
                    icon: Icon(Icons.access_time_rounded,color: Colors.orange,),
                    timeLabelText: "Boshlanish vaqti",
                    cursorColor: Colors.orange,
                    use24HourFormat: true,
                    locale: Locale("pt","BR"),
                    onChanged: (val) {
                      startTime = val;
                    }
                ),
              ),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width,
                child: DateTimePicker(
                    type: DateTimePickerType.time,
                    controller: endTimeController,
                    icon: Icon(Icons.access_time_rounded,color: Colors.orange,),
                    timeLabelText: "End time",
                    cursorColor: Colors.orange,
                    use24HourFormat: true,
                    locale: Locale("pt","BR"),
                    onChanged: (val) {
                      endTime = val;
                    }
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: ()async {
                      await service.cancelTask(taskById?.id);
                     await _sqliteService.deleteTask(taskById?.id);

                      Navigator.pop(context);
                      setState(() {

                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                      margin: const EdgeInsets.only(top: 20,left: 10,),
                      child: const Text("Oʻchirish",style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: ()async {

                      await _sqliteService.updateTasks(
                          TaskModel(
                              id: taskById?.id,
                              task_title: titleController.text.toString(),
                              task_description: titleDescriptionController.text.toString(),
                              start_time: startTimeController.text.toString(),
                              end_time: endTimeController.text.toString()
                          ),
                      );

                      //Provider.of<MainSettingsProvider>(context,listen:false).changeMenuIndex(0);
                       Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                      margin: EdgeInsets.only(top: 20,right: 10),
                      child: Text("Yangilash",style: TextStyle(color: Colors.white,fontSize: 20),),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );


  }
}
