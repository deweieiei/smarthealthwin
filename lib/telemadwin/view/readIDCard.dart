import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealthwin/telemadwin/provider/provider.dart';
import 'package:smarthealthwin/telemadwin/view/widgetUI/backGrund.dart';
import 'package:smarthealthwin/telemadwin/view/widgetUI/boxID.dart';
import 'package:http/http.dart' as http;
import 'package:smarthealthwin/telemadwin/view/widgetUI/boxtime.dart';

class ReadIDCard extends StatefulWidget {
  const ReadIDCard({super.key});

  @override
  State<ReadIDCard> createState() => _ReadIDCardState();
}

class _ReadIDCardState extends State<ReadIDCard> {
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
    TextStyle style = TextStyle(shadows: const [
      Shadow(color: Color(0x80000000), offset: Offset(0, 2), blurRadius: 2)
    ], fontSize: width * 0.035, color: const Color(0xff00A3FF));
    return Scaffold(
      body: Stack(children: [
        const BackGrund(),
        Positioned(
            child: SafeArea(
          child: ListView(children: [
            SizedBox(
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [BoxTime()])),
            SizedBox(
              width: width,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: height * 0.1),
                  SizedBox(
                      width: width * 0.6,
                      child: Center(
                          child: Text('กรุณาเสียบบัตรประชาชน', style: style))),
                  SizedBox(
                      width: width * 0.6,
                      child: Center(
                          child: Text('เพื่อทำการเข้าสู่ระบบ', style: style))),
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
                      ],
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.005),
                        SizedBox(
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
            Center(
              child: ElevatedButton(
                  onPressed: () {
                    context.read<DataProvider>().updateViewHome("information");
                  },
                  child: const Text("Test")),
            )
          ]),
        ))
      ]),
    );
  }
}
