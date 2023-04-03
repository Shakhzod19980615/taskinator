import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:checkbox_formfield/checkbox_formfield.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:taskinatoruz/db/database_helper.dart';
import 'package:taskinatoruz/main.dart';
import 'package:taskinatoruz/model/task_model.dart';
import 'package:taskinatoruz/screens/home_page.dart';
import 'package:taskinatoruz/utils/notification_service.dart';

import '../colors/colors.dart';
import '../db/db_helper.dart';
import '../widget/bottom_sheet.dart';

class AddingPage extends StatefulWidget {
  const AddingPage({Key? key, this.savedTaskId}) : super(key: key);
  final savedTaskId;
  @override
  State<AddingPage> createState() => _AddingPageState();
}

class _AddingPageState extends State<AddingPage> with SingleTickerProviderStateMixin {
  final titleController = TextEditingController();
  final titleDescriptionController = TextEditingController();
  final dateController = TextEditingController();
  final startTimeController = TextEditingController();
  final endTimeController = TextEditingController();
  final String dateNow = DateTime.now().toString();
  final savedTabIndex =TextEditingController() ;
   int tabIndex = 0;
  String category = "";
  String date = "";
  String startTime = "";
  String endTime = "";
  bool? isSaved = false;
  late int? saved;
  TaskModel? taskById;
  //final dbhelper =DatabaseHelper.instance;
  late TabController _tabController;
  final _titleKey = GlobalKey<FormState>();
  var _sqliteService = SqliteService();
  late final NotificationService service;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
    initializeDateFormatting();
    getList();
    service = NotificationService();
    service.initNotification();
    listenNotification();
    //this._sqliteService= SqliteService();
  }
  void listenNotification()=>service.onNotificationClick.stream.listen((onNotificationListener));

  void onNotificationListener (String? payload){
    if(payload !=null && payload.isNotEmpty){
      print("payload $payload");

      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
}
  getList()async{
    taskById =await _sqliteService.getTaskById(widget.savedTaskId);
    titleController.text = taskById?.task_title??"";
    dateController.text = taskById?.task_date??"";
    titleDescriptionController.text = taskById?.task_description??"";
    startTimeController.text = taskById?.start_time??"";
    endTimeController.text = taskById?.end_time??"";
    tabIndex = taskById?.category??0;
    _tabController.index = tabIndex;
    //tabIndex.text = taskById?.category??;
   // savedTabIndex.text = taskById?.category??"";
    //_tabController.index= taskById?.category??"";
    setState(() {

    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
   List<Tab> myTabs = <Tab>[
    Tab(child: Text("Islam",style: TextStyle(fontSize: 16),),),
    Tab(child: Text("Family",style: TextStyle(fontSize: 16),),),
    Tab(child: Text("Work",style: TextStyle(fontSize: 16),),),
    Tab(child: Text("Personal",style: TextStyle(fontSize: 16),),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bkground,
      appBar: AppBar(
        title: Row(
          children: [
            Text("Add a new task", style: TextStyle(fontSize: 20,color: bottomNav,fontWeight: FontWeight.w500),),
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
                },
                child: Icon(Icons.cancel,color: bottomNav,))
          ],
        ),
        elevation: 0,
        backgroundColor: bkground,
      ),
      body:SingleChildScrollView(

        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: EdgeInsets.only(left: 15,right: 15),

          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  showModalBottomSheet(shape:RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20) ),
                  ), context: context, builder: (c)=> BottomSheetTask(
                  ));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
                  margin: EdgeInsets.only(top: 25,bottom: 30),
                  decoration: BoxDecoration(
                      color: bottomNav,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Row(
                    children: [
                      Text("Choose a task from your saved tasks list", style: TextStyle(fontSize: 14, color: Colors.white),),
                      Spacer(),
                      Icon(Icons.double_arrow,color: Colors.white,)
                    ],
                  ),
                ),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Select category*", style: TextStyle(fontSize: 14,color: Colors.orange),)),
              Container(
                margin: EdgeInsets.only(top: 25,bottom: 30),
                decoration: BoxDecoration(
                    color: Color(0xFFf7cfa6),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.label,
                  isScrollable: true,
                  padding: EdgeInsets.zero,
                  indicatorPadding: EdgeInsets.zero,
                  //labelPadding: EdgeInsets.zero,
                  controller: _tabController,
                  tabs: myTabs,
                  labelColor: Colors.white,
                  unselectedLabelColor: Colors.orange,

                  /*child: Row(
                    children: <Widget>[
                    ButtonsTabBar(
                      backgroundColor: Colors.orange,
                      unselectedBackgroundColor: Color(0xFFf7cfa6),
                      unselectedBorderColor:  Color(0xFFf7cfa6),
                      unselectedLabelStyle: TextStyle(color: Colors.orange),
                      labelStyle:
                      TextStyle(color: Colors.white,fontSize: 18, fontWeight: FontWeight.bold),
                      tabs: [
                        Tab(text: "Islam"),
                        Tab(text: "Family"),
                        Tab(text: "Work"),
                        Tab(text: "Personal"),

                    ],
                  ),
                ]
                  ),*/
              )

              ),
              Form(
                key: _titleKey,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  child: TextFormField(
                    controller: titleController,
                    validator: (value){
                      if(value ==null || value.isEmpty ){
                          return 'Please enter title';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange )
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: CupertinoColors.inactiveGray)
                      ),
                      labelText: 'Task title*',
                      labelStyle: TextStyle(color:  Colors.orange)
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: TextFormField(
                  controller: titleDescriptionController,
                  decoration: const InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange )
                      ),
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: CupertinoColors.inactiveGray)
                      ),
                      labelText: 'Task description',
                      labelStyle: TextStyle(color:  Colors.orange)
                  ),
                ),
              ),
              Container(
                height: 90,
                width: MediaQuery.of(context).size.width*0.88,
                margin: EdgeInsets.only(top: 10),
                child: DateTimePicker(
                  type: DateTimePickerType.date,
                  controller: dateController,
                  icon: Icon(Icons.calendar_month,color: Colors.orange,),
                  dateLabelText: "Date",
                  cursorColor: Colors.orange,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(3000),
                  locale: Locale("en","US"),
                  onChanged: (val) {
                    date = val;
                  }
                ),
              ),
              Row(
                children: [
                  Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width*0.35,
                    child: DateTimePicker(
                        type: DateTimePickerType.time,
                        controller: startTimeController,
                        icon: Icon(Icons.access_time_rounded,color: Colors.orange,),
                        timeLabelText: "Start time",
                        cursorColor: Colors.orange,
                        use24HourFormat: true,
                        locale: Locale("pt","BR"),
                        onChanged: (val) {
                          startTime = val;
                        }
                    ),
                  ),
                  Spacer(),
                  Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width*0.4,
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
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFf1f5f0),
                  borderRadius: BorderRadius.circular(10)
              ),
                child: Row(
                  children:<Widget> [
                    Checkbox(
                        onChanged: (bool? value){
                          setState(() {
                            isSaved = value!;
                          });
                        },
                      value: this.isSaved,),
                    Text("Save this task for future use",style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.w500),),
                  ],
                ),
              ),
              InkWell(
                onTap: ()async {
                  print(dateNow);

                  if(isSaved == false ){
                    saved = 0;
                  }else{
                    saved = 1;
                  }
                  if(_titleKey.currentState!.validate()){
                    var result = await _sqliteService.insertData(TaskModel(
                        category:_tabController.index,
                        task_title: titleController.text,
                        task_description: titleDescriptionController.text,
                        task_date: date,start_time: startTime,end_time: endTime,isSaved: saved));
                    print(result);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              MyHomePage()
                      ),
                    );
                  }
                 await NotificationService().showNotification(title: titleController.text,body: titleDescriptionController.text,id: 0);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.38,vertical: 20),
                  margin: EdgeInsets.only(top: 20),
                  child: Text("SUBMIT",style: TextStyle(color: Colors.white),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
