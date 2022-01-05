

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ProviderFile/Provider_Data.dart';


class AddToCart extends StatefulWidget {
  @override
  State<AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  var deviceInfo = DeviceInfoPlugin();
  String ? uiddd;




  deviceid()async{
    var androidDeviceInfo =await deviceInfo.androidInfo;
     uiddd = androidDeviceInfo.androidId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(
      child: Container(
        color: Colors.white,
            child: Column(
                children: [

            Padding(
            padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                    onLongPress: () {
                    },
                    child: RichText(
                      softWrap: true,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                            text: "Your",
                            style: TextStyle(
                              color: Colors.deepOrange,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            )),

                        TextSpan(
                            text: " Cart",
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
                    left: MediaQuery.of(context).size.width * 0.07,
                    bottom: 27,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.red, shape: BoxShape.circle),
                      child: Consumer<Calculation>(
                          builder: (context, to, child) {
                            Provider.of<Calculation>(context, listen: false)
                                .CartItem();
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
                    child: GestureDetector(
                      onTap: () {
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

            ]
          )
            ),

                  Container(
                    height: MediaQuery.of(context).size.height*0.8,
                    width: MediaQuery.of(context).size.width,
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("AddToCart").where("deviceid",isEqualTo:uiddd )
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

                          int sum;
                          var data = snapshot.data!.docs;
                          sum = data.fold(0, (previousValue, element){
                            return previousValue + int.parse(element['discountprize'].toString());
                          }
                          );
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height*0.68 ,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (_, index){

                                      return Padding(
                                        padding: const EdgeInsets.only(left: 14.0,bottom: 14),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height*0.15,
                                                    width: MediaQuery.of(context).size.width*0.48,
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
                                                  padding: const EdgeInsets.only(top: 4.0),
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height*0.14,
                                                    width: MediaQuery.of(context).size.width*0.45,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(15.0),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text(snapshot.data!.docs[index]["name"],style: TextStyle(fontWeight: FontWeight.bold),),

                                                            GestureDetector(
                                                              onTap: (){
                                                                String postid=snapshot.data!.docs[index]["postid"];
                                                                FirebaseFirestore.instance.collection("AddToCart").doc(postid).delete().whenComplete(() {
                                                                  context.read<Calculation>().CartItem();
                                                                });

                                                              },
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  boxShadow: [BoxShadow(
                                                                      offset: Offset(0,1),
                                                                      color: Colors.grey,
                                                                      blurRadius: 1)]
                                                                ),
                                                                child: Padding(
                                                                  padding: const EdgeInsets.all(2.0),
                                                                  child: Icon(CupertinoIcons.clear,size: 20,),
                                                                ),
                                                              ),
                                                            )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(top: 10.0),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                                              children: [
                                                                Text("Rs."+snapshot.data!.docs[index]["discountprize"].toString()),

                                                                Text("x"+snapshot.data!.docs[index]["quantity"].toString()),
                                                              ],
                                                            ),
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                              ],
                                            ),




                                          ],
                                        ),
                                      );
                                    }),
                              ),


                              Container(
                                height: MediaQuery.of(context)
                                    .size
                                    .height *
                                    0.05,
                                width: MediaQuery.of(context)
                                    .size
                                    .width,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("Total :",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                      (Text(" Rs "+sum.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),))
                                    ],
                                  ),
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  height: MediaQuery.of(context)
                                      .size
                                      .height *
                                      0.05,
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      0.8,
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
                                        "CHECKOUT",
                                        style: TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                            ],
                          );
                        }
                      },
                    ),
                  ),
                ],
              )
            ),
          )

    );
  }
}
