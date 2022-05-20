// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../libraries.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

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
                            },
                            child: const Text("Yes")),
                        FlatButton(
                            onPressed: () {
                              Navigator.of(context).pop();
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Hi, ${loggedInUser.firstName} ${loggedInUser.secondName}",
                  style: GoogleFonts.aBeeZee(
                    textStyle: Styles.titleTextStyle,
                  ),
                ),
                const CircleAvatar(
                    radius: 40.0,
                    backgroundImage:
                        AssetImage("assets/images/profile_img.jpg"))
              ],
            ),
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
                    MyFlatButton(
                        text: Text(
                          "Take Attendance",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Styles.buttonTextStyle,
                          ),
                        ),
                        btnColor: Colors.red,
                        icon: const Icon(Icons.add_task),
                        onPressed: const TakeAttendance()),
                    MyFlatButton(
                        text: Text(
                          "View Attendance",
                          style: GoogleFonts.aBeeZee(
                            textStyle: Styles.buttonTextStyle,
                          ),
                        ),
                        btnColor: Colors.green,
                        icon: const Icon(Icons.add_task),
                        onPressed: const TakeAttendance()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SigninScreen()));
  }
}
