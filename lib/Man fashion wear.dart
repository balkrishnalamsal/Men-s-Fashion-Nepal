import 'dart:io';
import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menfashionnepal/New%20Section.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'Categories.dart';
import 'TrendsSection.dart';
import 'ViewDetails.dart';

class Fashion extends StatefulWidget {
  @override
  _FashionState createState() => _FashionState();
}

class _FashionState extends State<Fashion> {
  File? crop;
  String? value = "False";
  String? imageUrl;
  String? updatepostid;
  File? cropimage;
  String imageloaction = "MensFeshion";
  FirebaseStorage storage = FirebaseStorage.instance;
  String? url;
  SharedPreferences? preferences;
  final picker = ImagePicker();
  late Query imagereference;
  late Query Mensfeshion;
  List<Color> colour = [Colors.red, Colors.blue];

  VValue() {
    reference = FirebaseDatabase.instance.reference().child("Collection");
    imagereference = FirebaseDatabase.instance.reference().child("Trends");
    valuee = FirebaseDatabase.instance.reference().child("Collection");
    Mensfeshion = FirebaseDatabase.instance.reference().child("MensFeshion");
    setState(() {});
  }

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
    String post = Uuid().v4();
    FirebaseDatabase.instance
        .reference()
        .child(imageloaction)
        .child(post)
        .set({"image": imageUrl, "postid": post});
  }

  TextEditingController? Categories;
  late Query reference;
  late DatabaseReference valuee;
  @override
  void initState() {
    Categories = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VValue();
    return WillPopScope(
      onWillPop: (() => SystemNavigator.pop().then((value) => value as bool)),
      child: CupertinoPageScaffold(
        backgroundColor: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              imageloaction = "MensFeshion";
                            });
                            getImage();
                          },
                          child: RichText(
                            softWrap: true,
                            text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                  text: "M",
                                  style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  )),
                              TextSpan(
                                  text: "en's ",
                                  style: TextStyle(
                                      color: Colors.deepOrange,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "F",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: "ashion",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold))
                            ]),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Icon(
                        CupertinoIcons.text_alignleft,
                        size: 25,
                        color: Colors.deepOrangeAccent,
                        semanticLabel: "Menu",
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.43,
                width: MediaQuery.of(context).size.width * 95,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FirebaseAnimatedList(
                    shrinkWrap: true,
                    physics: PageScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    query: Mensfeshion,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map menfeshonimage = snapshot.value;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height:
                                MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 1,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                  menfeshonimage["image"],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Container(
                              width:
                                  MediaQuery.of(context).size.width * 0.95,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ViewDetails()));
                                    },
                                    child: Container(
                                      height: 40,
                                      width: MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.47,
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(0, 1),
                                                blurRadius: 1)
                                          ],
                                          borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(100),
                                              bottomLeft:
                                                  Radius.circular(10),
                                              topLeft:
                                                  Radius.circular(10))),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child: Icon(
                                                CupertinoIcons.info,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Text(
                                              "View Details",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight:
                                                      FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width *
                                            0.47,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0, 1),
                                              blurRadius: 1)
                                        ],
                                        color: Colors.red,
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(100),
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10),
                                        )),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.all(2.0),
                                            child: Icon(
                                              CupertinoIcons.shopping_cart,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "Buy Now",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight:
                                                    FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 10, right: 10),
              //   child: CupertinoTextField(
              //     suffix: Padding(
              //       padding: const EdgeInsets.all(8.0),
              //       child: GestureDetector(
              //         onTap: () {
              //           String postid = Uuid().v4();
              //           FirebaseDatabase.instance
              //               .reference()
              //               .child("Collection")
              //               .child(postid)
              //               .set({
              //             "Value": Categories!.text,
              //             "postid": postid
              //           }).whenComplete(() {
              //             setState(() {
              //               Categories!.clear();
              //             });
              //           });
              //         },
              //         child: Container(
              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(10),
              //                 color: Colors.redAccent,
              //                 boxShadow: [
              //                   BoxShadow(
              //                       color: Colors.grey,
              //                       offset: Offset(0, 1),
              //                       blurRadius: 2)
              //                 ]),
              //             child: Padding(
              //               padding: const EdgeInsets.all(5.0),
              //               child: Text("Add",
              //                   style: TextStyle(color: Colors.white)),
              //             )),
              //       ),
              //     ),
              //     controller: Categories,
              //     placeholder: "Categories",
              //   ),
              // ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              imageloaction = "Trends";
                            });
                            getImage();
                          },
                          child: Text(
                            "Trends",
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
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Trends(
                                        Trend: "Trends",
                                      )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 1),
                                    blurRadius: 2)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(3.0),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Text(
                                  "View more",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),

              //Trends

              Container(
                height: MediaQuery.of(context).size.height * 0.43,
                width: MediaQuery.of(context).size.width * 0.95,
                child: FirebaseAnimatedList(
                    scrollDirection: Axis.horizontal,
                    query: imagereference,
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map images = snapshot.value;

                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * 0.35,
                            width: MediaQuery.of(context).size.width * 0.95,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(images["image"])),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.redAccent,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 1),
                                      blurRadius: 2)
                                ]),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewDetails()));
                                  },
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width *
                                        0.47,
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurple,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0, 1),
                                              blurRadius: 1)
                                        ],
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(100),
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10))),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Icon(
                                              CupertinoIcons.info,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "View Details",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.47,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0, 1),
                                            blurRadius: 1)
                                      ],
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(
                                            CupertinoIcons.shopping_cart,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "Buy Now",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),

              // NEW

              Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              imageloaction = "New";
                            });
                            getImage();
                          },
                          child: Text(
                            "New",
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
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => New(
                                        neww: "New",
                                      )));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0, 1),
                                    blurRadius: 2)
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 1),
                                child: Text(
                                  "View More",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
              Container(
                height: MediaQuery.of(context).size.height * 0.42,
                width: MediaQuery.of(context).size.width * 0.95,
                child: FirebaseAnimatedList(
                    scrollDirection: Axis.horizontal,
                    query: FirebaseDatabase.instance.reference().child("New"),
                    itemBuilder: (BuildContext context, DataSnapshot snapshot,
                        Animation<double> animation, int index) {
                      Map newimages = snapshot.value;

                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.all(10),
                            height: MediaQuery.of(context).size.height * 0.34,
                            width: MediaQuery.of(context).size.width * 0.95,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(newimages["image"])),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.redAccent,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 1),
                                      blurRadius: 2)
                                ]),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.95,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewDetails()));
                                  },
                                  child: Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width *
                                        0.47,
                                    decoration: BoxDecoration(
                                        color: Colors.deepPurple,
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey,
                                              offset: Offset(0, 1),
                                              blurRadius: 1)
                                        ],
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(100),
                                            bottomLeft: Radius.circular(10),
                                            topLeft: Radius.circular(10))),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Icon(
                                              CupertinoIcons.info,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            "View Details",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 40,
                                  width:
                                      MediaQuery.of(context).size.width * 0.47,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0, 1),
                                            blurRadius: 1)
                                      ],
                                      color: Colors.red,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        topRight: Radius.circular(10),
                                        bottomRight: Radius.circular(10),
                                      )),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(
                                            CupertinoIcons.shopping_cart,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          "Buy Now",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Pictures {
  String? name;

  String? image;

  String valuecoming(name, image) {
    return '$image';
  }
}
