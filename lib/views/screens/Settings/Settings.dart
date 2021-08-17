import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:eos/provider/GeneralProvider.dart';
import 'package:eos/provider/db_provider.dart';
import 'package:eos/services/Apiprovider.dart';
import 'package:eos/views/components/CommonStyles.dart';
import 'package:eos/views/components/Header.dart';
import 'dart:math' as math;

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Color grey = Color(0xFF7A8AA3);
  bool absorb = false;
  String date;
  var controller = Get.put(GeneralProvider());

  final _storage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 5));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => AbsorbPointer(
          absorbing: controller.absorb.value,
          ignoringSemantics: controller.absorb.value,
          child: WillPopScope(
            onWillPop: () async => false,
            child: Scaffold(
                body: Stack(alignment: Alignment.center, children: [
              Image.asset(
                "assets/images/background.PNG",
                fit: BoxFit.fill,
              ),
              Header().header("Paramètres"),
              Positioned(
                top: 160,
                child: Container(
                    height: 350,
                    child: VerticalDivider(
                      color: grey,
                      thickness: 5,
                    )),
              ),
              Positioned(
                top: 185,
                left: 50,
                child: Container(
                  width: 400,
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Votre dernière synchronisation\na été efféctuée le :",
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontFamily: "Assistant",
                              fontSize: 30),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      FutureBuilder(
                          future: DBProvider.db.getDate(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData)
                              return Text(
                                snapshot.data,
                                style: TextStyle(
                                    color: Colors.grey[800],
                                    fontFamily: "Assistant",
                                    fontSize: 40,
                                    fontWeight: FontWeight.bold),
                              );
                            else {
                              return CircularProgressIndicator();
                            }
                          }),
                      SizedBox(
                        height: 60,
                      ),
                      Container(
                        decoration: CommonStyles.buttonDecoSqaure(),
                        child: FlatButton(
                          padding: EdgeInsets.all(16),
                          onPressed: () async {
                            controller.absorb.value = true;

                            _controller.repeat();
                            await syncdata();
                            _controller.reset();
                            controller.absorb.value = false;
                            setState(() {});
                          },
                          child: Text(
                            "Sychroniser",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Assistant",
                                fontSize: 30,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 190,
                right: 145,
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _controller.value * 2 * math.pi,
                      child: child,
                    );
                  },
                  child: Icon(Icons.settings_outlined, size: 250),
                ),
              ),
            ])),
          ),
        ));
  }

  _loadFromApi() async {
    await _storage.deleteAll();
    var apiProvider = ApiProvider();
    await apiProvider.getAllMarques();
    await apiProvider.getAllMagasins();
    await apiProvider.getAllTraitements();
    await apiProvider.getAllVerres();
    await apiProvider.getAllLentilles();
    await apiProvider.getAllVerresPrix();
    await apiProvider.getAllTraitementsVerres();
    await apiProvider.getAllLentillesPrix();
    await apiProvider.getAllTraitementsLentilles();
  }

  _deleteData() async {
    await DBProvider.db.deleteAllTraitementLentilles();
    await DBProvider.db.deleteAllLentillePrix();
    await DBProvider.db.deleteAllTraitementVerres();
    await DBProvider.db.deleteAllVerresPrix();
    await DBProvider.db.deleteAllLentilles();
    await DBProvider.db.deleteAllVerres();
    await DBProvider.db.deleteAllTraitement();
    await DBProvider.db.deleteAllMagasins();
    await DBProvider.db.deleteAllMarques();
  }

  syncdata() async {
    try {
      await _deleteData();
      await _loadFromApi();
      await DBProvider.db.createDate();
      print("Synchronization finished");
    } catch (e) {
      print("Exception = " + e.toString());
      Get.defaultDialog(
        title: "Probleme Survenu",
        titleStyle: TextStyle(
          color: CommonStyles().blue,
          fontSize: 30,
          fontFamily: "Assistant",
          fontWeight: FontWeight.w600,
        ),
        actions: [
          FlatButton(
              padding: EdgeInsets.all(0),
              onPressed: () => Get.back(),
              child: Container(
                width: 100,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.red[600]),
                child: Center(
                  child: Text(
                    "Retour",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
        ],
        content: Column(
          children: [
            Center(
              child: Text(
                "Un probleme est survenue lors de la synchronisation",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Assistant",
                    fontWeight: FontWeight.w600,
                    fontSize: 26),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                "Veuillez verifier votre connexion internet pour reessayer !",
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Assistant",
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
            ),
          ],
        ),
      );
    }
  }
}
