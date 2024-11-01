import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class DataProvider with ChangeNotifier {
  //TelemedData
  String platfromURL = "";
  String idHospital = "";
  String passwordSetting = "";
  String platfromURLopenvidu = "";
  String nameHospital = '';
  String careUnit = '';
  String careUnitId = '';
  //UserData
  Map userinformation = {};
  //HealthRecord
  String temp = '';
  String weight = '';
  String sys = '';
  String dia = '';
  String spo2 = '';
  String pr = '';
  String pul = '';
  String fbs = '';
  String si = '';
  String uric = '';

  set id(String id) {}
  //funtion
  void update() {
    notifyListeners();
  }
}
