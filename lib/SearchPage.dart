import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AddDetailsPage.dart';
import 'ProviderFile/Provider_Data.dart';
import 'ViewDetails.dart';
import 'navigation_Page.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController? Name;

  @override
  void initState() {
    Name = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onLongPress: () {
                          context.read<Calculation>().getImage("PageSlider");
                        },
                        child: RichText(
                          softWrap: true,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                                text: "M",
                                style: TextStyle(
                                  color: Colors.deepOrange,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                )),
                            TextSpan(
                                text: "en's ",
                                style: TextStyle(
                                    color: Colors.deepOrange,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "F",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold)),
                            TextSpan(
                                text: "ashion",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold))
                          ]),
                        )),
                  ),
                  Stack(
                    children: [
                      Positioned(
                        left: MediaQuery.of(context).size.width * 0.07,
                        bottom: 27,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red, shape: BoxShape.circle),
                          child: Consumer<Calculation>(
                              builder: (context, to, child) {
                            Provider.of<Calculation>(context, listen: false)
                                .CartItem();
                            return Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                to.Iteamcount.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Navigation_Page(index: 2)));
                          },
                          child: Icon(
                            CupertinoIcons.cart,
                            size: 25,
                            color: Colors.green,
                            semanticLabel: "Menu",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.04,
                width: MediaQuery.of(context).size.width * 0.8,
                child: CupertinoTextField(
                  autofocus: true,
                  decoration: BoxDecoration(
                      border: Border.all(width: 0.2, color: Colors.grey),
                      borderRadius: BorderRadius.circular(15)),
                  placeholder: "Search",
                  prefix: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Icon(
                      CupertinoIcons.search,
                      color: Colors.grey,
                    ),
                  ),
                  onChanged: (value) {
                    context.read<Calculation>().Searchcontroller(Name!.text.toString());
                  },
                  controller: Name,
                ),
              ),
            ),
            Consumer<Calculation>(builder: (context, to, child) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.75,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("All categories")
                      .where("searchname", isGreaterThanOrEqualTo: to.Search!.toLowerCase(),)
                      .limit(8)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Container(
                          height: 500,
                          width: 500,
                          child: Center(
                              child: CircularProgressIndicator(
                            color: Colors.red,
                          )));
                    } else {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onLongPress: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => AddDetails(
                                              postid: snapshot.data!.docs[index]
                                                  ["postid"],
                                              Section: "Trends",
                                            ),
                                          ));
                                    },
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.14,
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          border: Border.all(
                                              width: 0.2, color: Colors.grey),
                                          image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: NetworkImage(snapshot.data!
                                                  .docs[index]["image"]))),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 2.0),
                                    child: Text(
                                        snapshot.data!.docs[index]["name"]),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "Rs." +
                                                  snapshot.data!.docs[index]
                                                      ["actualprize"],
                                              style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15,
                                                  decoration: TextDecoration
                                                      .lineThrough),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child: Text(
                                                "Rs." +
                                                    snapshot.data!.docs[index]
                                                        ["discountprize"],
                                                style: TextStyle(
                                                  color: Colors.red,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        GestureDetector(
                                          onLongPress: () {
                                            Provider.of<Calculation>(context,
                                                    listen: false)
                                                .OutofStock(
                                                    "All categories",
                                                    snapshot.data!.docs[index]
                                                        ["postid"]);
                                          },
                                          onTap: () {
                                            Provider.of<Calculation>(context,
                                                    listen: false)
                                                .InStocks(
                                                    "All categories",
                                                    snapshot.data!.docs[index]
                                                        ["postid"]);
                                          },
                                          child: Text(
                                            snapshot.data!.docs[index]
                                                ["stocks"],
                                            style: TextStyle(
                                              color: Colors.green,
                                              fontSize: 8,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ViewDetails(
                                                        Section:
                                                            "All categories",
                                                        postid: snapshot.data!
                                                                .docs[index]
                                                            ["postid"],
                                                      )));
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.025,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.242,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(50),
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Text(
                                                "View Details",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.025,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.242,
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurple,
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                                topLeft: Radius.circular(50))),
                                        child: Center(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              "Buy Now",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
