import 'dart:math';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderNow extends StatefulWidget {
  String? Name;
  String? Quantity;
  String? Image;
  String? Total;
  String? size;

  OrderNow(
      {@required this.Name, this.Quantity, this.size, this.Total, this.Image});
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
  String value="False";

  _OrderNowState(this.postid, this.Section);

  @override
  void initState() {
    super.initState();
    Name = TextEditingController();
    Actualprice = TextEditingController();
    Email = TextEditingController();
    PhoneNumber = TextEditingController();
     mylocation();
  }

  late GoogleMapController _controller;

  final CameraPosition _initialPosition = CameraPosition(
      zoom: 10, target: LatLng(27.6764004427525, 83.46395981540647));

  late Marker markers = Marker(
      visible: false,
      position: LatLng(27.6764004427525, 83.46395981540647),
      markerId: MarkerId("random"));

  addMarker(cordinate) {
    setState(() {
      markers = Marker(
          icon: BitmapDescriptor.defaultMarker,
          position: cordinate,
          markerId: MarkerId("e"));
    });
  }

  mylocation()async{
    var status = await Permission.location.request();
    if (status.isGranted) {
      setState(() {
        value="True";
      });

    }else{
     setState(() {
       value="True";
     });
    }

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Padding(
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
                    controller: Email,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Select your delivery destination"),
              ),
              (value=="True")? Expanded(
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.5,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  child: GoogleMap(
                    initialCameraPosition: _initialPosition,
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    onMapCreated: (controller) {
                      setState(() {
                        _controller = controller;
                      });
                    },
                    markers: {markers},
                    onTap: (cordinate) {
                      _controller
                          .animateCamera(CameraUpdate.newLatLng(cordinate));
                      addMarker(cordinate);
                    },
                  ),
                ),
              ):Text(""),
              ElevatedButton(onPressed: () {


              }, child: Text("Submit")),
            ],
          ),
        ),
      ),
    );
  }

}