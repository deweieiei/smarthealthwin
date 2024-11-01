// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class BoxRecord extends StatefulWidget {
  BoxRecord(
      {super.key,
      required this.keyvavlue,
      this.texthead,
      this.icon,
      this.image});
  TextEditingController keyvavlue;
  dynamic texthead;
  dynamic image;
  Widget? icon;
  @override
  State<BoxRecord> createState() => _BoxRecordState();
}

class _BoxRecordState extends State<BoxRecord> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Color teamcolor = const Color.fromARGB(255, 35, 131, 123);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //  height: _height * 0.1,
        width: width * 0.2,
        color: Colors.white,
        child: Column(
          children: [
            widget.texthead == null
                ? const Text('')
                : Row(
                    children: [
                      widget.image != null
                          ? SizedBox(
                              width: width * 0.05,
                              child: Image.asset(widget.image))
                          : const SizedBox(),
                      Text('${widget.texthead}',
                          style: TextStyle(
                              fontSize: width * 0.03, color: teamcolor)),
                    ],
                  ),
            TextField(
              cursorColor: teamcolor,
              onChanged: (value) {},
              decoration: InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: teamcolor,
                  ),
                ),
              ),
              style: TextStyle(
                color: teamcolor,
                fontSize: height * 0.03,
              ),
              controller: widget.keyvavlue,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
