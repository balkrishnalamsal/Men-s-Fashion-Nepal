import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:uuid/uuid.dart';

class Upload extends StatefulWidget {
  String imagecoming;
  Upload({required this.imagecoming});
  @override
  _UploadState createState() => _UploadState(imagecoming);
}

class _UploadState extends State<Upload> {
  String imagecoming;
  _UploadState(this.imagecoming);

  TextEditingController ? squadcontroller;

  File ? crop;
  String ? loactionofimage;
  String ? name;
  String ? value;
  String ? imageUrl;
  File ? cropimage;
  FirebaseStorage storage = FirebaseStorage.instance;

  final picker = ImagePicker();

  getImage()async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      crop = (await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 5, ratioY: 4),
          compressQuality: 50,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarColor: Colors.deepOrangeAccent,
            toolbarTitle: "Crop",
            statusBarColor: Colors.deepOrangeAccent,
          )))!;
      this.setState(() {
         cropimage = crop;
      });
    }
  }

  Controluploading() async {
    if (cropimage == null) {
      value = "False";
      Fluttertoast.showToast(msg: "Please select image ");
    }
    String postid = Uuid().v4();
    var snapshot = await storage
        .ref()
        .child(imagecoming)
        .child('$postid')
        .putFile(cropimage!);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      imageUrl = downloadUrl;
    });
    String post = Uuid().v4();
    FirebaseDatabase.instance
        .reference()
        .child(imagecoming)
        .child(post)
        .set({
      "image": imageUrl,
      "post": post,
      "Time": ServerValue.timestamp,
    }).whenComplete((){

      setState(() {
        value="False";
      });


    });

  }

  @override
  void setState(fn) {
    super.setState(fn);
    squadcontroller = TextEditingController();
  }


  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Container(
        child: ListView(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                imagecoming,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  shadows: <Shadow>[
                    Shadow(
                      offset: Offset(1.0, 1.0),
                      blurRadius: 1.0,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
            ),

        Container(
        padding: EdgeInsets.all(8.0),
          child: CupertinoTextField(
            cursorColor: Colors.grey,
            style: TextStyle(color: Colors.black),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(color: Colors.grey, blurRadius: 1)
                ]),
            maxLines: 5,
            controller: squadcontroller,
            placeholderStyle: TextStyle(color: Colors.grey),
            placeholder: "What's on your mind ?",
          )),
      (crop == null)
          ? CupertinoButton(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  CupertinoIcons.photo,
                  color: Colors.blue,
                ),
              ),
              Center(
                  child: Text(
                    "Photos",
                    style: TextStyle(color: Colors.blue),
                  )),
            ],
          ),
          onPressed: getImage)
          : GestureDetector(
          onTap: () {
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Center(
                    child: Text(
                      "View Image",
                      style: TextStyle(color: Colors.blue),
                    )),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      crop = null;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Center(
                        child: Text(
                          "Discard",
                          style: TextStyle(
                              color: Colors.deepOrangeAccent),
                        )),
                  )),
            ],
          )),
      (value=="True")? Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoActivityIndicator(radius: 10,),
      ):Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
            child: CupertinoButton(
                color: Colors.blue,
                onPressed: () {
                  value = "True";
                  Controluploading();
                },
                child: Text(
                  "POST",
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.white),
                ))),
               )

          ],
        ),
      ),
    );
  }
}
