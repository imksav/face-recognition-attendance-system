// import 'package:flutter/material.dart';
// import 'dart:convert';

// import 'package:flutter/services.dart';

// // ignore: must_be_immutable
// class ViewAttendance extends StatefulWidget {
//   String? userId;
//   ViewAttendance({Key? key, required this.userId}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _ViewAttendanceState createState() => _ViewAttendanceState();
// }

// class _ViewAttendanceState extends State<ViewAttendance> {
//   List<dynamic> _items = [];

//   // // Fetch content from the json file
//   Future readJson() async {
//     final String response = await rootBundle.loadString(
//         '../attendanceapp/lib/python_code/final/resultDictJson.json');
//     final data = await json.decode(response);
//     print(data);
//     setState(() {
//       _items = data[widget.userId];
//     });
//   }

//   @override
//   void initState() {
//     // super.initState();
//     readJson();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.userId.toString()),
//         actions: [
//           GestureDetector(
//             onTap: () {
//               readJson();
//             },
//             child: Padding(
//               padding: const EdgeInsets.only(right: 20.0),
//               child: Icon(Icons.refresh),
//             ),
//           )
//         ],
//       ),
//       body: Padding(
//           padding: const EdgeInsets.all(25),
//           child: ListView.builder(
//               itemCount: _items.length,
//               itemBuilder: (BuildContext context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Center(
//                         child: Text(
//                           _items[index],
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 30.0,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               })),
//     );
//   }
// }
