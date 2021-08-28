import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menfashionnepal/Man%20fashion%20wear.dart';
import 'package:uuid/uuid.dart';


class UploadImage extends StatefulWidget {
  String postidcoming;
  UploadImage({required this.postidcoming});
  @override
  _UploadImageState createState() => _UploadImageState(postidcoming);
}

class _UploadImageState extends State<UploadImage> {
  String postimage;
  _UploadImageState(this.postimage);

  File ? crop;
  String? value = "False";
  String? imageUrl;
  String? updatepostid;
  File ? cropimage;
  FirebaseStorage storage = FirebaseStorage.instance;
  final picker = ImagePicker();

  getImage() async {
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
        Controluploading();
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
        .child("MainImage")
        .child('$postid')
        .putFile(cropimage!);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    setState(() {
      imageUrl = downloadUrl;
    });
    FirebaseDatabase.instance.reference().child("MensFeshion").child(postimage).update({
      "image": imageUrl,
    }).whenComplete((){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Fashion()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: GestureDetector(
          onTap: getImage,
          child: Container(child: Center(child: Text("Select Image")))),
    );
  }
}
