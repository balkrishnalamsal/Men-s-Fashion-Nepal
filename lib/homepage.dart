import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:menfashionnepal/AddDetailsPage.dart';
import 'package:menfashionnepal/ProviderFile/Provider_Data.dart';
import 'package:menfashionnepal/ViewMorePage.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:menfashionnepal/ViewDetails.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: MultiProvider(
          providers: [
            ChangeNotifierProvider<Calculation>(
              create: (_) => Calculation(),
            ),
          ],
          builder: (context, con) {
            context.read<Calculation>().CartItem();
            return ListView(
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
                              context.read<Calculation>().getImage("PageSlider"
                                  );
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
                      Stack(
                        children: [
                          Positioned(
                            left: MediaQuery.of(context).size.width*0.045,
                            bottom: 27,
                            child: Container(
                              decoration: BoxDecoration(color: Colors.red,shape: BoxShape.circle),
                              child: Consumer<Calculation>(builder: (context,to,child){
                                context.read<Calculation>().CartItem();
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(to.Iteamcount.toString(),style: TextStyle(color: Colors.white,fontSize: 8,fontWeight: FontWeight.bold),),
                                );
                              }),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {});
                              },
                              child: Icon(
                                CupertinoIcons.cart,
                                size: 25,
                                color: Colors.green,
                                semanticLabel: "Menu",
                              ),
                            ),
                          ),



                        ],
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: CupertinoTextField(
                    decoration: BoxDecoration(
                        border: Border.all(width: 0.2, color: Colors.grey),
                        borderRadius: BorderRadius.circular(15)),
                    placeholder: "Search",
                    prefix: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Icon(
                        CupertinoIcons.search,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height*0.3,
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("PageSlider")
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
                        return
                          CarouselSlider.builder(
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                 decoration: BoxDecoration(
                                   image: DecorationImage(
                                     fit: BoxFit.fill,
                                       image: NetworkImage(snapshot.data!.docs[itemIndex]["image"]))
                                 ),
                                ),
                            options:CarouselOptions(
                              autoPlay: true,
                              height: MediaQuery.of(context).size.height*0.3,
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

                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          context.read<Calculation>().getImage("Trends");
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewMore(section: "Trends",)));
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
                ),

                //Trends

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        width: MediaQuery.of(context).size.width,
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Trends")
                              .limit(5)
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
                              return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (_, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          GestureDetector(
                                            onLongPress: (){
                                              Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDetails(postid: snapshot.data!.docs[index]["postid"],Section: "Trends",),));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context).size.height*0.19,
                                              width: MediaQuery.of(context).size.width*0.52,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                  border: Border.all(
                                                      width: 0.2,
                                                      color: Colors.grey),
                                                  image: DecorationImage(
                                                      fit: BoxFit.fill,
                                                      image: NetworkImage(
                                                          snapshot.data!
                                                                      .docs[
                                                                  index]
                                                              ["image"]))),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 5.0),
                                            child: Text(snapshot.data!.docs[index]["name"]),
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    "Rs."+ snapshot.data!.docs[index]["actualprize"],
                                                    style: TextStyle(
                                                        color: Colors.red,fontSize: 15,decoration: TextDecoration.lineThrough),
                                                  ),

                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(
                                                      "Rs."+ snapshot.data!.docs[index]["discountprize"],
                                                      style: TextStyle(
                                                        color: Colors.red,fontSize: 15,),
                                                    ),
                                                  )
                                                ],
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onLongPress: (){
                                                    Provider.of<Calculation>(context,listen: false).OutofStock("Trends", snapshot.data!.docs[index]["postid"]);
                                                  },
                                                  onTap: (){
                                                    Provider.of<Calculation>(context,listen: false).InStocks("Trends", snapshot.data!.docs[index]["postid"]);
                                                  },

                                                  child: Text(snapshot.data!.docs[index]["stocks"],
                                                    style: TextStyle(
                                                      color: Colors.green,fontSize: 11,),
                                                  ),
                                                ),
                                              ),

                                            ],

                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  ViewDetails(Section:"Trends",postid:snapshot.data!.docs[index]["postid"],)));
                                                },
                                                child: Container(
                                                  height: MediaQuery.of(context).size.height*0.04,
                                                  width: MediaQuery.of(context).size.width*0.24,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius.only(
                                                          bottomRight:
                                                              Radius
                                                                  .circular(
                                                                      50),
                                                          topLeft: Radius
                                                              .circular(
                                                                  10),
                                                          bottomLeft: Radius
                                                              .circular(
                                                                  10))),
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets.only(right: 8.0),
                                                      child: Text(
                                                        "View Details",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white,),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: MediaQuery.of(context).size.height*0.04,
                                                width: MediaQuery.of(context).size.width*0.24,
                                                decoration: BoxDecoration(
                                                    color:
                                                        Colors.deepPurple,
                                                    borderRadius: BorderRadius.only(
                                                        topRight: Radius
                                                            .circular(10),
                                                        bottomRight:
                                                            Radius
                                                                .circular(
                                                                    10),
                                                        topLeft: Radius
                                                            .circular(
                                                                50))),
                                                child: Center(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Text(
                                                      "Buy Now",
                                                      style: TextStyle(
                                                          color:
                                                              Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                // NEw
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          context.read<Calculation>().getImage("New");
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
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewMore(section: "New",)));
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
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("New")
                          .limit(5)
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
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onLongPress: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDetails(Section:"New",postid: snapshot.data!.docs[index]["postid"],)));
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context).size.height*0.19,
                                          width: MediaQuery.of(context).size.width*0.52,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 0.2, color: Colors.grey),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(snapshot
                                                      .data!
                                                      .docs[index]["image"]))),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5.0),
                                        child: Text(snapshot.data!.docs[index]["name"]),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                "Rs."+ snapshot.data!.docs[index]["actualprize"],
                                                style: TextStyle(
                                                    color: Colors.red,fontSize: 15,decoration: TextDecoration.lineThrough),
                                              ),

                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "Rs."+ snapshot.data!.docs[index]["discountprize"],
                                                  style: TextStyle(
                                                    color: Colors.red,fontSize: 15,),
                                                ),
                                              )
                                            ],
                                          ),
                                          GestureDetector(
                                            onLongPress: (){
                                              Provider.of<Calculation>(context,listen: false).OutofStock("New", snapshot.data!.docs[index]["postid"]);
                                            },
                                            onTap: (){
                                              Provider.of<Calculation>(context,listen: false).InStocks("New", snapshot.data!.docs[index]["postid"]);
                                            },
                                            child: Text(snapshot.data!.docs[index]["stocks"],
                                              style: TextStyle(
                                                color: Colors.green,fontSize: 11,),
                                            ),
                                          ),

                                        ],

                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                          ViewDetails(Section: "New",postid:snapshot.data!.docs[index]["postid"],)));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context).size.height*0.04,
                                              width: MediaQuery.of(context).size.width*0.24,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.only(
                                                      bottomRight:
                                                      Radius
                                                          .circular(
                                                          50),
                                                      topLeft: Radius
                                                          .circular(
                                                          10),
                                                      bottomLeft: Radius
                                                          .circular(
                                                          10))),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Text(
                                                    "View Details",
                                                    style: TextStyle(
                                                        color: Colors
                                                            .white,),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: MediaQuery.of(context).size.height*0.04,
                                            width: MediaQuery.of(context).size.width*0.24,
                                            decoration: BoxDecoration(
                                                color:
                                                Colors.deepPurple,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius
                                                        .circular(10),
                                                    bottomRight:
                                                    Radius
                                                        .circular(
                                                        10),
                                                    topLeft: Radius
                                                        .circular(
                                                        50))),
                                            child: Align(alignment: Alignment.center,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  "Buy Now",
                                                  style: TextStyle(
                                                      color:
                                                      Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                      },
                    ),
                  ),
                ),

                Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: () {
                              context.read<Calculation>().getImage("All categories");
                            },
                            child: Text(
                              "All categories",
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewMore(section: "All categories",)));
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("All categories")
                          .limit(10)
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                              height: 500,
                              width: 500,
                              child: Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.green,
                                  )));
                        } else {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onLongPress: (){
                                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDetails(Section:"All categories",postid: snapshot.data!.docs[index]["postid"],)));
                                        },
                                        child: Center(
                                          child: Container(
                                            height: MediaQuery.of(context).size.height*0.19,
                                            width: MediaQuery.of(context).size.width*0.52,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                BorderRadius.circular(10),
                                                border: Border.all(
                                                    width: 0.2, color: Colors.grey),
                                                image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(snapshot
                                                        .data!
                                                        .docs[index]["image"]))),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Text(snapshot.data!.docs[index]["name"]),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 2.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Rs."+ snapshot.data!.docs[index]["actualprize"],
                                                  style: TextStyle(
                                                      color: Colors.red,fontSize: 15,decoration: TextDecoration.lineThrough),
                                                ),

                                                Text(
                                                  "Rs."+ snapshot.data!.docs[index]["discountprize"],
                                                  style: TextStyle(
                                                    color: Colors.red,fontSize: 15,),
                                                )
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onLongPress: (){
                                                  Provider.of<Calculation>(context,listen: false).OutofStock("All categories", snapshot.data!.docs[index]["postid"]);
                                                },
                                                onTap: (){
                                                  Provider.of<Calculation>(context,listen: false).InStocks("All categories", snapshot.data!.docs[index]["postid"]);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Text(snapshot.data!.docs[index]["stocks"],
                                                    style: TextStyle(
                                                      color: Colors.green,fontSize: 11,),
                                                  ),
                                                ),
                                              ),
                                            ),

                                          ],

                                        ),
                                      ),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                          ViewDetails(Section: "All categories",postid:snapshot.data!.docs[index]["postid"],)));
                                            },
                                            child: Container(
                                              height: MediaQuery.of(context).size.height*0.04,
                                              width: MediaQuery.of(context).size.width*0.24,
                                              decoration: BoxDecoration(
                                                  color: Colors.red,
                                                  borderRadius: BorderRadius.only(
                                                      bottomRight:
                                                      Radius
                                                          .circular(
                                                          50),
                                                      topLeft: Radius
                                                          .circular(
                                                          10),
                                                      bottomLeft: Radius
                                                          .circular(
                                                          10))),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(right: 8.0),
                                                  child: Text(
                                                    "View Details",
                                                    style: TextStyle(
                                                      color: Colors
                                                          .white,),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: MediaQuery.of(context).size.height*0.04,
                                            width: MediaQuery.of(context).size.width*0.24,
                                            decoration: BoxDecoration(
                                                color:
                                                Colors.deepPurple,
                                                borderRadius: BorderRadius.only(
                                                    topRight: Radius
                                                        .circular(10),
                                                    bottomRight:
                                                    Radius
                                                        .circular(
                                                        10),
                                                    topLeft: Radius
                                                        .circular(
                                                        50))),
                                            child: Align(alignment: Alignment.center,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  "Buy Now",
                                                  style: TextStyle(
                                                      color:
                                                      Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}
