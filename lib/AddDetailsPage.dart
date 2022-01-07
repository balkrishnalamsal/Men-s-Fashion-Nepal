import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:menfashionnepal/ProviderFile/Provider_Data.dart';
import 'package:provider/provider.dart';

class AddDetails extends StatefulWidget {
  String? postid;
  String? Section;

  AddDetails({@required this.postid, this.Section});
  @override
  State<AddDetails> createState() => _AddDetailsState(postid, Section);
}

class _AddDetailsState extends State<AddDetails> {
  String? postid;
  String? Section;
  TextEditingController? Name;
  TextEditingController? Actualprice;
  TextEditingController? Discountprice;
  TextEditingController? Rating;
  TextEditingController? Brand;
  TextEditingController? Model;
  TextEditingController? Stocks;
  TextEditingController? Sizeone;
  TextEditingController? SizeTwo;
  TextEditingController? SizeThree;
  TextEditingController? SizeFour;
  TextEditingController? SizeFive;
  TextEditingController? SizeSix;
  _AddDetailsState(this.postid, this.Section);

  @override
  void initState() {
    super.initState();
    Name = TextEditingController();
    Actualprice = TextEditingController();
    Discountprice = TextEditingController();
    Rating = TextEditingController();
    Brand = TextEditingController();
    Model = TextEditingController();
    Stocks = TextEditingController();
    Sizeone = TextEditingController();
    SizeTwo = TextEditingController();
    SizeThree = TextEditingController();
    SizeFour = TextEditingController();
    SizeFive = TextEditingController();
    SizeSix = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
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
                            border: Border.all(width: 0.1, color: Colors.white),
                            color: Colors.black),
                        maxLength: 25,
                        controller: Name,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        placeholder: 'Name',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        style: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.white),
                            color: Colors.black),
                        controller: Discountprice,
                        cursorColor: Colors.white,
                        placeholder: 'Discount Price',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        style: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.white),
                            color: Colors.black),
                        controller: Rating,
                        placeholder: 'Rating',
                        cursorColor: Colors.white,
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        style: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.white),
                            color: Colors.black),
                        controller: Brand,
                        cursorColor: Colors.white,
                        placeholder: 'Brand',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        style: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.white),
                            color: Colors.black),
                        controller: Model,
                        cursorColor: Colors.white,
                        placeholder: 'Model',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        style: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.white),
                            color: Colors.black),
                        controller: Actualprice,
                        cursorColor: Colors.white,
                        placeholder: 'Actual Price',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        style: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.white),
                            color: Colors.black),
                        controller: Sizeone,
                        cursorColor: Colors.white,
                        placeholder: 'Size',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        style: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.white),
                            color: Colors.black),
                        controller: SizeTwo,
                        cursorColor: Colors.white,
                        placeholder: 'Size',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        style: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.white),
                            color: Colors.black),
                        controller: SizeThree,
                        cursorColor: Colors.white,
                        placeholder: 'Size',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        style: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.white),
                            color: Colors.black),
                        controller: SizeFour,
                        cursorColor: Colors.white,
                        placeholder: 'Size',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        style: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.white),
                            color: Colors.black),
                        controller: SizeFive,
                        cursorColor: Colors.white,
                        placeholder: 'Size',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(),
                      child: CupertinoTextField(
                        style: TextStyle(color: Colors.white),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(width: 0.1, color: Colors.white),
                            color: Colors.black),
                        controller: SizeSix,
                        cursorColor: Colors.white,
                        placeholder: 'Size',
                        placeholderStyle: TextStyle(color: Colors.grey),
                      )),

                  ChangeNotifierProvider<Calculation>(
                    create: (_) => Calculation(),
                    builder: (_, context) {
                      return Consumer<Calculation>(
                        builder: (context, todo, child) {
                          return ElevatedButton(
                              onPressed: () {
                                String namee = Name!.text;
                                String actual = Actualprice!.text;
                                String dis = Discountprice!.text;
                                String mod = Model!.text;
                                String bra = Brand!.text;
                                String stoc = Stocks!.text;
                                String sizeone = Sizeone!.text;
                                String sizetwo = SizeTwo!.text;
                                String sizethree = SizeThree!.text;
                                String sizefour = SizeFour!.text;
                                String sizefive = SizeFive!.text;
                                String rating = Rating!.text;
                                String sizesix = SizeSix!.text;
                                Provider.of<Calculation>(context, listen: false)
                                    .UpdateDetails(
                                        postid!,
                                        Section!,
                                        actual,
                                        dis,
                                        namee,
                                        stoc,
                                        bra,
                                        mod,
                                        sizeone,
                                        rating,
                                        sizetwo,
                                        sizethree,
                                        sizesix,
                                        sizefour,
                                        sizefive,
                                        namee.toLowerCase(),);
                              },
                              child: Text("Update"));
                        },
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
