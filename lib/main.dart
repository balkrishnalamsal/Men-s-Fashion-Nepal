import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:menfashionnepal/Man%20fashion%20wear.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CupertinoApp(
    color: Colors.blueAccent,
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {



  Color mainColor = Color(0XFFEEF3F7);


  SplashScreen(){

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white));

  Future.delayed(Duration(seconds: 3),(){

    Navigator.push(context, MaterialPageRoute(builder: (context)=>Fashion()) );

  });



  }






@override
  void initState() {
  SplashScreen();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      backgroundColor: mainColor,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Center(
                child: Text(
                  "Men's Fashion Wear Nepal",
                  style:
                  TextStyle(color: Colors.black87, fontWeight: FontWeight.bold,fontSize: 20),
                )),

            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(Colors.blue),
                backgroundColor: Colors.deepOrangeAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
