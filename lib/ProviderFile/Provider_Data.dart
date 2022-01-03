import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  String? imageone;
  String? imagetwo;
  String? imagethree;
  String? imagefour;
   int quantity=1;
   int get Qunatity => quantity;
  var deviceInfo = DeviceInfoPlugin();














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
      "actualprize": "",
      "discountprize": "",
      "sizeone": "",
      "sizetwo": "",
      "sizethree": "",
      "sizefour": "",
      "sizefive": "",
      "name": "",
      "stocks": "- In Stocks",
      "rating": "",
      "brand": "",
      "sizesix":"",
      "model": "",
    }).whenComplete(() {
      FirebaseFirestore.instance.collection(Section).doc(postid).collection(Section).doc(postid).set({
        "image": downloadurl,
        "postid": postid,
      });
    });
  }

  UpdateDetails(
      String postid,
      String Section,
      String actualprize,
      String Discountprice,
      String name,
      String stocks,
      String brand,
      String model,
      String sizeone,
      String rating,
      String Sizetwo,
      String Sizethree,
      String sizesix,
      String sizefour,
      String sizefive) {
    FirebaseFirestore.instance.collection(Section).doc(postid).update({
      "actualprize": actualprize,
      "discountprize": Discountprice,
      "sizeone": sizeone,
      "sizetwo": Sizetwo,
      "sizethree": Sizethree,
      "sizefour": sizefour,
      "sizefive": sizefive,
      "sizesix":sizesix,
      "name": name,
      "rating": rating,
      "brand": brand,
      "model": model,
    });
  }


  OutofStock(String section,String postid){
    FirebaseFirestore.instance.collection(section).doc(postid).update({
      "stocks":"- Out of stocks"
    });
  }

  InStocks(String section,String postid){
    FirebaseFirestore.instance.collection(section).doc(postid).update({
      "stocks": "- In Stocks",
    });
  }



  PageSlidergetImage(String Section,String postid) async {
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
      PageSliderImageUploading(cropimage!, Section,postid);
    }
  }

  PageSliderImageUploading(File image, String Section,String postid) async {
    if (image == null) {
      value = "False";
      Fluttertoast.showToast(msg: "Please select image ");
    }
    String id = Uuid().v4();
    notifyListeners();
    var snapshot =
    await storage.ref().child(Section).child('$id').putFile(image);
    var downloadUrl = await snapshot.ref.getDownloadURL();

    UpdateImage(downloadUrl, Section,postid);
  }


  UpdateImage(String downloadurl,String section,String postid){
    FirebaseFirestore.instance.collection(section).doc(postid).collection(section).doc().set({
      "image":downloadurl,
      "posid":postid,

    });
  }




  AddToCart(String image,String name,String size,String discountrate,int q)async{
    var androidDeviceInfo = await deviceInfo.androidInfo;
    String uiddd = androidDeviceInfo.androidId;
    int discount = int.parse(discountrate);
    FirebaseFirestore.instance.collection("AddToCart").doc().set({
      "image": image,
      "discountprize": discount*q,
      "size": size,
      "name": name,
      "quantity": q,
      "deviceid": uiddd,
    });


  }


  Decrement(){
      if (quantity>= 2) {
        quantity = (quantity - 1);
      }
      notifyListeners();
  }

  Increment(){
      quantity = (quantity + 1);
    notifyListeners();
  }






}
