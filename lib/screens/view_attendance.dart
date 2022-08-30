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
  // final CollectionReference attendance_details =
  //     FirebaseFirestore.instance.collection('attendance');
  final base = FirebaseFirestore.instance.collection("attendance").doc(widget.userId).get()
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userId.toString()),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Icon(Icons.refresh),
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("attendnace").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Text("No data");
          } else {
            return ListView(
              children: [
                Text("Pagal Vaye Mah")

                // getItems(snapshot),
              ],
            );
          }
        },
      ),

      // body: StreamBuilder(
      //     stream: attendance_details.snapshots(),
      //     builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
      //       if (streamSnapshot.hasData) {
      //         return ListView.builder(
      //             itemCount: streamSnapshot.data!.docs.length,
      //             itemBuilder: (context, index) {
      //               final DocumentSnapshot documentSnapshot =
      //                   streamSnapshot.data!.docs[index];
      //               return ListTile(
      //                 title: documentSnapshot.id == widget.userId
      //                     ? Text(documentSnapshot.id.characters.string)
      //                     : null,
      //               );
      //             });
      //       }

      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }),
    );
  }

  getItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data?.docs.map((doc) => Text(snapshot.toString()));
  }
}
