import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OrderNow extends StatefulWidget {
  String? Name;
  String? Quantity;
  String ?Image;
  String? Total;
  String ?size;


  OrderNow({@required this.Name, this.Quantity,this.size,this.Total,this.Image});
  @override
  State<OrderNow> createState() => _OrderNowState(Name, Quantity);
}

class _OrderNowState extends State<OrderNow> {
  String? postid;
  String? Section;
  TextEditingController? Name;
  TextEditingController? Actualprice;
  TextEditingController? Email;
  TextEditingController? PhoneNumber;
  TextEditingController? Brand;
  TextEditingController? Model;
  TextEditingController? Stocks;
  TextEditingController? Sizeone;
  TextEditingController? SizeTwo;
  TextEditingController? SizeThree;
  TextEditingController? SizeFour;
  TextEditingController? SizeFive;
  TextEditingController? SizeSix;
  _OrderNowState(this.postid, this.Section);

  @override
  void initState() {
    super.initState();
    Name = TextEditingController();
    Actualprice = TextEditingController();
    Email = TextEditingController();
    PhoneNumber = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.grey),
                            color: Colors.white),
                        maxLength: 25,
                        controller: Name,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.blue,
                        placeholder: 'Name',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.grey),
                            color: Colors.white),
                        maxLength: 25,
                        controller:Email,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.blue,
                        placeholder: 'Email Address',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.grey),
                            color: Colors.white),
                        maxLength: 25,
                        controller: PhoneNumber,
                        style: TextStyle(color: Colors.black),
                        cursorColor: Colors.blue,
                        placeholder: 'Phone Number',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),


                  ElevatedButton(
                              onPressed: () {

                              },
                              child: Text("Submit")),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
