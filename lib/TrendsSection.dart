import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Upload Image.dart';

class Trends extends StatefulWidget {
  String Trend;
  Trends({required this.Trend});
  @override
  _TrendsState createState() => _TrendsState(Trend);
}

class _TrendsState extends State<Trends> {
  String Trend;
  _TrendsState(this.Trend);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width*1,
          height: MediaQuery.of(context).size.height*1,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                  onLongPress: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Upload(imagecoming:Trend)));
                  },
                  child: Text(
                    Trend,
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
              Container(
                margin: EdgeInsets.all(10),
                height: MediaQuery.of(context).size.height * 0.28,
                width: MediaQuery.of(context).size.width * 0.95,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0, 1),
                          blurRadius: 2)
                    ]),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
