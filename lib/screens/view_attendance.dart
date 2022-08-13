import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewAttendance extends StatefulWidget {
  String? userId;
  // String subject;
  ViewAttendance({
    Key? key,
    this.userId,
    // required this.subject,
  }) : super(key: key);

  @override
  State<ViewAttendance> createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('View Attendance'),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(widget.userId)
                .collection('attendance')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print(snapshot.data.toString());
              for (int i = 0; i < snapshot.data!.docs.length; i++) {
                // if (snapshot.data!.docs[i]['subject'] == widget.subject) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs[i]['presentDate'].length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.yellow,
                              width: 5,
                            ),
                          ),
                          width: MediaQuery.of(context).size.width * 0.15,
                          height: MediaQuery.of(context).size.height * 0.05,
                          // color: Colors.green,
                          // elevation: 5,
                          child: Center(
                            child: Text(
                              snapshot.data!.docs[i]['presentDate'][index],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                      // return ListTile(
                      //   title:
                      //       Text(snapshot.data!.docs[i]['presentDate'][index]),
                      // );
                    });
                // }
              }

              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Container();
              // return snapshot.hasData
              //     ? ListView.builder(
              //         itemCount: snapshot.data!.docs.length,
              //         itemBuilder: (context, index) {
              //           DocumentSnapshot documentSnapshot =
              //               snapshot.data!.docs[index];
              //           List presentDates = documentSnapshot['presentDate'];
              //           print(documentSnapshot['presentDate']);
              //           print(snapshot.data!.docs.length);
              //           print(presentDates.length);
              //           for (int i = 0; i < presentDates.length; i++) {
              //             print(presentDates[i]);
              //           }

              //           return Container();
              //         },
              //       )
              //     : CircularProgressIndicator();
            }));
  }
}
