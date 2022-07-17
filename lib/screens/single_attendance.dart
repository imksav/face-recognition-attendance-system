// import 'package:attendanceapp/libraries.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'dart:io';

// // ignore: must_be_immutable
// class TakeAttendance extends StatefulWidget {
// // we need user id to create an image folder for a particular user
//   String? userId;

//   TakeAttendance({Key? key, this.userId})
//       : super(key: key);

//   @override
//   State<TakeAttendance> createState() => _TakeAttendanceState();
// }

// class _TakeAttendanceState extends State<TakeAttendance> {
//   //  some initalization code
//   File? _image;
//   final imagePicker = ImagePicker();
//   String? downloadUrl;
//   // Array? subjects;
//   // String? subject;

//   // image picker
//   Future imagePickerMethod() async {
// // picking the image from gallery
//     final pick = await imagePicker.pickImage(source: ImageSource.camera);

//     setState(() {
//       if (pick != null) {
//         _image = File(pick.path);
//       } else {
//         // showing snackbar with error
//         showSnackBar("No File Selected", const Duration(milliseconds: 1000));
//       }
//     });
//   }

// // showing snackbar for errors
//   showSnackBar(String snackText, Duration d) {
//     final snackBar = SnackBar(
//       content: Text(snackText),
//       duration: d,
//     );
//     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   }

// // uploading the image, then getting the downloading url and then
// // adding that download url to our cloudfirestore

//   Future uploadImage() async {
//     final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
//     final postId = DateTime.now().millisecondsSinceEpoch.toString();
//     Reference ref = FirebaseStorage.instance
//         .ref()
//         .child("${widget.userId}/${widget.subject}")
//         .child("post_$postId");
//     await ref.putFile(_image!);
//     downloadUrl = await ref.getDownloadURL();
//     // subjects = await ref.child(path)
//     // uploading to cloud firestore

//     await firebaseFirestore
//         .collection("users")
//         .doc(widget.userId)
//         .collection("images")
//         .add({"downloadUrl": downloadUrl}).whenComplete(() => showSnackBar(
//             "Image Uploaded Successfully", const Duration(seconds: 2)));

//     // ignore: use_build_context_synchronously
//     Navigator.of(context)
//         .push(MaterialPageRoute(builder: (context) => const BottomNavScreen()));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("Take Attendance"),
//         backgroundColor: Colors.indigo,
//       ),
//       body: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height,
//         child: Center(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(30.0),
//               child: SizedBox(
//                 height: 700.0,
//                 width: double.infinity,
//                 child: Column(
//                   // ignore: prefer_const_literals_to_create_immutables
//                   children: [
//                     Container(
//                         padding: const EdgeInsets.all(20.0),
//                         decoration: BoxDecoration(
//                             color: Colors.purple[600],
//                             borderRadius: BorderRadius.circular(30.0)),
//                         child: Text(
//                           widget.subject,
//                           style: const TextStyle(
//                               color: Colors.white, fontSize: 20.0),
//                         )),
//                     const SizedBox(
//                       height: 10.0,
//                     ),
//                     Expanded(
//                       flex: 4,
//                       child: Container(
//                         width: 350.0,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20.0),
//                           border: Border.all(color: Colors.red),
//                         ),
//                         child: Center(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               const SizedBox(height: 10.0),
//                               Expanded(
//                                 child: _image == null
//                                     ? const Center(
//                                         child: Text("No Image Selected!!!"),
//                                       )
//                                     : Image.file(_image!),
//                               ),
//                               const SizedBox(height: 10.0),
//                               GestureDetector(
//                                 onTap: () => imagePickerMethod(),
//                                 child: Container(
//                                   padding: const EdgeInsets.all(10.0),
//                                   decoration: BoxDecoration(
//                                     color: Colors.amber[900],
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                   child: const Text(
//                                     "Select Image",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 20.0),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 10.0),
//                               GestureDetector(
//                                 onTap: () => uploadImage(),
//                                 child: Container(
//                                   padding: const EdgeInsets.all(10.0),
//                                   decoration: BoxDecoration(
//                                     color: Colors.blue[900],
//                                     borderRadius: BorderRadius.circular(10.0),
//                                   ),
//                                   child: const Text(
//                                     "Upload Image",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 20.0),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 10.0),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
