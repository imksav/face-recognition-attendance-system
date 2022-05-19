import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyCourses extends StatelessWidget {
  final String subject;
  final int index;
  MyCourses({required this.subject, required this.index});
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
          borderRadius: BorderRadius.all(Radius.circular(29.0)),
          // ignore: unrelated_type_equality_checks
          color: (index % 2 == 0) ? Colors.indigo : Colors.blue,
        ),
        child: Column(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.menu_book_rounded,
              color: Colors.white,
              size: 35.0,
            ),
            Text(
              subject,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
