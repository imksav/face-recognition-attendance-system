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
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SigninScreen()),
                                  (route) => false);
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
    // List<String> subjects = [
    //   "INNOVATION MANAGEMENT",
    //   "BASIC ENTREPRENEURSHIP",
    //   "ISYS3100 ENTERPRISE SYSTEM",
    //   "CSC 3810 IT PROJECT I",
    //   "CSC3639 BIG DATA ANALYSIS",
    //   "CSC3532 APPLIED PROGRAMMING",
    // ];

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 30.0, left: 30.0, bottom: 20.0, right: 20.0),
            child: Center(
              child: Text(
                "My Recent Courses",
                style: GoogleFonts.aBeeZee(
                  textStyle: Styles.titleTextStyle,
                  fontSize: 30.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.underline,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          // this is the testing one
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(loggedInUser.uid)
                    .collection("subjects")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: Text("Not enrolled yet."),
                    );
                  } else {
                    List size = snapshot.data!.docs[0]['enrolledSubjects'];
                    // print(size.length);
                    return GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                              maxCrossAxisExtent: 250),
                      itemBuilder: (BuildContext context, index) {
                        return MyCourses(
                          subject: size[index],
                          index: index,
                          userId: loggedInUser.uid,
                        );
                      },
                      itemCount: size.length,
                    );
                  }
                }),
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
              Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  "Hi,",
                  style: GoogleFonts.aBeeZee(
                    textStyle: Styles.titleTextStyle,
                  ),
                ),
                const SizedBox(width: 10.0),
                Text(
                  "${loggedInUser.firstName}",
                  style: GoogleFonts.aBeeZee(
                    textStyle: Styles.titleTextStyle,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 135.0),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(loggedInUser.uid)
                        .collection("images")
                        .orderBy("createdAt", descending: true)
                        .limit(1)
                        .snapshots(),
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: Image.asset(
                          "assets/images/defaultimage.png",
                          height: 25.0,
                          width: 25.0,
                        ));
                      } else {
                        var len = snapshot.data!.size;
                        String url = snapshot.data!.docs[0]['downloadUrl'];
                        print(url);
                        return Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.width * 0.17,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(19.0),
                          ),
                          child: Image.network(
                            url,
                            fit: BoxFit.contain,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlatButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10.0,
                        ),
                        splashColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => TakeAttendance(
                                        subject:
                                            loggedInUser.firstName.toString(),
                                        userId: loggedInUser.uid,
                                      ))));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_task_rounded),
                            Text(
                              "Take Attendance",
                              style: GoogleFonts.aBeeZee(
                                  textStyle: Styles.buttonTextStyle),
                            ),
                          ],
                        ),
                        color: Colors.red,
                      ),
                      FlatButton(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 10.0,
                        ),
                        splashColor: Colors.purple,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => ViewAttendance(
                                        // subject:
                                        //     loggedInUser.firstName.toString(),
                                        userId: loggedInUser.uid,
                                      ))));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_task_rounded),
                            Text(
                              "View Attendance",
                              style: GoogleFonts.aBeeZee(
                                  textStyle: Styles.buttonTextStyle),
                            ),
                          ],
                        ),
                        color: Colors.green,
                      ),
                      //   child: MyFlatButton(
                      //       text: Text(
                      //         "Take Attendance",
                      //         style: GoogleFonts.aBeeZee(
                      //           textStyle: Styles.buttonTextStyle,
                      //         ),
                      //       ),
                      //       btnColor: Colors.red,
                      //       icon: const Icon(Icons.add_task),
                      //       onPressed: () {}),

                      // child: MyFlatButton(
                      //     text: Text(
                      //       "View Attendance",
                      //       style: GoogleFonts.aBeeZee(
                      //         textStyle: Styles.buttonTextStyle,
                      //       ),
                      //     ),
                      //     btnColor: Colors.green,
                      //     icon: const Icon(Icons.view_agenda),
                      //     onPressed: () {}
                    ],
                  ),
                ],
              ),
            ])));
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => SigninScreen()),
        (route) => false);
    // Navigator.of(context).pushReplacement(
    // MaterialPageRoute(builder: (context) => const SigninScreen()));
  }
}
