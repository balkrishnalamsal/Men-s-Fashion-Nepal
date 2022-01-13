import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
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
  TextEditingController? Email;
  TextEditingController? PhoneNumber;
  String value = "False";

  Location location = new Location();
  bool _serviceEnabled=false;




  _OrderNowState(this.postid, this.Section);

  @override
  void initState() {
    super.initState();

    Name = TextEditingController();
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

  mylocation() async {

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          _serviceEnabled = await location.requestService();
          if (!_serviceEnabled) {
            _serviceEnabled = await location.requestService();
            if (!_serviceEnabled) {
              _serviceEnabled = await location.requestService();
              if (!_serviceEnabled) {
                _serviceEnabled = await location.requestService();
                if (!_serviceEnabled) {
                  _serviceEnabled = await location.requestService();
                  if (!_serviceEnabled) {
                    _serviceEnabled = await location.requestService();

        }}}}}
        }
        }
    }


    var status = await Permission.location.request();
    if (status.isGranted) {
      setState(() {
        value = "True";
      });
    } else {
      setState(() {
        value = "True";
      });
    }



  }

  @override
  Widget build(BuildContext context) {
    print("hello");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Order Details'),
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
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.blue,
                    placeholder: 'Phone Number',
                    placeholderStyle: TextStyle(color: Colors.grey),
                  )),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Tap to select your delivery destination"),
              ),
              (value == "True")
                  ? Expanded(
                flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: GoogleMap(
                          initialCameraPosition: _initialPosition,
                          mapType: MapType.normal,
                          myLocationEnabled: true,
                          onMapCreated: (controller) {
                            setState(() {
                              _controller = controller;
                            });
                          },trafficEnabled: true,
                          markers: {markers},
                          onTap: (cordinate) {
                            _controller.animateCamera(
                                CameraUpdate.newLatLng(cordinate));
                            addMarker(cordinate);
                          },
                        ),
                      ),
                    )
                  : Text(""),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    onPressed: () {
                      if(Name!.text.isEmpty){
                        Fluttertoast.showToast(msg:"Please provide your Full name");
                      }else if(Email!.text.isEmpty){
                        Fluttertoast.showToast(msg:"Please provide email address");
                      }else if(PhoneNumber!.text.isEmpty){
                        Fluttertoast.showToast(msg:"Please provide Phone Number");

                      } else
                        {
                          Fluttertoast.showToast(msg:"Your order has been successfully sent");

                        }



                    }, child: Text("Submit your order")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
