import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import  'package:google_maps_flutter/google_maps_flutter.dart';

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
  _OrderNowState(this.postid, this.Section);

  @override
  void initState() {
    super.initState();
    Name = TextEditingController();
    Actualprice = TextEditingController();
    Email = TextEditingController();
    PhoneNumber = TextEditingController();
  }


  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.694813680589142, 83.46274527407459),
    zoom: 10.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(27.694813680589142, 83.46274527407459),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _goToTheLake,
          label: Text('To the lake!'),
          icon: Icon(Icons.directions_boat),
        ),
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Column(
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
            ),

            Container(
              height: MediaQuery.of(context).size.height*0.5,
              child: GoogleMap(
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                onLongPress: (latlang){
                    Marker(markerId: MarkerId("your location"),
                      infoWindow: InfoWindow(title: "Your home"),
                      icon: BitmapDescriptor.defaultMarkerWithHue(2),
                      position: LatLng(latlang.latitude, latlang.longitude)

                  );

                },
                markers: {
                },
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),



          ],
        ),
      ),
    );
  }
  Future<void> _goToTheLake() async {
    var status = await Permission.locationAlways.request();
    if (status.isGranted) {

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }}

}
