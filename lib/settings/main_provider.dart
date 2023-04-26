import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskinatoruz/settings/settings_provider.dart';

class MainSettingsProvider extends ChangeNotifier{
  int? index;


  int? getMenuListener(){
    return index;
  }
  void changeMenuIndex(int value){
    index = value;
    notifyListeners();
  }
}