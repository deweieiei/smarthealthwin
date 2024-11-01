import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BackGrund extends StatefulWidget {
  const BackGrund({super.key});

  @override
  State<BackGrund> createState() => _BackGrundState();
}

class _BackGrundState extends State<BackGrund> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return height > width
        ? Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Column(children: [
              SizedBox(
                  height: height * 0.15,
                  width: width,
                  child: SvgPicture.asset('assets/backgrund/backgrund.svg',
                      fit: BoxFit.fill))
            ]))
        : Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: height * 0.4,
                  width: width,
                  child: SvgPicture.asset(
                    'assets/backgrund/backgrund.svg',
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          );
  }
}
