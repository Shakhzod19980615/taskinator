import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../colors/colors.dart';

class AddingPage extends StatefulWidget {
  const AddingPage({Key? key}) : super(key: key);

  @override
  State<AddingPage> createState() => _AddingPageState();
}

class _AddingPageState extends State<AddingPage> {
  final titleController = TextEditingController();
  final titleDescriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bkground,
      appBar: AppBar(
        title: Row(
          children: [
            Text("Add a new task", style: TextStyle(fontSize: 20,color: bottomNav,fontWeight: FontWeight.w500),),
            Spacer(),
            Icon(Icons.cancel,color: bottomNav,)
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
              Container(
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Select category*", style: TextStyle(fontSize: 14,color: Colors.orange),)),
              Container(

                padding: EdgeInsets.only(left: 20),
                margin: EdgeInsets.only(top: 25,bottom: 30),
                decoration: BoxDecoration(
                    color: Color(0xFFf7cfa6),
                    borderRadius: BorderRadius.circular(10)
                ),
                child: DefaultTabController(
                  length: 4,
                  child: Row(
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
                  ),
              )

              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: TextFormField(
                  controller: titleController,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
