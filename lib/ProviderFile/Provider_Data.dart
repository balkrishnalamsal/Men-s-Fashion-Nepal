import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menfashionnepal/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  String? iteamcount;
  String? get Iteamcount=>iteamcount;
  String search="";
  String? get Search=>search;

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool islogin = false;
  bool isloading = false;
  late SharedPreferences preferences;
  late FirebaseAuth currentuser;
  String? loadingbool;

  String ? name;
  String? email;
  String ? photourl;


  GetProfileData()async{
    preferences=await SharedPreferences.getInstance();
    email=  await preferences.getString("email");
    name = await preferences.getString("nickname");
    photourl = await preferences.getString("photourl");
    notifyListeners();
  }

 ClearPreferences()async{
   preferences=await SharedPreferences.getInstance();

   final GoogleSignIn googleSignIn = GoogleSignIn();
   await googleSignIn.signOut().whenComplete(() {
     preferences.clear();
     notifyListeners();
   });
   notifyListeners();


 }


  void isSignin() async {
      islogin = true;
      notifyListeners();

    preferences = await SharedPreferences.getInstance();
    islogin = await googleSignIn.isSignedIn();
    if (islogin) {
      notifyListeners();
    }
  }




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
      "searchname":"",
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

      if(Section!="All categories") {
        FirebaseFirestore.instance.collection("All categories").doc(postid).set(
            {
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
              "searchname":"",
              "stocks": "- In Stocks",
              "rating": "",
              "brand": "",
              "sizesix": "",
              "model": "",
            });
        FirebaseFirestore.instance.collection("All categories").doc(postid)
            .collection("All categories").doc(postid)
            .set({
          "image": downloadurl,
          "postid": postid,
        });
      }


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
      String sizefive,
      String searchname) {
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
      "searchname":searchname,
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

    AdditionalImage(downloadUrl, Section,postid);
  }


  AdditionalImage(String downloadurl,String section,String postid){
    FirebaseFirestore.instance.collection(section).doc(postid).collection(section).doc().set({
      "image":downloadurl,
      "posid":postid,

    });
  }




  AddToCart(String image,String name,String size,String discountrate,int q)async{
    var androidDeviceInfo = await deviceInfo.androidInfo;
    String uiddd = androidDeviceInfo.androidId;
    String id = Uuid().v4();
    int discount = int.parse(discountrate);
    FirebaseFirestore.instance.collection("AddToCart").doc(id).set({
      "image": image,
      "discountprize": discount*q,
      "size": size,
      "name": name,
      "quantity": q,
      "deviceid": uiddd,
      "postid":id
    });
    Fluttertoast.showToast(msg: "Successfully added to cart",textColor: Colors.green);
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


 int Total(int sum){
   print(sum);
   notifyListeners();
    return sum;

  }

  CartIteamNumber()async{
    var deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo =await deviceInfo.androidInfo;
    var uiddd = androidDeviceInfo.androidId;
    final QuerySnapshot resutquery = await FirebaseFirestore.instance
        .collection("AddToCart")
        .where(
      "deviceid",
      isEqualTo: uiddd,
    ).get();

    final List<DocumentSnapshot> baby = resutquery.docs;
    if (baby.length == 0) {
      iteamcount ="0";
      notifyListeners();
    } else {
      iteamcount=baby.length.toString();
   notifyListeners();
    }

  }


  Searchcontroller(String value){
    search=value;
    notifyListeners();
  }






  Future<Null> controlSignIN() async {
    preferences = await SharedPreferences.getInstance();
    GoogleSignInAccount? googleuser = await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
    await googleuser!.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    User? firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (firebaseUser != null) {
      final QuerySnapshot resutquery = await FirebaseFirestore.instance
          .collection("profile")
          .where("userrid", isEqualTo: firebaseUser.uid)
          .get();

      final List<DocumentSnapshot> documentsnapshot = resutquery.docs;

      //Save data to firestore -if new user
      if (documentsnapshot.length == 0) {
        String postid = Uuid().v4();
        FirebaseFirestore.instance
            .collection("profile")
            .doc(firebaseUser.uid)
            .set({
          "nickname": firebaseUser.displayName,
          "photourl": firebaseUser.photoURL,
          "userrid": firebaseUser.uid,
          "email": firebaseUser.email,
          "createdAt": DateTime
              .now()
              .millisecondsSinceEpoch
              .toString(),
          "unique": postid,
        });

        //Write data to local
        currentuser = firebaseAuth;
        await preferences.setString("email", currentuser.currentUser!.email!);
        await preferences.setString("id", currentuser.currentUser!.uid);
        await preferences.setString("unique", postid);
        await preferences.setString(
            "nickname", currentuser.currentUser!.displayName!);
        await preferences.setString(
            "photourl", currentuser.currentUser!.photoURL!);
        notifyListeners();
      } else {
        currentuser = firebaseAuth;
        await preferences.setString("email", documentsnapshot[0]["email"]);
        await preferences.setString("id", documentsnapshot[0]["userrid"]);
        await preferences.setString("unique", documentsnapshot[0]["unique"]);
        await preferences.setString(
            "nickname", documentsnapshot[0]["nickname"]);
        await preferences.setString(
            "photourl", documentsnapshot[0]["photourl"]);
        notifyListeners();
      }
        isloading = false;
        loadingbool="";
        Fluttertoast.showToast(msg: "Login successfully");
        notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "login Failed");
        loadingbool = "";
        notifyListeners();
    }
    notifyListeners();
  }







}
