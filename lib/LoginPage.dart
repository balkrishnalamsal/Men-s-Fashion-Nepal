import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:menfashionnepal/navigation_Page.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Continuewith extends StatefulWidget {
  @override
  State<Continuewith> createState() => _ContinuewithState();
}

class _ContinuewithState extends State<Continuewith> {

  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool islogin = false;
  bool isloading = false;
  late SharedPreferences preferences;
  late FirebaseAuth currentuser;
  String? value;
  void isSignin() async {
    this.setState(() {
      islogin = true;
    });

    preferences = await SharedPreferences.getInstance();
    islogin = await googleSignIn.isSignedIn();
    if (islogin) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Navigation_Page(index: 0)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:   Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    value = "True";
                  });

                  controlSignIN();
                },
                child: Container(
                  margin: EdgeInsets.only(top: 15),
                  height: 50,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    border: Border.all(width:0.2,color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0,1),
                        color: Colors.black,
                        blurRadius:2,
                      )
                    ],),
                  child: Center(
                    child: Text(
                      'Continue with Google',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),

              (value == "True")
                  ? Padding(
                padding: const EdgeInsets.only(top: 20,bottom: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                      backgroundColor: Colors.deepOrangeAccent,
                    ),
                  ),
                ),
              )
                  : Text(""),

            ],
          ),
        ),

    );
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
        } else {
          currentuser = firebaseAuth;
          await preferences.setString("email", documentsnapshot[0]["email"]);
          await preferences.setString("id", documentsnapshot[0]["userrid"]);
          await preferences.setString("unique", documentsnapshot[0]["unique"]);
          await preferences.setString(
              "nickname", documentsnapshot[0]["nickname"]);
          await preferences.setString(
              "photourl", documentsnapshot[0]["photourl"]);
        }

        this.setState(() {
          isloading = false;
          value="";
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Navigation_Page(index: 0)));
        });
      } else {
        Fluttertoast.showToast(msg: "login Failed");
        this.setState(() {
          value = "";
        });
      }
    }


  }


