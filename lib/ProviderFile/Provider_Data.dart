import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class Calculation with ChangeNotifier {
  File? crop;
  String? value = "False";
  String? imageUrl;
  String? updatepostid;
  File? cropimage;
  FirebaseStorage storage = FirebaseStorage.instance;
  final picker = ImagePicker();
  String ? imageone;
  String ? imagetwo;
  String ? imagethree;
  String ? imagefour;


  getImage(String Section) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      crop = (await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 5, ratioY: 4),
          compressQuality: 50,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Crop",
          )))!;
      cropimage = crop;
      ImageUploading(cropimage!, Section);
    }
  }

  ImageUploading(File image, String Section) async {
    if (image == null) {
      value = "False";
      Fluttertoast.showToast(msg: "Please select image ");
    }
    String postid = Uuid().v4();
    notifyListeners();
    var snapshot =
        await storage.ref().child(Section).child('$postid').putFile(image);
    var downloadUrl = await snapshot.ref.getDownloadURL();

    FirebaseUploading(downloadUrl, Section);
  }



  FirebaseUploading(String downloadurl, String Section) {
    String postid = Uuid().v4();
    FirebaseFirestore.instance.collection(Section).doc(postid).set({
      "image": downloadurl,
      "postid": postid,
    });
  }


  //Page Slider

  Pageslider() async {
    final QuerySnapshot resutquery =
        await FirebaseFirestore.instance.collection("PageSlider").get();
    final List<DocumentSnapshot> documentsnapshot = resutquery.docs;
    if (documentsnapshot.length == 0) {
    } else {
      imageone = documentsnapshot[0]["one"];
      imagetwo = documentsnapshot[0]["two"];
      imagethree = documentsnapshot[0]["three"];
      imagefour = documentsnapshot[0]["four"];
      notifyListeners();

    }
  }

  PageSliderGetImage(String Section,String index) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      crop = (await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatio: CropAspectRatio(ratioX: 5, ratioY: 4),
          compressQuality: 50,
          maxWidth: 700,
          maxHeight: 700,
          compressFormat: ImageCompressFormat.jpg,
          androidUiSettings: AndroidUiSettings(
            toolbarTitle: "Crop",
          )))!;
      cropimage = crop;
      PageSliderImageUploading(cropimage!, Section,index);
    }
  }

  PageSliderImageUploading(File image, String Section,String index) async {
    if (image == null) {
      value = "False";
      Fluttertoast.showToast(msg: "Please select image ");
    }
    String postid = Uuid().v4();
    notifyListeners();
    var snapshot =
    await storage.ref().child(Section).child('$postid').putFile(image);
    var downloadUrl = await snapshot.ref.getDownloadURL();

    PageSliderFirebaseUploading(downloadUrl, Section,index);
  }
  PageSliderFirebaseUploading(String downloadurl, String Section,String index) {
    String postid = Uuid().v4();

    if(index==0){
      FirebaseFirestore.instance.collection(Section).doc(postid).update({
        "one": downloadurl,
      });
    }else if(index==1){

      FirebaseFirestore.instance.collection(Section).doc(postid).update({
        "two": postid,

      });

    }else if(index==2){

      FirebaseFirestore.instance.collection(Section).doc(postid).update({
        "three": downloadurl,

      });
    }else if(index==3){

      FirebaseFirestore.instance.collection(Section).doc(postid).update({
        "four": postid,
      });
    }

  }

}
