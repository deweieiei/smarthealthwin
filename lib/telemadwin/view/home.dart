import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealthwin/telemadwin/provider/provider.dart';
import 'package:smarthealthwin/telemadwin/view/healthrecord.dart';
import 'package:smarthealthwin/telemadwin/view/information.dart';

import 'package:smarthealthwin/telemadwin/view/readIDCard.dart';
import 'package:smarthealthwin/telemadwin/view/register.dart';
import 'package:smarthealthwin/telemadwin/view/setting.dart';
import 'package:smarthealthwin/telemadwin/view/videocall.dart';
import 'package:smarthealthwin/telemadwin/view/waiting_for_the_doctor.dart';
import 'package:smarthealthwin/telemadwin/view/widgetUI/backGrund.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = context.watch<DataProvider>();
    return Scaffold(
      body: Stack(children: [
        const BackGrund(),
        SizedBox(
            child: dataProvider.viewhome == "healthrecord"
                ? const HealthRecord()
                : dataProvider.viewhome == "information"
                    ? const Information()
                    : dataProvider.viewhome == "register"
                        ? const Register()
                        : dataProvider.viewhome == "setting"
                            ? const Setting()
                            : dataProvider.viewhome == "videocall"
                                ? const Videocall()
                                : dataProvider.viewhome ==
                                        "waiting_for_the_doctor"
                                    ? const WaitingForTheDoctor()
                                    : const ReadIDCard()),
      ]),
    );
  }
}
