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
      navigationBar: CupertinoNavigationBar(
        
      ),
      child: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
    );
  }
}
