import 'package:flutter/material.dart';

class Upload extends StatefulWidget {
  String image;
  Upload({required this.image});
  @override
  _UploadState createState() => _UploadState(image);
}

class _UploadState extends State<Upload> {
  String image;
  _UploadState(this.image);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            child: Text('Hello World'),
          ),
        ),
      ),
    );
  }
}
