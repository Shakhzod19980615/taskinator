import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timeline_calendar/timeline/model/calendar_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/day_options.dart';
import 'package:flutter_timeline_calendar/timeline/model/headers_options.dart';
import 'package:flutter_timeline_calendar/timeline/utils/calendar_types.dart';
import 'package:flutter_timeline_calendar/timeline/widget/timeline_calendar.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:taskinatoruz/colors/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 4, vsync: this,);
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
                  print(datetime.getDate());
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
              height: 300,
              child: TabBarView(
                  controller: tabController,
                  children: [Image.asset("assets/images/Islam.jpg"),
                    Image.asset("assets/images/Family.jpg"),
                    Image.asset("assets/images/Work.jpg"),
                    Image.asset("assets/images/Personal.jpg")]),
            )

          ],
        ),
      ),
    );
  }
}
