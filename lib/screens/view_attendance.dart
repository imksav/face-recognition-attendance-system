import 'package:flutter/material.dart';

class ViewAttendance extends StatefulWidget {
  const ViewAttendance({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ViewAttendanceState createState() => _ViewAttendanceState();
}

class _ViewAttendanceState extends State<ViewAttendance> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("This is attendance view page......."),
    );
  }
}
