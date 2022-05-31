// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../libraries.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  // getting the user id
  String? userId;

  HomeScreen({Key? key, this.userId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  File? image;
  final randomNumber = Random();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
          iconSize: 28.0,
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.notifications_active)),
          // IconButton(
          //     onPressed: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //           builder: (context) => ImageUpload(
          //                 userId: loggedInUser.uid,
          //               )));
          //     },
          //     icon: const Icon(Icons.photo_camera_outlined)),
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Alert Message"),
                      content: const Text("Do you want to logout?"),
                      backgroundColor: Colors.green,
                      actions: [
                        FlatButton(
                            onPressed: () {
                              logout(context);
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const SigninScreen()));
                            },
                            child: const Text("Yes")),
                        FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No")),
                      ],
                    );
                  });
            },
            icon: const Icon(Icons.logout_rounded),
            iconSize: 28.0,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // physics: ClampingScrollPhysics(),
            _buildHeader(screenheight),
            _buildRecentClasses(screenheight),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentClasses(double screenHeight) {
    List<String> subjects = [
      "INNOVATION MANAGEMENT",
      "BASIC ENTREPRENEURSHIP",
      "ISYS3100 ENTERPRISE SYSTEM",
      "CSC 3810 IT PROJECT I",
      "CSC3639 BIG DATA ANALYSIS",
      "CSC3532 APPLIED PROGRAMMING",
    ];

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20.0, bottom: 20.0),
            child: Text(
              "My Courses",
              style: GoogleFonts.aBeeZee(
                textStyle: Styles.titleTextStyle,
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              // width: MediaQuery.of(context).size.width,
              // height: MediaQuery.of(context).size.height,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: subjects.length,
                  itemBuilder: (BuildContext context, index) {
                    return MyCourses(
                      subject: subjects[index],
                      index: index,
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView _buildHeader(double screenHeight) {
    return SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                )),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(
                  "Hi, ${loggedInUser.firstName}",
                  style: GoogleFonts.aBeeZee(
                    textStyle: Styles.titleTextStyle,
                  ),
                ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(loggedInUser.uid)
                        .collection("images")
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Image.asset(
                          "assets/images/defaultimage.png",
                          height: 100.0,
                          width: 100.0,
                        ));
                      } else {
                        var len = snapshot.data!.size;
                        String url = snapshot.data!.docs[0]['downloadUrl'];
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19.0),
                          ),
                          child: Image.network(
                            url,
                            fit: BoxFit.fill,
                          ),
                        );
                      }
                    })
              ]),
              SizedBox(height: screenHeight * 0.03),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Did you take today's attendance?",
                    style: GoogleFonts.aBeeZee(
                      textStyle: Styles.subTitleTextStyle,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: MyFlatButton(
                            text: Text(
                              "Take Attendance",
                              style: GoogleFonts.aBeeZee(
                                textStyle: Styles.buttonTextStyle,
                              ),
                            ),
                            btnColor: Colors.red,
                            icon: const Icon(Icons.add_task),
                            onPressed: const TakeAttendance()),
                      ),
                      Expanded(
                        child: MyFlatButton(
                            text: Text(
                              "View Attendance",
                              style: GoogleFonts.aBeeZee(
                                textStyle: Styles.buttonTextStyle,
                              ),
                            ),
                            btnColor: Colors.green,
                            icon: const Icon(Icons.add_task),
                            onPressed: const TakeAttendance()),
                      ),
                    ],
                  ),
                ],
              ),
            ])));
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SigninScreen()));
  }
}
