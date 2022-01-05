
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:menfashionnepal/CartPage.dart';
import 'package:menfashionnepal/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'ProviderFile/Provider_Data.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(CupertinoApp(
    color: Colors.blueAccent,
    debugShowCheckedModeBanner: false,
    home: Navigation_Page(index:0,),
  ));
}

class Navigation_Page extends StatefulWidget {

  int index;
  Navigation_Page({required this.index});
  @override
  _Navigation_PageState createState() => _Navigation_PageState(index);
}

class _Navigation_PageState extends State<Navigation_Page> {


  List<Widget> tabItems = [
    Homepage(),
    Center(child: Text("Krishna")),
    AddToCart(),
    Center(child: Text("Krishna")),
  ];

  int selectedindex;

  _Navigation_PageState(this.selectedindex);


  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
      onWillPop: (){

        return showCupertinoModalPopup(
            context: context,
            builder: (BuildContext
            context) =>
                CupertinoActionSheet(
                  title: Text(
                      "Men's Feshion"),
                  actions: [
                    CupertinoActionSheetAction(
                      child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment
                              .center,
                          children: [
                            Padding(
                              padding:
                              const EdgeInsets.all(8.0),
                              child:
                              Column(
                                mainAxisAlignment:
                                MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                      Navigator.pop(context);
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text('Continue Shopping', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        SystemNavigator.pop();
                                      },
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text('Exit App', style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ]),
                      onPressed:
                          () {
                      },
                    )
                  ],
                )).then((value) => value as bool);



      },
      child:MultiProvider(
          providers: [
          ChangeNotifierProvider<Calculation>(
          create: (_) => Calculation(),
    ),
    ],
    builder: (context, con) {
      return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: FlashyTabBar(
          selectedIndex: selectedindex,
          showElevation: true,
          onItemSelected: (index) =>
              setState(() {
                selectedindex = index;
              }),
          items: [
            FlashyTabBarItem(
              icon: Icon(Icons.home),
              title: Text('Homepage'),
            ),
            FlashyTabBarItem(
              icon: Icon(Icons.search,),
              title: Text('Search'),
            ),

            FlashyTabBarItem(
              icon: Icon(CupertinoIcons.cart,),
              title: Text('Cart'),
            ),
            FlashyTabBarItem(
              icon: Icon(CupertinoIcons.heart),
              title: Text('Favourite'),
            ),
          ],
        ),
        body: Container(
          width: MediaQuery
              .of(context)
              .size
              .width * 1,
          height: MediaQuery
              .of(context)
              .size
              .height * 1,
          child: tabItems[selectedindex],


        ),
      );
    }
    ),
    );
  }
}




