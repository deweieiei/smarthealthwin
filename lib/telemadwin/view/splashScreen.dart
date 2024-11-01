import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; 
import 'package:smarthealthwin/telemadwin/provider/provider.dart';
import 'package:smarthealthwin/telemadwin/view/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DataProvider dataProvider = DataProvider();
  @override
  void initState() {
  super.initState();   debugPrint("โหลดข้อมูลTelemed");
    dataProvider.platfromURL = '';
    dataProvider.idHospital = '';
    dataProvider.passwordSetting = '';
    dataProvider.platfromURLOpenvidu = '';
    dataProvider.nameHospital = '';
    dataProvider.careUnit = '';
    dataProvider.careUnitId = '';
    debugPrint(dataProvider.platfromURL);
    debugPrint(dataProvider.idHospital);
    debugPrint(dataProvider.passwordSetting);
    debugPrint(dataProvider.platfromURLOpenvidu);
    debugPrint(dataProvider.nameHospital);
    debugPrint(dataProvider.careUnit);
    debugPrint(dataProvider.careUnitId);
 Future.delayed(const Duration(seconds: 1), () {
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const Home()));
    
 });

 
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          Positioned(
              child: SizedBox(
                  width: width,
                  height: height,
                  child: SvgPicture.asset(
                    'assets/splash/backlogo.svg',
                    fit: BoxFit.fill,
                  ))),
          Positioned(
              child: SizedBox(
            width: width,
            height: width,
            child: Center(
              child: SizedBox(
                width: width * 0.8,
                height: width * 0.8,
                child: SvgPicture.asset('assets/splash/logo.svg'),
              ),
            ),
          )),
            Positioned(
            
            child:
            SizedBox(  width: width  ,
                height:height ,
              child:  Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const[ Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                  color: Color.fromARGB(255, 0, 139, 130),
                                ),
                ),],),
            )
             
          ),
        ],
      ),
    ));
  }
}
