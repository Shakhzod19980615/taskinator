import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../colors/colors.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String sURLTelegram = "https://t.me/abdullohibnbahrom";
  String sURLMail = "https://wa.me/447752963000";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bkground,
      appBar: AppBar(
        title: Container(
            alignment: Alignment.centerLeft,
            child: Text("Sozlamalar & Yordam", style: TextStyle(fontSize: 20,color: bottomNav,fontWeight: FontWeight.w500),)),
        elevation: 0,
        backgroundColor: bkground,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                try {
                  "Launch URL: $sURLTelegram";
                  if (!await launchUrl(Uri.parse(sURLTelegram), mode: LaunchMode.externalApplication)) {
                Fluttertoast.showToast(msg: "something wrong");
                }
                } catch (ex) {
                "Could not launch url $ex";
                }
              },
              child: Row(
                children: [
                  Icon(Icons.telegram,color: Colors.blue,size: 30,),
                  Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text("Telegram", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: bottomNav),)),
                ],
              ),
            ),//telegram
            Divider(
              color: Colors.black12,
            ),
            GestureDetector(
              onTap: () async {
                try {
                  "Launch URL: $sURLMail";
                  if (!await launchUrl(Uri.parse(sURLMail), mode: LaunchMode.externalApplication)) {
                    Fluttertoast.showToast(msg: "something wrong");
                  }
                } catch (ex) {
                  "Could not launch url $ex";
                }
              },
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    Image.asset("assets/images/whatsapp_icon.png",height: 30,width: 30,),
                    Container(
                        margin: EdgeInsets.only(left: 10),
                        child: Text("Whatsapp", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: bottomNav),)),
                  ],
                ),
              ),
            ),//email
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15,vertical: 15),
              margin: EdgeInsets.only(top: 25,bottom: 30),
              decoration: BoxDecoration(
                  color: bottomNav,
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: [
                  Container(
                      margin:EdgeInsets.only(right: 10),
                      child: Icon(Icons.settings,color: Colors.white,)),
                  Expanded(child: Text("Tez orada boshqa sozlamalar va moslashtirishlar bo'ladi inShaaAllah", style: TextStyle(fontSize: 14, color: Colors.white),)),


                ],
              ),
            ),//notification

          ],
        ),
      ),
    );
  }
}
