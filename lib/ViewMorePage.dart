import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AddDetailsPage.dart';
import 'ProviderFile/Provider_Data.dart';
import 'ViewDetails.dart';

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
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
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
                height: MediaQuery.of(context).size.height*0.88,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection(section!)
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
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddDetails(postid: snapshot.data!.docs[index]["postid"],Section: "Trends",),));
                                    },
                                    child: Center(
                                      child: Container(
                                        height: MediaQuery.of(context).size.height*0.135,
                                        width: MediaQuery.of(context).size.width*0.35,
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
                                    child: Text(snapshot.data!.docs[index]["name"]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
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

                                            Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
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
                                            Provider.of<Calculation>(context,listen: false).OutofStock(section!, snapshot.data!.docs[index]["postid"]);
                                          },
                                          onTap: (){
                                            Provider.of<Calculation>(context,listen: false).InStocks(section!, snapshot.data!.docs[index]["postid"]);
                                          },

                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 8.0),
                                            child: Text(snapshot.data!.docs[index]["stocks"],
                                              style: TextStyle(
                                                color: Colors.green,fontSize: 11,),
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
                                                      ViewDetails(Section:section,postid:snapshot.data!.docs[index]["postid"],)));
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context).size.height*0.03,
                                          width: MediaQuery.of(context).size.width*0.23,
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
                                        height: MediaQuery.of(context).size.height*0.03,
                                        width: MediaQuery.of(context).size.width*0.23,
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
      ),
    );
  }
}
