import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';


class PageSlider with ChangeNotifier{
  File? crop;
  String? value = "False";
  File? cropimage;
  FirebaseStorage storage = FirebaseStorage.instance;
  final picker = ImagePicker();
  String?imageone;
  String? imagetwo;
  String?imagethree;
  String?imagefour;




  Pageslider() async {
     QuerySnapshot resutquery =
    await FirebaseFirestore.instance.collection("PageSlider").get();
    List<DocumentSnapshot> documentsnapshot = resutquery.docs;
    notifyListeners();
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
    if(index=="1"){
      FirebaseFirestore.instance.collection(Section).doc("one").update({
        "one": downloadurl,
      });
      notifyListeners();
    }else if(index=="2"){
      FirebaseFirestore.instance.collection(Section).doc("one").update({
        "two": downloadurl,
      });
      notifyListeners();
    }else if(index=="3"){
      FirebaseFirestore.instance.collection(Section).doc("one").update({
        "three":downloadurl,
      });
      notifyListeners();
    }else if(index=="4"){
      FirebaseFirestore.instance.collection(Section).doc("one").update({
        "four":downloadurl,

      });
      notifyListeners();
    }
  notifyListeners();
  }





}