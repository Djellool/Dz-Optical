import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CommonStyles.dart';

class Header {
  final Shader linearGradient = LinearGradient(
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    colors: <Color>[Color(0xFF041E59), Color(0xFF01AFB5)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 120));

  Widget header(String header) {
    return Stack(alignment: Alignment.topCenter, children: [
      Positioned(
        top: 20,
        child: Text(
          header,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              foreground: Paint()..shader = CommonStyles().linearGradient,
              fontSize: 55,
              fontFamily: "Assistant"),
        ),
      ),
      Positioned(
          top: 20,
          left: 20,
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
                height: 70,
                width: 70,
                decoration: CommonStyles.buttonDeco(),
                child: Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                  size: 40,
                )),
          )),
    ]);
  }

  Widget header2(String header) {
    return Stack(alignment: Alignment.topCenter, children: [
      Positioned(
        top: 20,
        child: Text(
          header,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              foreground: Paint()..shader = CommonStyles().linearGradient,
              fontSize: 55,
              fontFamily: "Assistant"),
        ),
      ),
    ]);
  }
}
