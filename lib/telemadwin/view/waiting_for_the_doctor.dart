import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealthwin/telemadwin/provider/provider.dart';

class WaitingForTheDoctor extends StatefulWidget {
  const WaitingForTheDoctor({super.key});

  @override
  State<WaitingForTheDoctor> createState() => _WaitingForTheDoctorState();
}

class _WaitingForTheDoctorState extends State<WaitingForTheDoctor> {
  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = context.read<DataProvider>();
    return ListView(
      children: [
        const Center(
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 0, 139, 130),
          ),
        ),
        Center(
            child: ElevatedButton(
                onPressed: () {
                  dataProvider.updateViewHome("videocall");
                },
                child: const Text("testVideoCall")))
      ],
    );
  }
}
