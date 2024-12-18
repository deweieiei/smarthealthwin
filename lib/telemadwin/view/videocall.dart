import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:smarthealthwin/telemadwin/view/widgetUI/backGrund.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:openvidu_client/openvidu_client.dart';
import 'package:provider/provider.dart';
import 'package:smarthealthwin/telemadwin/provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:smarthealthwin/telemadwin/view/widgetUI/boxtime.dart';
import 'package:smarthealthwin/telemadwin/view/widgetUI/packagevideocall/models/connection.dart';
import 'package:smarthealthwin/telemadwin/view/widgetUI/packagevideocall/utils/logger.dart';
import 'package:smarthealthwin/telemadwin/view/widgetUI/packagevideocall/widgets/config_view.dart';
import 'package:smarthealthwin/telemadwin/view/widgetUI/packagevideocall/widgets/controls.dart';
import 'package:smarthealthwin/telemadwin/view/widgetUI/packagevideocall/widgets/media_stream_view.dart';

class PrePareVideo extends StatefulWidget {
  const PrePareVideo({super.key});

  @override
  State<PrePareVideo> createState() => _PrePareVideoState();
}

class _PrePareVideoState extends State<PrePareVideo> {
  var data;
  var resTojson;
  Timer? _timer;
  String? status;
  late OpenViduClient _openvidu;
  Future<void> get_path_video() async {
    var url =
        Uri.parse('${context.read<DataProvider>().platfromURL}/get_video');
    var res = await http
        .post(url, body: {'public_id': context.read<DataProvider>().id});
    resTojson = json.decode(res.body);
    setState(() {
      data = resTojson['data'];
    });
  }

  @override
  void initState() {
    get_path_video();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return resTojson != null
        ? resTojson['data'][0] == null
            ? Container(
                height: _height * 0.7,
                child: Center(
                  child: RoomPage(
                    userName: ' UserName ',
                    data: data,
                  ),
                ),
              )
            : Container()
        : Scaffold(
            body: Stack(
              children: [
                Positioned(
                    child: Container(
                  height: _height,
                  width: _width,
                  child: SvgPicture.asset(
                    'assets/login.svg',
                    fit: BoxFit.fill,
                  ),
                )),
                Positioned(
                  child: Container(
                    height: _height,
                    width: _width,
                    child: Center(
                      child: Container(
                        height: _height * 0.06,
                        width: _width,
                        child: Center(
                          child: Text(
                            'กำลังเชื่อมต่อวีดีโอ',
                            style: TextStyle(
                              fontSize: _width * 0.05,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff00A3FF),
                              shadows: [
                                Shadow(
                                  color: Colors.grey,
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
  }
}

class RoomPage extends StatefulWidget {
  final String userName;
  var data;
  RoomPage({
    super.key,
    required this.userName,
    this.data,
  });
  @override
  State<RoomPage> createState() => _RoomPageState();
}

class _RoomPageState extends State<RoomPage> {
  Map<String, RemoteParticipant> remoteParticipants = {};
  MediaDeviceInfo? input;
  bool isInside = false;
  late OpenViduClient _openvidu;
  var resTojson;
  var resTojson2;
  String? status;
  LocalParticipant? localParticipant;

  Timer? _timer;

  void initState() {
    //  lop();
    super.initState();
    initOpenVidu();
    _listenSessionEvents();

    _onConnect();
    lop();
  }

  void _listenSessionEvents() {
    _openvidu.on(OpenViduEvent.userJoined, (params) async {
      await _openvidu.subscribeRemoteStream(params["id"]);
    });
    _openvidu.on(OpenViduEvent.userPublished, (params) {
      _openvidu.subscribeRemoteStream(params["id"],
          video: params["videoActive"], audio: params["audioActive"]);
    });

    _openvidu.on(OpenViduEvent.addStream, (params) {
      remoteParticipants = {..._openvidu.participants};
      setState(() {});
    });

    _openvidu.on(OpenViduEvent.removeStream, (params) {
      remoteParticipants = {..._openvidu.participants};
      setState(() {});
    });

    _openvidu.on(OpenViduEvent.publishVideo, (params) {
      remoteParticipants = {..._openvidu.participants};
      setState(() {});
    });
    _openvidu.on(OpenViduEvent.publishAudio, (params) {
      remoteParticipants = {..._openvidu.participants};
      setState(() {});
    });
    _openvidu.on(OpenViduEvent.updatedLocal, (params) {
      localParticipant = params['localParticipant'];
      setState(() {});
    });
    _openvidu.on(OpenViduEvent.reciveMessage, (params) {
      // context.showMessageRecivedDialog(params["data"] ?? '');
    });
    _openvidu.on(OpenViduEvent.userUnpublished, (params) {
      remoteParticipants = {..._openvidu.participants};
      setState(() {});
    });

    _openvidu.on(OpenViduEvent.error, (params) {
      //    context.showErrorDialog(params["error"]);
    });
  }

  Future<void> initOpenVidu() async {
    _openvidu = OpenViduClient('https://pcm-life.com:4443/openvidu');
    localParticipant =
        await _openvidu.startLocalPreview(context, StreamMode.frontCamera);
    setState(() {});
  }

  Future<void> _onConnect() async {
    logger.e("start on Connect");
    dynamic connectstring = widget.data;

    if (true) {
      final connection = Connection.fromJson(connectstring);
      logger.i(connection.token!);
      localParticipant = await _openvidu.publishLocalStream(
          token: connection.token!, userName: widget.userName);
      setState(() {
        isInside = true;
      });
    }
  }

  void _onTapDisconnect() async {
    await _openvidu.disconnect();
    //  nav.pop();
    context.read<DataProvider>().updateViewHome("information");
  }

  Future<void> status_video() async {
    var url = Uri.parse(
        '${context.read<DataProvider>().platfromURL}/get_video_status');
    var res = await http
        .post(url, body: {'public_id': context.read<DataProvider>().id});
    resTojson2 = json.decode(res.body);
    if (resTojson2 != null) {
      status = resTojson2['message'];
      if (status == 'completed' || status == 'finished' || status == 'end') {
        print('คุยเสร็จเเล้ว');
        _timer?.cancel();
        await _openvidu.disconnect();
      } else {
        print('คุยยังไม่เสร็จ');
        print(status);
      }
    }
  }

  void lop() {
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      print('เช็คstatus');
      status_video();
    });
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          const BackGrund(),
          Positioned(
            child: localParticipant == null
                ? Container()
                : !isInside
                    ? Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                            BoxTime(),
                            Container(
                              height: _height * 0.06,
                              width: _width,
                              child: Center(
                                child: Text(
                                  'เตรียมความพร้อม',
                                  style: TextStyle(
                                      fontSize: _width * 0.05,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff48B5AA)),
                                ),
                              ),
                            ),
                            Container(
                                width: _width * 0.9,
                                child: ConfigView(
                                    participant: localParticipant!,
                                    onConnect: _onConnect))
                          ]))
                    : Container(
                        child: Stack(children: [
                          Positioned(
                            child: Container(
                              child: ListView.builder(
                                  itemCount: 1,
                                  //  math.max(0, remoteParticipants.length),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final remote = remoteParticipants.values
                                        .elementAt(index);
                                    return Container(
                                      width: _width,
                                      height: _height,
                                      child: Expanded(
                                        child: MediaStreamView(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          participant: remote,
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                          Positioned(
                            bottom: -10,
                            child: Container(
                              //  color: Color.fromARGB(50, 255, 193, 7),
                              height: _height * 0.07,
                              width: _width,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _onTapDisconnect();
                                    },
                                    child: Container(
                                      child: Image.asset('assets/skrhjk.png'),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      onTap:
                                      showModalBottomSheet(
                                          backgroundColor: Color.fromARGB(
                                              255, 255, 255, 255),
                                          isScrollControlled: true,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.vertical(
                                                      top:
                                                          Radius.circular(10))),
                                          context: context,
                                          builder: (context) => ControlsWidget(
                                              _openvidu, localParticipant!));
                                    },
                                    child: Container(
                                      child: Image.asset('assets/gjdz.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 5,
                            left: 5,
                            child: Container(
                              height: _height * 0.15,
                              width: _width * 0.2,
                              child: MediaStreamView(
                                borderRadius: BorderRadius.circular(5),
                                participant: localParticipant!,
                              ),
                            ),
                          ),
                        ]),
                      ),
          )
        ]),
        bottomNavigationBar: !isInside
            ? Container(
                height: _height * 0.03,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: GestureDetector(
                        onTap: () {
                          _timer?.cancel();

                          setState(() {});
                        },
                        child: Container(
                          height: _height * 0.025,
                          width: _width * 0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: Color.fromARGB(255, 201, 201, 201),
                                  width: _width * 0.002)),
                          child: Center(
                              child: Text(
                            '< ย้อนกลับ',
                            style: TextStyle(
                                fontSize: _width * 0.03,
                                color: Color.fromARGB(255, 201, 201, 201)),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : null,
      ),
    );
  }
}

class ConnectPage extends StatefulWidget {
  ConnectPage({
    super.key,
  });

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final bool _busy = false;
  var data;
  final TextEditingController _textUserNameController = TextEditingController();

  final Dio _dio = Dio();

  _connect(BuildContext ctx) async {
    await Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => RoomPage(
                  userName: _textUserNameController.text,
                  data: data,
                )));
  }

  Future<void> get_path_video() async {
    var url =
        Uri.parse('${context.read<DataProvider>().platfromURL}/get_video');
    var res = await http
        .post(url, body: {'public_id': context.read<DataProvider>().id});
    var resTojson = json.decode(res.body);
    data = resTojson['data'];
    if (data != null) {
      Timer(Duration(seconds: 1), () {
        setState(() {
          _connect(context);
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();

    _textUserNameController.text = 'Participante${Random().nextInt(1000)}';
    get_path_video();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          child: Container(
            width: _width,
            height: _height,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('กำลังโหลด'),
                  Container(
                      width: _width * 0.2,
                      height: _width * 0.2,
                      child: CircularProgressIndicator()),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
