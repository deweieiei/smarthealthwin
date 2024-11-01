import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smarthealthwin/telemadwin/provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  DataProvider dataProvider = DataProvider();
  @override
  void initState() {
    debugPrint("โหลดข้อมูลTelemed");
    dataProvider.platfromURL = '';
    dataProvider.idHospital = '';
    dataProvider.passwordSetting = '';
    dataProvider.platfromURLopenvidu = '';
    dataProvider.nameHospital = '';
    dataProvider.careUnit = '';
    dataProvider.careUnitId = '';
    debugPrint(dataProvider.platfromURL);
    debugPrint(dataProvider.idHospital);
    debugPrint(dataProvider.passwordSetting);
    debugPrint(dataProvider.platfromURLopenvidu);
    debugPrint(dataProvider.nameHospital);
    debugPrint(dataProvider.careUnit);
    debugPrint(dataProvider.careUnitId);
    // TODO: implement initState
    super.initState();
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
          const Positioned(
            right: 0,
            child: CircularProgressIndicator(
              color: Color.fromARGB(255, 0, 139, 130),
            ),
          ),
        ],
      ),
    ));
  }
}
