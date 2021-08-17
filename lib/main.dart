import 'package:eos/views/screens/Home/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Color blue = Color(0xFF041E59);
  final Color green = Color(0xFF01AFB5);

  @override
  Widget build(BuildContext context) {
    EasyLoading.instance..indicatorType = EasyLoadingIndicatorType.fadingCube;
    return Container(
      child: GetMaterialApp(
        home: new Scaffold(body: Home()),
        builder: EasyLoading.init(),
      ),
    );
  }
}
