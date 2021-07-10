import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Fashion extends StatefulWidget {
  @override
  _FashionState createState() => _FashionState();
}

class _FashionState extends State<Fashion> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width*1,
          height: MediaQuery.of(context).size.height*1,
          child: Column(
            children: [


              Container(
                margin: EdgeInsets.only(top: 8),
                height: MediaQuery.of(context).size.height*0.28,
                width: MediaQuery.of(context).size.width*0.95,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.redAccent,
                    boxShadow: [BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0,1),
                        blurRadius: 2
                    )]
                ),

              ),

              Container(
                height: 50,
                width: MediaQuery.of(context).size.width*1,
                color: Colors.white,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.redAccent,
                              boxShadow: [BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0,1),
                                blurRadius: 2
                              )]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Jeans",style: TextStyle(color: Colors.white)),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.green,
                                boxShadow: [BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0,1),
                                    blurRadius: 2
                                )]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("T-Shirts",style: TextStyle(color: Colors.white)),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                boxShadow: [BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0,1),
                                    blurRadius: 2
                                )]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Hoody",style: TextStyle(color: Colors.white)),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.amber,
                                boxShadow: [BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0,1),
                                    blurRadius: 2
                                )]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Hoody",style: TextStyle(color: Colors.white)),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.pink,
                                boxShadow: [BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0,1),
                                    blurRadius: 2
                                )]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Hoody",style: TextStyle(color: Colors.white)),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.purpleAccent,
                                boxShadow: [BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0,1),
                                    blurRadius: 2
                                )]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Hoody",style: TextStyle(color: Colors.white),),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                boxShadow: [BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0,1),
                                    blurRadius: 2
                                )]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Hoody",style: TextStyle(color: Colors.white)),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(

                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                                boxShadow: [BoxShadow(
                                    color: Colors.grey,
                                    offset: Offset(0,1),
                                    blurRadius: 2
                                )]
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Hoody",style: TextStyle(color: Colors.white)),
                            )),
                      ),
                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
