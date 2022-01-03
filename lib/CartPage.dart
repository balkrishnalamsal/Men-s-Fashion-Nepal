import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';


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
    deviceid();
    return Scaffold(
        body: SafeArea(
      child: Container(
            child: Column(
                children: [
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
                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (_, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 14.0,bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Container(
                                          height: MediaQuery.of(context).size.height*0.16,
                                          width: MediaQuery.of(context).size.width*0.5,
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
                                      Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Text(snapshot.data!.docs[index]["name"]),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10.0),
                                            child: Text(snapshot.data!.docs[index]["quantity"].toString()),
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
              )
            ),
          ),

    );
  }
}
