// import 'package:flutter/material.dart';
// import 'package:flutter_libserialport/flutter_libserialport.dart';
// import 'package:quick_usb/quick_usb.dart';

// void main() => runApp(MyApp());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   UsbDevice? _port;
//   String _status = "No device connected";
//   String _data = "";

//   @override
//   void initState() {
//     super.initState();
//     _connectToFirstDevice();
//   }

//   Future<void> _connectToFirstDevice() async {
//     List<UsbDevice> devices = await UsbDevice();

//     if (devices.isNotEmpty) {
//       UsbDevice device = devices.first;

//       _port = await device.create();
//       if (_port != null) {
//         bool openResult = await _port!.open();
//         if (openResult) {
//           setState(() {
//             _status = "Connected to ${device.productName}";
//           });

//           // ตั้งค่า Serial Port (Baud rate, Parity, Stop bits)
//           await _port!.setDTR(true);
//           await _port!.setRTS(true);
//           await _port!.setPortParameters(
//             9600, // Baud rate
//             UsbPort.DATABITS_8,
//             UsbPort.STOPBITS_1,
//             UsbPort.PARITY_NONE,
//           );

//           _port!.inputStream?.listen((Uint8List event) {
//             setState(() {
//               _data += String.fromCharCodes(event);
//             });
//           });
//         } else {
//           setState(() {
//             _status = "Failed to open port";
//           });
//         }
//       } else {
//         setState(() {
//           _status = "No port available for ${device.productName}";
//         });
//       }
//     } else {
//       setState(() {
//         _status = "No USB devices found";
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _port?.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('USB Serial Example'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               Text('Status: $_status'),
//               SizedBox(height: 20),
//               Text('Data received: $_data'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
