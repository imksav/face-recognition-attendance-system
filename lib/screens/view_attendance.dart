import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ViewAttendance extends StatefulWidget {
  String? userId;
  ViewAttendance({Key? key, required this.userId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ViewAttendanceState createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  Stream? _usersStream;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View Attendance"),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              // child: Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('attendance')
              .doc(widget.userId)
              .snapshots(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Error");
            }
            if (snapshot.hasData) {
              DocumentSnapshot documents = snapshot.data as DocumentSnapshot;
              print(documents.data());
              Map attendanceData = documents.data() as Map;
              List<dynamic> attlist = attendanceData["date"];
              return ListView.builder(
                  itemCount: attlist.length,
                  itemBuilder: ((context, index) {
                    return ListTile(
                      title: Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.purple,
                              Colors.green,
                              Colors.blue,
                              Colors.amber,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              attlist[index].toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30.0),
                            ),
                          ),
                        ),
                      ),
                    );
                  }));
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
