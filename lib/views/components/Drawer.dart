import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:eos/provider/GeneralProvider.dart';
import 'package:eos/views/screens/Verres/Rechercheverre.dart';

import 'CommonStyles.dart';

class NavDrawer extends StatefulWidget {
  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  final Color violet = Color(0xFF382B8C);
  final Color blue = Color(0xFF382B8C);
  var controller = Get.put(GeneralProvider());
  var recherchecontroller = TextEditingController(text: "");

  var originecontroller = TextEditingController(text: "");
  var matierecontroller = TextEditingController(text: "");
  void initState() {
    super.initState();

    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        if (visible == false) {
          SystemChrome.restoreSystemUIOverlays();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            blurRadius: 25,
          ),
        ],
      ),
      height: 750,
      width: 350,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Image.asset(
                "assets/images/drawerbackground.jpg",
                fit: BoxFit.fill,
                height: 200,
                width: 400,
              ),
              Positioned(
                top: 0,
                child: Container(
                  width: 400,
                  height: 200,
                  color: CommonStyles().green.withOpacity(0.5),
                ),
              ),
              Positioned(
                  top: 70,
                  child: Center(
                    child: Text(
                      "Filtres",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Assistant",
                          fontSize: 54,
                          fontWeight: FontWeight.w600),
                    ),
                  )),
            ],
          ),
          SizedBox(height: 15),
          Container(
            width: 300,
            height: 65,
            child: TextField(
              controller: recherchecontroller,
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.search,
                    size: 40,
                    color: blue,
                  ),
                ),
                hintText: "Nom Commercial",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CommonStyles().blue, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CommonStyles().blue, width: 4),
                ),
              ),
            ),
          ),
          SizedBox(height: 7),
          Container(
            width: 300,
            height: 65,
            child: TextField(
              controller: originecontroller,
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.search,
                    size: 40,
                    color: blue,
                  ),
                ),
                hintText: "Origine",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CommonStyles().blue, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CommonStyles().blue, width: 4),
                ),
              ),
            ),
          ),
          SizedBox(height: 7),
          Container(
            width: 300,
            height: 65,
            child: TextField(
              controller: matierecontroller,
              decoration: InputDecoration(
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.search,
                    size: 40,
                    color: blue,
                  ),
                ),
                hintText: "Matiere",
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CommonStyles().blue, width: 3),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: CommonStyles().blue, width: 4),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          FlatButton(
            onPressed: () {
              controller.recherche = recherchecontroller.text.obs;
              controller.matiere = matierecontroller.text.obs;
              controller.origine = originecontroller.text.obs;
              Get.to(() => RerchercheClasse());
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              width: 200,
              height: 75,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [CommonStyles().green, CommonStyles().blue])),
              child: Center(
                  child: Text(
                "Filtrer",
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Assistant",
                    fontSize: 35,
                    fontWeight: FontWeight.w600),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
