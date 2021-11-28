import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class ViewDetails extends StatefulWidget {
  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {

  String ? color= "Blue";
  int ? value =01;

  colorchanger(){
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: (color=="Blue")?Colors.blueAccent:(color=="Red")?Colors.red:Colors.green,
    ));
  }


  @override
  Widget build(BuildContext context) {
    colorchanger();
    return Scaffold(
      backgroundColor:(color=="Blue")?Colors.blueAccent:(color=="Red")?Colors.red:Colors.green,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15.0,top: 10,right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(onTap: (){
                    Navigator.pop(context);
                  },
                      child: Icon(CupertinoIcons.arrow_left,color: Colors.white,size: 30,)),
                  GestureDetector(
                      onTap: (){
                      },
                      child: Icon(CupertinoIcons.cart,color: Colors.white,size: 30,))
                ],
              ),
            ),

        Container(
          color: (color=="Blue")?Colors.blueAccent:(color=="Red")?Colors.red:Colors.green,
          height: MediaQuery.of(context).size.height*0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20,bottom: 10),
                child: Text("Office",style: TextStyle(color: Colors.white,fontSize: 25),),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Price",style: TextStyle(color: Colors.white,fontSize: 15),),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Rs.100",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                ],
              )
            ],
          ),
        ),
            Container(
              decoration: BoxDecoration(
                color :Color(0XFFEEF3F7),
                borderRadius: BorderRadius.circular(30)
              ),
              height: MediaQuery.of(context).size.height*0.7,
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0,left: 25),
                    child: Text("Color",style: TextStyle(color: Colors.blue,fontSize: 15),),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              color="Blue";
                            });

                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              height: 30,
                              width: 30,
                           decoration:(color=="Blue")?BoxDecoration(
                                boxShadow: [BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 1,
                                  offset: Offset(
                                    0,1
                                  )
                                )],
                                border: Border.all(
                                  width: 2,color: Colors.white
                                ),
                              shape: BoxShape.circle,
                              color: Colors.white
                              ):BoxDecoration(
                             border: Border.all(width: 2,color: Colors.white),
                             shape: BoxShape.circle,
                           ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                color="Green";
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration:(color=="Green")?BoxDecoration(
                                  boxShadow: [BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 1,
                                      offset: Offset(
                                          0,1
                                      )
                                  )],
                                  border: Border.all(
                                      width: 2,color: Colors.white
                                  ),
                                  shape: BoxShape.circle,
                                  color: Colors.white
                              ):BoxDecoration(
                                border: Border.all(width: 2,color: Colors.white),
                                  shape: BoxShape.circle,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                color="Red";
                              });
                            },
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration:(color=="Red")?BoxDecoration(
                                  boxShadow: [BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 1,
                                      offset: Offset(
                                          0,1
                                      )
                                  )],
                                  border: Border.all(
                                      width: 2,color: Colors.white
                                  ),
                                  shape: BoxShape.circle,
                                  color: Colors.white
                              ):BoxDecoration(
                                border: Border.all(width: 2,color: Colors.white),
                                  shape: BoxShape.circle,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    height: MediaQuery.of(context).size.height
                    *0.2,
                    decoration: BoxDecoration(
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Quantity"),
                  ),

                  Container(
                    height: MediaQuery.of(context).size.height*0.1,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                if(value!>=1){
                                  value=(value!-1);
                                }
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 2,
                                  offset: Offset(0,1)
                                )]
                              ),
                              child: Icon(
                                CupertinoIcons.minus,color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2,  offset: Offset(0,1)
                                )]
                            ),
                            child: Center(child: Text("$value",style: TextStyle(fontSize: 15),)),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                value=(value!+1);
                              });
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2,  offset: Offset(0,1)
                                  )]
                              ),
                              child: Icon(
                                CupertinoIcons.add,color: Colors.black,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )

                ],
              ),
            )
          ],
        ),
      );
  }
}