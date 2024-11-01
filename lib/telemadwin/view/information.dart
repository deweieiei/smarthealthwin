import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealthwin/telemadwin/provider/provider.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

class _InformationState extends State<Information> {
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = context.read<DataProvider>();
    return Row(
      children: [
        const Text("Information"),
        ElevatedButton(
            onPressed: () {
              dataProvider.updateViewHome("healthrecord");
            },
            child: const Text("test")),
        ElevatedButton(
            onPressed: () {
              dataProvider.updateViewHome("readIDCard");
            },
            child: const Text("readIDCard"))
      ],
    );
  }
}
