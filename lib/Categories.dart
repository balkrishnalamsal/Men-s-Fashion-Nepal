import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Upload Image.dart';

class Categori extends StatefulWidget {
  String category;
  Categori({required this.category});
  @override
  _CategoriState createState() => _CategoriState(category);
}

class _CategoriState extends State<Categori> {
  String category;
  _CategoriState(this.category);

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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Upload(imagecoming:category)));
                  },
                  child: Text(
                    category,
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
