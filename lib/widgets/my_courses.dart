import 'package:attendanceapp/libraries.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyCourses extends StatefulWidget {
  final int index;
  String? userId;
  final String subject;
  // ignore: use_key_in_widget_constructors
  MyCourses({required this.subject, required this.index, required this.userId});

  @override
  State<MyCourses> createState() => _MyCoursesState();
}

class _MyCoursesState extends State<MyCourses> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(29.0)),
          // ignore: unrelated_type_equality_checks
          color: (widget.index % 2 == 0) ? Colors.indigo : Colors.blue,
        ),
        child: Column(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                print("${widget.subject.toString()}");
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => TakeAttendance(
                        userId: widget.userId,
                        subject: widget.subject.toString()),
                  ),
                );
              },
              child: Column(
                children: [
                  const Icon(
                    Icons.menu_book_rounded,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  Text(
                    widget.subject,
                    style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
