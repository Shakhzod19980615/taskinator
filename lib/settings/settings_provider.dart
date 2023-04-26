import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier{

  bool? isCompleted;
  SharedPreferences? pref;
  SettingsProvider._();

  static SettingsProvider instance = SettingsProvider._();
  factory SettingsProvider(){
    return instance;
  }

  void initState() async{
    pref = await SharedPreferences.getInstance();
    isCompleted = await pref?.getBool("isCompleted")?? false;
  }

  void changeCompleted(bool value){
    isCompleted =value;
    pref?.setBool("isCompleted", value);
    notifyListeners();
  }

}