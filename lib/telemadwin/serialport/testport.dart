// import 'dart:ffi' as ffi;
// import 'package:ffi/ffi.dart' as ffi;
// import 'package:flutter_libserialport/flutter_libserialport.dart';

// /// Class to manage serial port listing and checking availability.
// class SerialPortManager {
//   /// Lists the available serial ports on the system.
//   static List<String> getAvailablePorts() {
//     final ports = <String>[];
//     final out = ffi.calloc<ffi.Pointer<ffi.Pointer<sp_port>>>();
//     final result = sp_list_ports(out);

//     if (result != sp_return.SP_OK) {
//       ffi.calloc.free(out);
//       return ports; // Empty list if no ports found.
//     }

//     final array = out.value;
//     var i = 0;
//     while (array[i] != ffi.nullptr) {
//       final portName = sp_get_port_name(array[i]);
//       if (portName != ffi.nullptr) {
//         ports.add(ffi.Utf8.fromUtf8(portName.cast()));
//       }
//       i++;
//     }

//     sp_free_port_list(array);
//     ffi.calloc.free(out);
//     return ports;
//   }

//   /// Displays the available serial ports.
//   static void showAvailablePorts() {
//     final ports = getAvailablePorts();
//     if (ports.isEmpty) {
//       print("No serial ports available.");
//     } else {
//       print("Available Serial Ports:");
//       for (final port in ports) {
//         print("- $port");
//       }
//     }
//   }
// }

// void main() {
//   // Run the function to display available serial ports.
//   SerialPortManager.showAvailablePorts();
// }
