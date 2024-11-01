import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealthwin/telemadwin/provider/provider.dart';
import 'package:smarthealthwin/telemadwin/view/healthrecord/heightAndWidth.dart';
import 'package:smarthealthwin/telemadwin/view/healthrecord/pulseAndSysAndDia.dart';
import 'package:smarthealthwin/telemadwin/view/healthrecord/spo2.dart';
import 'package:smarthealthwin/telemadwin/view/healthrecord/sum.dart';

class HealthRecord extends StatefulWidget {
  const HealthRecord({super.key});

  @override
  State<HealthRecord> createState() => _HealthRecordState();
}

class _HealthRecordState extends State<HealthRecord> {
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = context.watch<DataProvider>();
    return SizedBox(
      child: dataProvider.viewhealthrecord == "pulseAndSysAndDia"
          ? const PulseAndSysAndDia()
          : dataProvider.viewhealthrecord == "spo2"
              ? const Spo2Healthrecord()
              : dataProvider.viewhealthrecord == "sum"
                  ? const SumHealthrecord()
                  : const HeightAndWidth(),
    );
  }
}
