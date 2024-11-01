import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealthwin/telemadwin/provider/provider.dart';

class Videocall extends StatefulWidget {
  const Videocall({super.key});

  @override
  State<Videocall> createState() => _VideocallState();
}

class _VideocallState extends State<Videocall> {
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = context.read<DataProvider>();
    return ListView(
      children: [
        const Text("Videocall"),
        Center(
          child: ElevatedButton(
              onPressed: () {
                dataProvider.updateViewHome("information");
              },
              child: const Text("Test")),
        )
      ],
    );
  }
}
