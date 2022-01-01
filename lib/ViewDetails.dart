import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatefulWidget {
  String ? Section;
  String? postid;

  ViewDetails({this.postid,this.Section});
  @override
  State<ViewDetails> createState() => _ViewDetailsState(Section!,postid!);
}

class _ViewDetailsState extends State<ViewDetails> {
  String? color = "Blue";
  int? value =1;
  String ? size;
  var images;
  String section;
  String postid;

  _ViewDetailsState(this.section, this.postid);

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10, right: 15),
            child: Row(
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
                GestureDetector(
                    onTap: () {},
                    child: Icon(
                      CupertinoIcons.cart,
                      color: Colors.blue,
                      size: 30,
                    ))
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
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.6,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(10),
                      ),
                      child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection(section).where("postid",isEqualTo:postid)
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
                                        Container(
                                          height: MediaQuery.of(context).size.height*0.3,
                                          width: MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(10),
                                              border: Border.all(
                                                  width: 0.2, color: Colors.grey),
                                              image: DecorationImage(
                                                  fit: BoxFit.fill,
                                                  image: NetworkImage(snapshot.data!.docs.first["image"]))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 10.0),
                                          child: Text(snapshot.data!.docs.first["name"]),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Rs."+ snapshot.data!.docs.first["actualprize"],
                                                  style: TextStyle(
                                                      color: Colors.red,fontSize: 15,decoration: TextDecoration.lineThrough),
                                                ),

                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Rs."+ snapshot.data!.docs.first["discountprize"],
                                            style: TextStyle(
                                              color: Colors.red,fontSize: 15,),
                                          ),
                                        )
                                              ],
                                            ),

                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(snapshot.data!.docs.first["stocks"],
                                                style: TextStyle(
                                                  color: Colors.green,fontSize: 15,),
                                              ),
                                            ),

                                          ],

                                        ),


                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 10.0,
                                                left: 8,
                                                bottom: 10
                                              ),
                                              child: Text(
                                                "Quantity : $value",
                                                style: TextStyle(color: Colors.deepPurple),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                              const EdgeInsets.only(top: 10.0, left: 5, right: 65),
                                              child: Text(
                                                "Size : $size",
                                                style: TextStyle(color: Colors.deepPurple),
                                              ),
                                            ),
                                          ],
                                        ),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.05,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          if (value! >= 2) {
                                                            value = (value! - 1);
                                                          }
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors.grey,
                                                                  blurRadius: 2,
                                                                  offset: Offset(0, 1))
                                                            ]),
                                                        child: Icon(
                                                          CupertinoIcons.minus,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.circular(10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                                color: Colors.grey,
                                                                blurRadius: 2,
                                                                offset: Offset(0, 1))
                                                          ]),
                                                      child: Center(
                                                          child: Text(
                                                            "$value",
                                                            style: TextStyle(fontSize: 15),
                                                          )),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          value = (value! + 1);
                                                        });
                                                      },
                                                      child: Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors.grey,
                                                                  blurRadius: 2,
                                                                  offset: Offset(0, 1))
                                                            ]),
                                                        child: Icon(
                                                          CupertinoIcons.add,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                           Container(
                                              height: MediaQuery.of(context).size.height * 0.05,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          size = snapshot.data!.docs.first["sizeone"];
                                                        });
                                                      },
                                                      child: (snapshot.data!.docs.first["sizeone"].toString()=="")? Text(""):  Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors.grey,
                                                                  blurRadius: 2,
                                                                  offset: Offset(0, 1))
                                                            ]),
                                                        child: Center(child: Text(snapshot.data!.docs.first["sizeone"])),
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        size =snapshot.data!.docs.first["sizetwo"];
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(5.0),
                                                      child: (snapshot.data!.docs.first["sizetwo"].toString()=="")? Text(""):  Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors.grey,
                                                                  blurRadius: 2,
                                                                  offset: Offset(0, 1))
                                                            ]),
                                                        child: Center(
                                                            child: Text(
                                                              snapshot.data!.docs.first["sizetwo"],
                                                              style: TextStyle(fontSize: 15),
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        setState(() {
                                                          size = snapshot.data!.docs.first["sizethree"];
                                                        });
                                                      },
                                                      child: (snapshot.data!.docs.first["sizethree"].toString()=="")? Text(""):  Container(
                                                        height: 30,
                                                        width: 30,
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(10),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors.grey,
                                                                  blurRadius: 2,
                                                                  offset: Offset(0, 1))
                                                            ]),
                                                        child: Center(child: Text(snapshot.data!.docs.first["sizethree"])),
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start ,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    size = snapshot.data!.docs.first["sizefour"];
                                                  });
                                                },
                                                child: (snapshot.data!.docs.first["sizefour"].toString()=="")? Text(""):  Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            blurRadius: 2,
                                                            offset: Offset(0, 1))
                                                      ]),
                                                  child: Center(child: Text(snapshot.data!.docs.first["sizefour"])),
                                                ),
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  size =  snapshot.data!.docs.first["sizefive"];
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: (snapshot.data!.docs.first["sizefive"].toString()=="")? Text(""):  Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            blurRadius: 2,
                                                            offset: Offset(0, 1))
                                                      ]),
                                                  child: Center(
                                                      child: Text(
                                                        snapshot.data!.docs.first["sizefive"],
                                                        style: TextStyle(fontSize: 15),
                                                      )),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    size = snapshot.data!.docs.first["sizesix"];
                                                  });
                                                },
                                                child: (snapshot.data!.docs.first["sizesix"].toString()=="")? Text(""):  Container(
                                                  height: 30,
                                                  width: 30,
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(10),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey,
                                                            blurRadius: 2,
                                                            offset: Offset(0, 1))
                                                      ]),
                                                  child: Center(child: Text(snapshot.data!.docs.first["sizesix"])),
                                                ),
                                              ),
                                            )
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
                color: Colors.blue, borderRadius: BorderRadius.circular(30)),
            height: MediaQuery.of(context).size.height * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [],
            ),
          )
        ],
      ),
    );
  }
}
