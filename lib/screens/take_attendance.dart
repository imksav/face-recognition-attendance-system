import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';

import '../libraries.dart';

class TakeAttendance extends StatefulWidget {
  const TakeAttendance({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TakeAttendanceState createState() => _TakeAttendanceState();
}

class _TakeAttendanceState extends State<TakeAttendance> {
  List<String> subjects = [
    "INNOVATION MANAGEMENT",
    "BASIC ENTREPRENEURSHIP",
    "ISYS3100 ENTERPRISE SYSTEM",
    "CSC 3810 IT PROJECT I",
    "CSC3639 BIG DATA ANALYSIS",
    "CSC3532 APPLIED PROGRAMMING",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        elevation: 0.0,
        title: Text(
          "Take Attendance",
          style: GoogleFonts.aBeeZee(
            textStyle: Styles.subTitleTextStyle,
          ),
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(5.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(),
            // color: Colors.green,
          ),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView.separated(
              scrollDirection: Axis.vertical,
              reverse: false,
              itemCount: subjects.length,
              // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
              separatorBuilder: (BuildContext, index) =>
                  const Divider(color: Colors.grey),
              // ignore: non_constant_identifier_names, avoid_types_as_parameter_names
              itemBuilder: (BuildContext, index) {
                return Card(
                  color: Colors.indigo,
                  shadowColor: Colors.purple,
                  elevation: 0.0,
                  // color: Colors.indigo[200],
                  child: ListTile(
                    leading: const CircleAvatar(
                      backgroundImage:
                          AssetImage("assets/images/profile_img.jpg"),
                    ),
                    title: Text(
                      subjects[index],
                      style: Styles.titleTextStyle,
                    ),
                    subtitle: const Text(
                      "Total Classes: 125, Present: 97, Absent: 28",
                      style: Styles.chartLabelsTextStyle,
                    ),
                    isThreeLine: false,
                    trailing: const Icon(Icons.photo_camera,
                        color: Colors.white, size: 30.0),
                  ),
                );
              }),
        ),
      )),
    );
  }
}
