import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:menfashionnepal/inAppbrowser.dart';
import 'package:provider/provider.dart';

import 'AddDetailsPage.dart';
import 'ProviderFile/Provider_Data.dart';

class ViewMore extends StatefulWidget {
  String ? section;
  ViewMore({this.section});
  @override
  State<ViewMore> createState() => _ViewMoreState(section);
}

class _ViewMoreState extends State<ViewMore> {
  String ?section;

  _ViewMoreState(this.section);


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child:ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                section!,
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
              height: MediaQuery.of(context).size.height*0.9,
              width: MediaQuery.of(context).size.width,
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(section!)
                    .limit(50)
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
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        scrollDirection: Axis.vertical,
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDetails(postid: snapshot.data!.docs[index]["postid"],Section: section,),));
                                  },
                                  child: Center(
                                    child: Container(
                                      height: MediaQuery.of(context).size.height*0.140,
                                      width: MediaQuery.of(context).size.width*0.5,
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child:
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.51,

                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Text(snapshot.data!.docs[index]["name"],))),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            r"$"+ snapshot.data!.docs[index]["actualprize"],
                                            style: TextStyle(
                                                color: Colors.red,fontSize: 15,decoration: TextDecoration.lineThrough),
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.only(left: 5.0),
                                            child: Text(
                                              r"$"+ snapshot.data!.docs[index]["discountprize"],
                                              style: TextStyle(
                                                color: Colors.red,fontSize: 15,),
                                            ),
                                          )
                                        ],
                                      ),

                                      GestureDetector(
                                        onLongPress: (){
                                          Provider.of<Calculation>(context,listen: false).OutofStock(section!, snapshot.data!.docs[index]["postid"]);
                                        },
                                        onTap: (){
                                          Provider.of<Calculation>(context,listen: false).InStocks(section!, snapshot.data!.docs[index]["postid"]);
                                        },

                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 8.0),
                                          child:(snapshot.data!.docs[index]["rating"]=="")? Text(
                                            "",
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 11,
                                            ),
                                          ):Row(
                                            children: [
                                              Container(height:20,
                                                width:50,
                                                decoration: BoxDecoration(

                                                    image: DecorationImage(
                                                        fit: BoxFit.fill,
                                                        image:AssetImage("Assets/ratinh.jpg")
                                                    )
                                                ),
                                              ),

                                              Align(
                                                  alignment: Alignment.centerRight,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 2,top:2.0),
                                                    child: Text(snapshot.data!.docs[index]["rating"],style: TextStyle(fontSize: 10),),
                                                  ))
                                            ],
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
                                                    inAppbrowewr(snapshot
                                                        .data!
                                                        .docs[index]["model"])));
                                      },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height*0.025,
                                        width: MediaQuery.of(context).size.width*0.242,
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
                                    GestureDetector(
                                      onTap:(){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                    inAppbrowewr(snapshot
                                                        .data!
                                                        .docs[index]["model"])));
                          },
                                      child: Container(
                                        height: MediaQuery.of(context).size.height*0.025,
                                        width: MediaQuery.of(context).size.width*0.242,
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
    );
  }
}
