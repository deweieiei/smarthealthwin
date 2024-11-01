import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class DataProvider with ChangeNotifier {
  //TelemedData
  String platfromURL = "";
  String idHospital = "";
  String passwordSetting = "";
  String platfromURLOpenvidu = "";
  String platfromURLLocal = "";
  String nameHospital = "";
  String careUnit = "";
  String careUnitId = "";
  //UserData
  Map userinformation = {};String id = "";
  //HealthRecord
  String temp = "";
  String weight = "";
  String sys = "";
  String dia = "";
  String spo2 = "";
  String pr = "";
  String pul = "";
  String fbs = "";
  String si = "";
  String uric = "";
 
  //funtion
  void update() {
    notifyListeners();
  }
}
