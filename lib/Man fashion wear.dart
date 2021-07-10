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
          child: ListView(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Men's Fashion",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 1.0,
                              color: Colors.grey,
                            ),
                          ],

                        ),),
                      ),


                    ],
                  )),

              Container(
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height*0.28,
                width: MediaQuery.of(context).size.width*9,
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
                              child: Text("Hoodies",style: TextStyle(color: Colors.white)),
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
                              child: Text("Jeans Shorts",style: TextStyle(color: Colors.white)),
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
                              child: Text("Blazer",style: TextStyle(color: Colors.white)),
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
                              child: Text("Shoes",style: TextStyle(color: Colors.white),),
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
                              child: Text("Watches",style: TextStyle(color: Colors.white)),
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
                              child: Text("Sun Glasses",style: TextStyle(color: Colors.white)),
                            )),
                      ),
                    ],
                  ),
                ),
              ),

            Align(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Trends",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 1.0,
                            color: Colors.grey,
                          ),
                        ],

                      ),),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            boxShadow: [BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0,1),
                                blurRadius: 2
                            )]
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text("See More",style: TextStyle(color: Colors.deepOrangeAccent,fontWeight: FontWeight.normal,
                            ),),
                          ),
                        ),
                      ),
                    ),


                  ],
                )),

              Container(
                margin: EdgeInsets.all(10),
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
              Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("New",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold,
                          shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.0, 1.0),
                              blurRadius: 1.0,
                              color: Colors.grey,
                            ),
                          ],

                        ),),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              boxShadow: [BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0,1),
                                  blurRadius: 2
                              )]
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Center(
                              child: Text("See More",style: TextStyle(color: Colors.deepOrangeAccent,fontWeight: FontWeight.normal,
                              ),),
                            ),
                          ),
                        ),
                      ),


                    ],
                  )),

              Container(
                margin: EdgeInsets.all(10),
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


            ],
          ),
        ),
      ),
    );
  }
}
