import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:taskinatoruz/screens/adding_page.dart';
import 'package:taskinatoruz/screens/home_page.dart';
import 'package:taskinatoruz/screens/settings_page.dart';
import 'package:taskinatoruz/screens/tips_page.dart';
import 'package:taskinatoruz/settings/main_provider.dart';
import 'package:taskinatoruz/settings/settings_provider.dart';

import 'colors/colors.dart';

void main() {

  runApp(

      MultiBlocProvider(
        providers: [ChangeNotifierProvider(
          create: (context) => SettingsProvider()..initState(),
        ),
        ChangeNotifierProvider(create: (context)=>MainSettingsProvider())],
        child: const MyApp() ,
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        color: Colors.transparent,
        debugShowCheckedModeBanner: false,
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key,});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 int index = 0;
 final bottomItems = <Widget>[HomePage(),SettingsPage(),AddingPage()];



  @override
  Widget build(BuildContext context) {
    int? itemCount = Provider.of<MainSettingsProvider>(context).getMenuListener();
    if (itemCount == 0) {
      index = 0;
      Timer(const Duration(seconds: 1), () {
        Provider.of<MainSettingsProvider>(context,listen:false).changeMenuIndex(1);
      });
    }
    //var provider = Provider.of<MainSettingsProvider>(context, listen: true);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      bottomNavigationBar: GNav(
        selectedIndex: index,
        onTabChange: (x){
          setState(() {
            index = x;
          });
        },
        activeColor: Colors.white,
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        tabMargin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: bottomNav,
        color: Colors.black,
        gap: 3,
        tabs: const [
          GButton(icon: Icons.home,text: "Asosiy",),
          GButton(icon: Icons.settings,text: "Sozlamalar",),
          GButton(icon: Icons.add_circle_outline,iconColor: Colors.orange,),
        ],

      ),
      body:bottomItems[index]
    );
  }
}
