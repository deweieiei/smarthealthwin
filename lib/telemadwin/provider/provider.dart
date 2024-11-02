import 'package:flutter/widgets.dart';

class DataProvider with ChangeNotifier {
  //TelemedData
  String platfromURL = "";
  String idHospital = "";
  String passwordSetting = "";
  String platfromURLOpenvidu = "";
  String platfromURLLocal = "http://localhost:8189/api/smartcard/read";

  String nameHospital = "";
  String careUnit = "";
  String careUnitId = "";
  //UserData
  Map userinformation = {};
  String id = "";
  void updateuserinformation(Map data) {
    userinformation = data;
    id = data["pid"];
    notifyListeners();
  }

  //HealthRecord
  String temp = "";
  String height = "";
  String weight = "";
  String sys = "";
  String dia = "";
  String spo2 = "";
  String pr = "";
  String pul = "";
  String fbs = "";
  String si = "";
  String uric = "";
  //view
  String viewhome = "home";

  void updateViewHome(String nameview) {
    viewhome = nameview;
    notifyListeners();
  }

  String viewhealthrecord = "";
  void updateviewhealthrecord(String nameview) {
    viewhealthrecord = nameview;
    notifyListeners();
  }

  //funtion
  void update() {
    notifyListeners();
  }
}
