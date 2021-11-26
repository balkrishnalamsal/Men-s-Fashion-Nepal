import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ViewDetails extends StatefulWidget {
  @override
  State<ViewDetails> createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {

  String ? color= "Blue";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(CupertinoIcons.arrow_left,color: Colors.white,)
                ],
              ),
            ),

        Container(
          color: Colors.blueAccent,
          height: MediaQuery.of(context).size.height*0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                color :Colors.white,
                borderRadius: BorderRadius.circular(30)
              ),
              height: MediaQuery.of(context).size.height*0.7,
              
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text("Color",style: TextStyle(color: Colors.grey),),
                  ),

                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              color="Blue";
                            });

                          },
                          child: Container(
                            height: 20,
                            width: 20,
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
                            height: 20,
                            width: 20,
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
                            height: 20,
                            width: 20,
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
                  )

                ],
              ),
            )
          ],
        ),
      );
  }
}
