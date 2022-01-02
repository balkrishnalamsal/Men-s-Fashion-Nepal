
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:menfashionnepal/CartPage.dart';
import 'package:menfashionnepal/homepage.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CupertinoApp(
    color: Colors.blueAccent,
    debugShowCheckedModeBanner: false,
    home: Navigation_Page(),
  ));
}

class Navigation_Page extends StatefulWidget {
  @override
  _Navigation_PageState createState() => _Navigation_PageState();
}

class _Navigation_PageState extends State<Navigation_Page> {


  int _selectedIndex = 0;

  List<Widget> tabItems = [
    Homepage(),
    Center(child: Text("Mahendra")),
    AddToCart(),
    Center(child: Text("bikash")),
  ];

  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
      onWillPop: (() => SystemNavigator.pop().then((value) => value as bool)),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: FlashyTabBar(
          selectedIndex: _selectedIndex,
          showElevation: true,
          onItemSelected: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: [
            FlashyTabBarItem(
              icon: Icon(Icons.event),
              title: Text('Homepage'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),

            FlashyTabBarItem(
              icon: Icon(CupertinoIcons.cart),
              title: Text('Cart'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.highlight),
              title: Text('Profile'),
            ),
          ],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          child:tabItems[_selectedIndex],


        ),
      ),
    );
  }
}




