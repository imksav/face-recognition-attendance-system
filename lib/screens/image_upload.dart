import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:io';

// ignore: must_be_immutable
class ImageUpload extends StatefulWidget {
// we need user id to create a image folder for a particular user
  String? userId;
  ImageUpload({Key? key, this.userId}) : super(key: key);

  @override
  State<ImageUpload> createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  //  some initalization code
  File? _image;
  final imagePicker = ImagePicker();
  String? downloadUrl;

  // image picker
  Future imagePickerMethod() async {
// picking the image from gallery
    final pick = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pick != null) {
        _image = File(pick.path);
      } else {
        // showing snackbar with error
        showSnackBar("No File Selected", Duration(milliseconds: 1000));
      }
    });
  }

// showing snackbar for errors
  showSnackBar(String snackText, Duration d) {
    final snackBar = SnackBar(
      content: Text(snackText),
      duration: d,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

// uploading the image, then getting the downloading url and then
// adding that download url to our cloudfirestore

  Future uploadImage() async {
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    final postId = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("${widget.userId}/images")
        .child("post_$postId");
    await ref.putFile(_image!);
    downloadUrl = await ref.getDownloadURL();
    // uploading to cloud firestore
    await firebaseFirestore
        .collection("users")
        .doc(widget.userId)
        .collection("images")
        .add({"downloadUrl": downloadUrl}).whenComplete(() => showSnackBar(
            "Image Uploaded Successfully", const Duration(seconds: 2)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Upload"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: SizedBox(
              height: 500.0,
              width: double.infinity,
              child: Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text("Upload Image"),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    flex: 4,
                    child: Container(
                      width: 350.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.red),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: _image == null
                                  ? const Center(
                                      child: Text("No Image Selected!!!"),
                                    )
                                  : Image.file(_image!),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                imagePickerMethod();
                              },
                              child: const Text("Select image"),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                uploadImage();
                              },
                              child: const Text("Upload image"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
