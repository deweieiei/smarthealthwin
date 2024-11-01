import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:smarthealthwin/telemadwin/provider/provider.dart';
import 'package:smarthealthwin/telemadwin/view/widgetUI/backGrund.dart';
import 'package:smarthealthwin/telemadwin/view/widgetUI/boxID.dart';
import 'package:smarthealthwin/telemadwin/view/widgetUI/boxtime.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool shownumpad = false, status = false;

  Future<void> getdatainformation() async {
    Timer.periodic(const Duration(seconds: 2), (t) async {
      var url =
          Uri.parse('${context.read<DataProvider>().platfromURLLocal}/add_hr');
      var response = await http.post(url, body: {});
      var resTojson = json.decode(response.body);

      if (resTojson.statusCode == 200) {
        debugPrint(resTojson);
        t.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(children: [
        const BackGrund(),
        Positioned(
            child: SafeArea(
          child: ListView(children: [
            const BoxTime(),
            SizedBox(
              width: width,
              height: height * 0.7,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.02),
                  SizedBox(
                      width: width * 0.6,
                      child: const Text('กรุณาเสียบบัตรประชาชนหรือกรอกรหัส')),
                  SizedBox(
                      width: width * 0.6,
                      child: const Text('บัตรประชาชน เพื่อทำการเข้าสู่ระบบ')),
                  SizedBox(height: height * 0.02),
                  Container(
                    width: width * 0.7,
                    height: height * 0.07,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 235, 235, 235),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              setState(() {
                                shownumpad = true;
                              });
                            },
                            child: const BoxID()),
                        GestureDetector(
                          onTap: () {
                            if (shownumpad == false) {
                              setState(() {
                                shownumpad = true;
                              });
                            } else {
                              setState(() {
                                shownumpad = false;
                              });
                            }
                          },
                          child: SizedBox(
                            height: width * 0.08,
                            width: width * 0.08,
                            child: SvgPicture.asset(
                              'assets/Frame 9128.svg',
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        shownumpad == true
                            ? Column(
                                children: [
                                  SizedBox(height: height * 0.01),
                                  status == false
                                      ? GestureDetector(
                                          onTap: () {},
                                          child: Container(
                                            color: const Color(0xff00A3FF),
                                            height: 0.05,
                                            width: 0.3,
                                          ))
                                      : SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.05,
                                          child:
                                              const CircularProgressIndicator(),
                                        ),
                                ],
                              )
                            : SizedBox(
                                height: height * 0.3,
                                width: width * 0.5,
                                child: Image.asset('assets/ppasc.png'),
                              )
                      ],
                    ),
                  ),
                ],
              )),
            ),
          ]),
        ))
      ]),
    );
  }
}
