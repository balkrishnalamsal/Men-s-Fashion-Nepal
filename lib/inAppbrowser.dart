import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:menfashionnepal/homepage.dart';
import 'package:menfashionnepal/main.dart';


class inAppbrowewr extends StatefulWidget {
  String ? link;
  inAppbrowewr(this.link);
  final MyInAppBrowser browser = new MyInAppBrowser();

  @override
  _inAppbrowewrState createState() => new _inAppbrowewrState(link);
}

class _inAppbrowewrState extends State<inAppbrowewr> {
  var options = InAppBrowserClassOptions(
      crossPlatform: InAppBrowserOptions(
         hideToolbarTop: true,
          hideUrlBar: true),
      inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));
  String ? link;
  _inAppbrowewrState(this.link);

  @override
  void initState() {
    widget.browser.openUrlRequest(
        urlRequest: URLRequest(url: Uri.parse(link!)),
        options: options);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigation_Page(index: 0,),
    );
  }
}

class MyInAppBrowser extends InAppBrowser {
  @override
  Future onBrowserCreated() async {
    print("Browser Created!");
  }

  @override
  Future onLoadStart(url) async {
    print("Started $url");
  }

  @override
  Future onLoadStop(url) async {
    print("Stopped $url");
  }

  @override
  void onLoadError(url, code, message) {
    print("Can't load $url.. Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    print("Progress: $progress");
  }

  @override
  void onExit() {
    print("Browser closed!");
  }
}
