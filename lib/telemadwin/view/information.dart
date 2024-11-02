import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smarthealthwin/telemadwin/provider/provider.dart';

class Information extends StatefulWidget {
  const Information({super.key});

  @override
  State<Information> createState() => _InformationState();
}

// http://localhost:8189/api/smartcard/read
class _InformationState extends State<Information> {
  // static const String main_host =
  //     "http://localhost:8189"; // Use 'static const' for constant variables
  // static const Map<String, String> urlApi = {
  //   "readcardonly": "/api/smartcard/read-card-only",
  //   "saveasdraft": "/api/hhso-service/save-as-draft",
  //   "confrimsave": "/api/nhso-service/confirm-save",
  // };

  void sendData() {
    // debugPrint('url : ${url_api['readcardonly']}');
    Map<dynamic, dynamic> dataUser =
        context.read<DataProvider>().userinformation;
    debugPrint(dataUser.toString());
    debugPrint(dataUser['pid']);
    List<dynamic> claimTypes = dataUser['claimTypes'];
    debugPrint('$claimTypes');
    //context.read<DataProvider>().userinformation;
  }

  @override
  void initState() {
    super.initState();
    sendData();
  }

  @override
  Widget build(BuildContext context) {
    DataProvider dataProvider = context.read<DataProvider>();
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                  width: width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                          blurRadius: 0.5,
                          color: Color(0xff48B5AA),
                          offset: Offset(0, 3)),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: MediaQuery.of(context).size.height * 0.1,
                              height: MediaQuery.of(context).size.height * 0.1,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      color: Color.fromARGB(255, 188, 188, 188),
                                      offset: Offset(0, 2)),
                                ],
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: "" == ''
                                      ? Container(
                                          color: const Color.fromARGB(
                                              255, 240, 240, 240),
                                          child: Image.asset(
                                              'assets/user (1).png'))
                                      : Image.network(
                                          '{widget.dataidcard[' ']}',
                                          fit: BoxFit.fill,
                                        ))),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "r'first_name']}",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035,
                                    color: const Color(0xff48B5AA),
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.005,
                                ),
                                Text(
                                  "{widget.dataidcard['personal']['public_id']}",
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03,
                                    color: const Color(0xff1B6286),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  )),
            ],
          ),
        ),
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
