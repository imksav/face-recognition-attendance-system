// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';

// // class ViewAttendance extends StatefulWidget {
// //   String? userId;
// //   // String subject;
// //   ViewAttendance({
// //     Key? key,
// //     this.userId,
// //     // required this.subject,
// //   }) : super(key: key);

// //   @override
// //   State<ViewAttendance> createState() => _ViewAttendanceState();
// // }

// // class _ViewAttendanceState extends State<ViewAttendance> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         appBar: AppBar(
// //           title: Text('View Attendance'),
// //         ),
// //         body: StreamBuilder(
// //             stream: FirebaseFirestore.instance
// //                 .collection('users')
// //                 .doc(widget.userId)
// //                 .collection('attendance')
// //                 .snapshots(),
// //             builder:
// //                 (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
// //               print(snapshot.data.toString());
// //               for (int i = 0; i < snapshot.data!.docs.length; i++) {
// //                 // if (snapshot.data!.docs[i]['subject'] == widget.subject) {
// //                 return ListView.builder(
// //                     itemCount: snapshot.data!.docs[i]['presentDate'].length,
// //                     itemBuilder: (BuildContext context, int index) {
// //                       return Padding(
// //                         padding: const EdgeInsets.all(8.0),
// //                         child: Container(
// //                           decoration: BoxDecoration(
// //                             color: Colors.green,
// //                             borderRadius: BorderRadius.circular(10),
// //                             border: Border.all(
// //                               color: Colors.yellow,
// //                               width: 5,
// //                             ),
// //                           ),
// //                           width: MediaQuery.of(context).size.width * 0.15,
// //                           height: MediaQuery.of(context).size.height * 0.05,
// //                           // color: Colors.green,
// //                           // elevation: 5,
// //                           child: Column(
// //                             children: [
// //                               Center(
// //                                 child: Text(
// //                                   snapshot.data!.docs[i]['presentDate'][index],
// //                                   style: TextStyle(
// //                                     color: Colors.white,
// //                                     fontSize: 20.0,
// //                                     fontWeight: FontWeight.bold,
// //                                   ),
// //                                 ),
// //                               ),
// //                               Text("${widget.userId}"),
// //                             ],
// //                           ),
// //                         ),
// //                       );
// //                       // return ListTile(
// //                       //   title:
// //                       //       Text(snapshot.data!.docs[i]['presentDate'][index]),
// //                       // );
// //                     });
// //                 // }
// //               }

// //               if (snapshot.hasError) {
// //                 return Text('Error: ${snapshot.error}');
// //               }
// //               return Container();
// //               // return snapshot.hasData
// //               //     ? ListView.builder(
// //               //         itemCount: snapshot.data!.docs.length,
// //               //         itemBuilder: (context, index) {
// //               //           DocumentSnapshot documentSnapshot =
// //               //               snapshot.data!.docs[index];
// //               //           List presentDates = documentSnapshot['presentDate'];
// //               //           print(documentSnapshot['presentDate']);
// //               //           print(snapshot.data!.docs.length);
// //               //           print(presentDates.length);
// //               //           for (int i = 0; i < presentDates.length; i++) {
// //               //             print(presentDates[i]);
// //               //           }

// //               //           return Container();
// //               //         },
// //               //       )
// //               //     : CircularProgressIndicator();
// //             }));
// //   }
// // }

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:csv/csv.dart';
// import 'dart:async' show Future;
// import 'package:flutter/services.dart' show rootBundle;

// class ViewAttendance extends StatefulWidget {
//   String? userId;
//   // String subject;
//   ViewAttendance({
//     Key? key,
//     this.userId,
//     // required this.subject,
//   }) : super(key: key);

//   @override
//   State<ViewAttendance> createState() => _ViewAttendanceState();
// }

// class _ViewAttendanceState extends State<ViewAttendance> {
//   // List<List<dynamic>> data = [];

//   // loadAsset() async {
//   //   final myData = await rootBundle
//   //       .loadString("lib/python_code/final/result/attendance.csv");
//   //   print(myData);
//   //   List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
//   //   data = csvTable;
//   //   final userId = widget.userId;
//   //   print(data);
//   //   for (int i = 0; i < data.length; i++) {
//   //     for (int j = 0; j < i; j++) {
//   //       print(data[i][j]);
//   //     }
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.refresh),
//         onPressed: () async {
//           // await loadAsset();
//         },
//       ),
//       floatingActionButtonLocation:
//           FloatingActionButtonLocation.miniCenterFloat,
//       appBar: AppBar(
//         title: Text('View Attendance'),
//       ),
      

//       // body: Table(
//       //     children: data.map((item) {
//       //   return TableRow(
//       //       children: item.map((row) {
//       //     return Padding(
//       //       padding: const EdgeInsets.all(8.0),
//       //       child: Text(row.toString()),
//       //     );
//       //   }).toList());
//       // }).toList()),
//       // body: ListView.builder(
//       //     itemCount: data.length,
//       //     itemBuilder: (BuildContext context, int index) {
//       //       return data[index][0] == widget.userId.toString()
//       //           ? ListTile(
//       //               // title: Text(widget.userId.toString()),
//       //               trailing: Text(
//       //                   "Date: ${data[index][1]} | Time: ${data[index][2]}"),
//       //             )
//       //           : ListTile(
//       //               // title: Text(widget.userId.toString()),
//       //               trailing: Text(
//       //                   "Date: ${data[index][1]} | Time: ${data[index][2]}"),
//       //             );
//       //     }),
//     );
//   }
// }
