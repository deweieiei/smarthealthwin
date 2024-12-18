import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealthwin/telemadwin/provider/provider.dart';

import '../widgetUI/boxRecord.dart';

class PulseAndSysAndDia extends StatefulWidget {
  const PulseAndSysAndDia({super.key});

  @override
  State<PulseAndSysAndDia> createState() => _PulseAndSysAndDiaState();
}

class _PulseAndSysAndDiaState extends State<PulseAndSysAndDia> {
  TextEditingController sysHealthrecord = TextEditingController();
  TextEditingController diaHealthrecord = TextEditingController();
  TextEditingController pulseHealthrecord = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    DataProvider dataProvider = context.read<DataProvider>();
    return SizedBox(
        height: height,
        width: width,
        child: ListView(children: [
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BoxRecord(
                    image: 'assets/jhv.png',
                    texthead: 'SYS',
                    keyvavlue: sysHealthrecord),
                BoxRecord(
                    image: 'assets/jhvkb.png',
                    texthead: 'DIA',
                    keyvavlue: diaHealthrecord),
                BoxRecord(
                    image: 'assets/jhbjk;.png',
                    texthead: 'PULSE',
                    keyvavlue: pulseHealthrecord)
              ],
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            ElevatedButton(
                onPressed: () {
                  dataProvider.updateviewhealthrecord("heightAndWidth");
                },
                child: const Text("ย้อนกลับ")),
            ElevatedButton(
                onPressed: () {
                  dataProvider.updateviewhealthrecord("spo2");
                },
                child: const Text("ถัดไป"))
          ])
        ]));
  }
}
