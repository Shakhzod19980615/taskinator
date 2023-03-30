import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/model/calendar_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/datetime.dart';
import 'package:flutter_timeline_calendar/timeline/model/day_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/headers_options.dart';
import 'package:flutter_timeline_calendar/timeline/utils/calendar_types.dart';
import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:taskinatoruz/colors/colors.dart';
import 'package:taskinatoruz/screens/update_page.dart';

import '../db/database_helper.dart';
import '../db/db_helper.dart';
import '../model/task_model.dart';
import '../widget/list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  //final dbhelper =DatabaseHelper.instance;
  List<TaskModel>? taskModel;
  var selectedDate = CalendarDateTime(year:DateTime.now().year, month: DateTime.now().month, day: DateTime.now().day,);
  var _sqliteService = SqliteService();
  TabController? tabController;
  @override
  void initState() {
    // TODO: implement initState
    tabController = TabController(length: 4, vsync: this,);
    setState(() {

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      backgroundColor: bkground,

      appBar: AppBar(
        title:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.line_axis_sharp,color: tdOrange,),
            Text("Todays progress",style: TextStyle(fontSize: 15,color: tdOrange),),
          ],
        ),
        elevation: 0,
        backgroundColor: bkground,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(left: 0,right: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: TimelineCalendar(
                dateTime: selectedDate,
                calendarType: CalendarType.GREGORIAN,
                calendarLanguage: "en",
                calendarOptions: CalendarOptions(
                  viewType: ViewType.DAILY,
                  toggleViewType: true,
                  headerMonthElevation: 0,
                  bottomSheetBackColor: bkground,
                  headerMonthShadowColor: bkground,
                  headerMonthBackColor: Colors.transparent,
                ),
                dayOptions: DayOptions(
                    compactMode: true,
                    weekDaySelectedColor: tabLayColor,
                weekDayUnselectedColor: tdOrange,
                selectedBackgroundColor: tdOrange,
                unselectedTextColor: tabLayColor),
                headerOptions: HeaderOptions(
                    weekDayStringType: WeekDayStringTypes.SHORT,
                    monthStringType: MonthStringTypes.FULL,
                    calendarIconColor: tdOrange,
                    backgroundColor: bkground,
                    resetDateColor: tdOrange,
                    navigationColor: tdOrange,
                    headerTextColor: tdOrange),
                onChangeDateTime: (datetime) {
                  selectedDate = datetime;
                  setState(() {
                    
                  });
                },
              )
            ),
            Card(
              elevation: 3,
              child: DefaultTabController(
                length: 4,
                child: TabBar(
                  controller: tabController,
                  indicatorColor: tdOrange,
                  tabs: [
                    Tab(
                      child: Column(
                        children: [
                          Icon(Icons.mosque,color: tdOrange,),
                          Text("Islam",style: TextStyle(fontSize: 12,color: tdOrange),)
                        ],),),
                    Tab(
                      child: Column(
                        children: [
                          Icon(Icons.family_restroom,color: tdOrange,),
                          Text("Family",style: TextStyle(fontSize: 12,color: tdOrange),)
                        ],),),
                    Tab(
                      child: Column(
                        children: [
                          Icon(Icons.work,color: tdOrange,),
                          Text("Work",style: TextStyle(fontSize: 12,color: tdOrange),)
                        ],),),
                    Tab(
                      child: Column(
                        children: [
                          Icon(Icons.person,color: tdOrange,),
                          Text("Personal",style: TextStyle(fontSize: 12,color: tdOrange),)
                        ],),)
                  ],
                ),
                )
              ),
            Container(
              width: double.maxFinite,
              height: 350,
              padding: EdgeInsets.zero,
              margin: EdgeInsets.only(left: 10,right: 10,),
              child: TabBarView(
                  controller: tabController,
                  children: [
                    /*Image.asset("assets/images/Islam.jpg"),*/
                    _islamList(),
                    _familyList(),
                    //Image.asset("assets/images/Family.jpg"),
                    _workList(),
                    //Image.asset("assets/images/Work.jpg"),
                    _personalList(),
                    //Image.asset("assets/images/Personal.jpg")]),
              ]
            ))

          ],
        ),
      ),
    );
  }
   Widget _islamList()  {
    return FutureBuilder<List<TaskModel>>(
        future:   _sqliteService.getIslamTasks(selectedDate.toString()),
        builder: (context, snapshot){
        if(snapshot.hasData && snapshot.data?.isEmpty==true) {
          return Image.asset("assets/images/Islam.jpg");
        }else{
          var list =  snapshot.data;
          return  Container(
            margin: EdgeInsets.only(top: 10,bottom: 10),
            padding: EdgeInsets.only(top: 10),
            height: 350,
            width: 300,
            child: ListView.builder(
              shrinkWrap: true,
                itemCount: list?.length ??0,
                itemBuilder: (context,index){
                  return ListItem(taskList: list,index1: index,);
                }),
          );
        }
      },
    );
  }
   Widget _familyList()  {
    return FutureBuilder<List<TaskModel>>(
      future:   _sqliteService.getFamilyTasks(selectedDate.toString()),
      builder: (context, snapshot){
        if(snapshot.hasData && snapshot.data?.isEmpty==true) {
          return Image.asset("assets/images/Family.jpg");
        }else{
          var list =  snapshot.data;
          return  Container(
            margin: EdgeInsets.only(top: 10,bottom: 10),
            padding: EdgeInsets.only(top: 10),
            height: 350,
            width: 300,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: list?.length ??0,
                itemBuilder: (context,index){
                  return ListItem(taskList: list,index1: index,);
                }),
          );
        }
      },
    );


  }
   Widget _workList()  {
    return FutureBuilder<List<TaskModel>>(
      future:   _sqliteService.getWorkTasks(selectedDate.toString()),
      builder: (context, snapshot){
        if(snapshot.hasData && snapshot.data?.isEmpty==true ) {
          return Image.asset("assets/images/Work.jpg");
        }else{
          var list =  snapshot.data;
          return  Container(
            margin: EdgeInsets.only(top: 10,bottom: 10),
            padding: EdgeInsets.only(top: 10),
            height: 350,
            width: 300,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: list?.length ??0,
                itemBuilder: (context,index){
                  return ListItem(taskList: list,index1: index,);
                }),
          );
        }
      },
    );


  }
   Widget _personalList()  {
    return FutureBuilder<List<TaskModel>>(
      future:   _sqliteService.getPersonalTasks(selectedDate.toString()),
      builder: (context, snapshot){
        if(snapshot.hasData && snapshot.data?.isEmpty==true) {
          return Image.asset("assets/images/Work.jpg");
        }else{
          var list =  snapshot.data;
          return  Container(
            margin: EdgeInsets.only(top: 10,bottom: 10),
            padding: EdgeInsets.only(top: 10),
            height: 350,
            width: 300,
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: list?.length ??0,
                itemBuilder: (context,index){
                  return ListItem(taskList: list,index1: index,);
                }),
          );
        }
      },
    );


  }


}
