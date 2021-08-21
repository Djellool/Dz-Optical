import 'package:eos/provider/GeneralProvider.dart';
import 'package:eos/provider/db_provider.dart';
import 'package:eos/views/components/CommonStyles.dart';
import 'package:eos/views/screens/Clients/NewClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eos/views/screens/Clients/Client.dart';
import 'package:eos/views/screens/Lentilles/Lentilles.dart';
import 'package:eos/views/screens/Settings/Settings.dart';
import 'package:eos/views/screens/Verres/Verres.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(GeneralProvider());
  final Color white = Colors.white;

  bool isVisible1 = false;
  bool isVisible2 = false;
  bool isVisible3 = false;
  bool isVisible4 = false;
  bool isSmall1 = false;
  bool isSmall2 = false;
  bool isSmall3 = false;
  bool isSmall4 = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      if (this.mounted) {
        setState(() {
          isVisible1 = true;
        });
      }
    });
    Future.delayed(Duration(seconds: 2), () {
      if (this.mounted) {
        setState(() {
          isVisible2 = true;
        });
      }
    });
    Future.delayed(Duration(seconds: 3), () {
      if (this.mounted) {
        setState(() {
          isVisible3 = true;
        });
      }
    });
    Future.delayed(Duration(seconds: 4), () {
      if (this.mounted) {
        setState(() {
          isVisible4 = true;
        });
      }
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (this.mounted) {
        setState(() {
          isSmall1 = true;
        });
      }
    });
    Future.delayed(const Duration(seconds: 2), () {
      if (this.mounted) {
        setState(() {
          isSmall2 = true;
        });
      }
    });
    Future.delayed(const Duration(seconds: 3), () {
      if (this.mounted) {
        setState(() {
          isSmall3 = true;
        });
      }
    });
    Future.delayed(const Duration(seconds: 4), () {
      if (this.mounted) {
        setState(() {
          isSmall4 = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print("home");
    return Stack(children: [
      Image.asset(
        "assets/images/homepage.PNG",
        fit: BoxFit.fill,
      ),
      buttons(),
    ]);
  }

  buttons() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
            top: 15,
            child: Container(
                height: 200, child: Image.asset("assets/images/logo.png"))),
        Positioned(
          top: 130,
          left: 109,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 1500),
            opacity: isVisible1 ? 1 : 0,
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                //  Get.to(() => Verres());
                await DBProvider.db.getPrixVerre(6, 4.25, 2);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: isSmall1 ? 125 : 0,
                width: isSmall1 ? 125 : 0,
                decoration: CommonStyles.buttonDeco(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Verres",
                          style: TextStyle(
                            color: white,
                            fontSize: 30,
                            fontFamily: "Assistant",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 130,
          right: 110,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 1500),
            opacity: isVisible2 ? 1 : 0,
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                Get.to(() => Lentilles());
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: isSmall2 ? 125 : 0,
                width: isSmall2 ? 125 : 0,
                decoration: CommonStyles.buttonDeco(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Lentilles",
                          style: TextStyle(
                            color: white,
                            fontSize: 30,
                            fontFamily: "Assistant",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 413,
          left: 109,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 1500),
            opacity: isVisible3 ? 1 : 0,
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () async {
                Get.to(() => NewClient());
              },
              child: AnimatedContainer(
                curve: Curves.fastOutSlowIn,
                duration: Duration(milliseconds: 500),
                height: isSmall3 ? 125 : 0,
                width: isSmall3 ? 125 : 0,
                decoration: CommonStyles.buttonDeco(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Client",
                          style: TextStyle(
                            color: white,
                            fontSize: 30,
                            fontFamily: "Assistant",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 413,
          right: 110,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 1500),
            opacity: isVisible4 ? 1 : 0,
            child: FlatButton(
              padding: EdgeInsets.zero,
              onPressed: () => Get.to(() => Settings()),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                height: isSmall4 ? 125 : 0,
                width: isSmall4 ? 125 : 0,
                decoration: CommonStyles.buttonDeco(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "Paramètres",
                          style: TextStyle(
                            color: white,
                            fontSize: 23,
                            fontWeight: FontWeight.w600,
                            fontFamily: "Assistant",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
