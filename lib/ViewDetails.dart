import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:menfashionnepal/OrderNowPage.dart';
import 'package:provider/provider.dart';

import 'ProviderFile/Provider_Data.dart';
import 'navigation_Page.dart';

class ViewDetails extends StatefulWidget {
  String? Section;
  String? postid;

  ViewDetails({this.postid, this.Section});
  @override
  State<ViewDetails> createState() => _ViewDetailsState(Section!, postid!);
}

class _ViewDetailsState extends State<ViewDetails> {
  String? color = "Blue";
  String size = "";
  var images;
  String section;
  String postid;

  _ViewDetailsState(this.section, this.postid);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<Calculation>(
            create: (BuildContext context) => Calculation(),
          ),
        ],
        builder: (context, con) {
          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 20, right: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          CupertinoIcons.arrow_left,
                          color: Colors.blue,
                          size: 30,
                        )),
                    Consumer<Calculation>(builder: (context, todo, child) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Navigation_Page(
                                        index: 2,
                                      )));
                        },
                        child: Stack(
                          children: [
                            Positioned(
                              left: MediaQuery.of(context).size.width * 0.08,
                              bottom: 31,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.red, shape: BoxShape.circle),
                                child: Consumer<Calculation>(
                                    builder: (context, to, child) {
                                  context.read<Calculation>().CartIteamNumber();
                                  return Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: Text(
                                      to.Iteamcount.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                CupertinoIcons.cart,
                                color: Colors.green,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onLongPress: () {
                          Provider.of<Calculation>(context, listen: false)
                              .PageSlidergetImage(section, postid);
                        },
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.35,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(section)
                                .doc(postid)
                                .collection(section)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Container(
                                    height: 500,
                                    width: 500,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.red,
                                    )));
                              } else {
                                return CarouselSlider.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (BuildContext context,
                                          int itemIndex, int pageViewIndex) =>
                                      Container(
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            fit: BoxFit.fill,
                                            image: NetworkImage(snapshot.data!
                                                .docs[itemIndex]["image"]))),
                                  ),
                                  options: CarouselOptions(
                                    autoPlay: true,
                                    height: MediaQuery.of(context).size.height *
                                        0.3,
                                    enlargeCenterPage: true,
                                    autoPlayInterval: Duration(seconds: 2),
                                    viewportFraction: 0.9,
                                    enableInfiniteScroll: true,
                                    aspectRatio: 2.0,
                                    initialPage: 0,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.32,
                          width: MediaQuery.of(context).size.width * 0.9,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(section)
                                .where("postid", isEqualTo: postid)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Container(
                                    height: 500,
                                    width: 500,
                                    child: Center(
                                        child: CircularProgressIndicator(
                                      color: Colors.red,
                                    )));
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                            snapshot.data!.docs.first["name"]),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Rs." +
                                                    snapshot.data!.docs
                                                        .first["actualprize"],
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                    decoration: TextDecoration
                                                        .lineThrough),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Rs." +
                                                      snapshot.data!.docs.first[
                                                          "discountprize"],
                                                  style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              snapshot
                                                  .data!.docs.first["stocks"],
                                              style: TextStyle(
                                                color: Colors.green,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),



                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Consumer<Calculation>(
                                              builder: (context, todo, child) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  String stocks = snapshot.data!
                                                      .docs.first["stocks"];
                                                  if (stocks ==
                                                      "- Out of stocks") {
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "This item is out of stocks");
                                                  } else {
                                                    if (size == "") {
                                                      Fluttertoast.showToast(
                                                          msg:
                                                              "Pelease select size");
                                                    } else {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      OrderNow(
                                                                        Name: snapshot
                                                                            .data!
                                                                            .docs
                                                                            .first["name"],
                                                                        size:
                                                                            size,
                                                                        Quantity:
                                                                            todo.Qunatity.toString(),
                                                                        Total: snapshot
                                                                            .data!
                                                                            .docs
                                                                            .first["discountprize"],
                                                                        Image: snapshot
                                                                            .data!
                                                                            .docs
                                                                            .first["image"],
                                                                      )));
                                                    }
                                                  }
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.04,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.28,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(
                                                        "Order Now",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          })
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)),
                height: MediaQuery.of(context).size.height * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
