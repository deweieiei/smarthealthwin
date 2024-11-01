import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealthwin/telemadwin/provider/provider.dart';

class BoxTime extends StatefulWidget {
  const BoxTime({super.key});

  @override
  State<BoxTime> createState() => _BoxTimeState();
}

class _BoxTimeState extends State<BoxTime> {
  DateTime dateTime = DateTime.parse('0000-00-00 00:00');
  String data = "";
  Timer? timer;
  @override
  void initState() {
    super.initState();
    start();
  }

  void start() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
      setState(() {
        dateTime = DateTime.now();
        data =
            "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
      });
    });
  }

  void stop() {
    setState(() {
      timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    TextStyle style = TextStyle(
        color: const Color.fromARGB(255, 255, 255, 255),
        fontSize: width * 0.03,
        fontWeight: FontWeight.w600);

    return SizedBox(
        height: height * 0.1,
        width: width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  width: width * 0.35,
                  height: height * 0.07,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                          width: width * 0.2,
                          height: height * 0.03,
                          child: Row(
                            children: [
                              Text(data.toString(), style: style),
                            ],
                          )),
                    ],
                  )),
            ],
          ),
        ));
  }
}
