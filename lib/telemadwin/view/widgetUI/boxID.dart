 
 
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealthwin/telemadwin/provider/provider.dart';

// ignore: must_be_immutable
class BoxID extends StatefulWidget {
  const BoxID({super.key,  });
  
  @override
  State<BoxID> createState() => _BoxIDState();
}

class _BoxIDState extends State<BoxID> {
  Timer? timer;
  var id = '';
  @override
  void initState() {
    super.initState();
    id == '';
    start();
  }

  void start() {
    timer = Timer.periodic(const Duration(microseconds: 200), (Timer t) {
      setState(() {
        if (id != context.read<DataProvider>().id) {
         
        }
        id = context.read<DataProvider>().id;
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.05,
      width: width * 0.7,
      decoration: BoxDecoration(boxShadow:const [
        BoxShadow(
            color: Color.fromARGB(255, 170, 170, 170),
            offset: Offset(0, 0),
            blurRadius: 1)
      ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: width * 0.6,
            child: Center(
              child: Text(
                context.read<DataProvider>().id,
                style: TextStyle(
                    color: 
                         
                        Colors.green,
                    fontSize: (MediaQuery.of(context).size.width +
                            MediaQuery.of(context).size.height) *
                        0.012,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}