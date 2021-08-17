import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:eos/provider/GeneralProvider.dart';
import 'package:eos/views/components/CommonStyles.dart';
import 'package:eos/views/components/Header.dart';

class Client extends StatefulWidget {
  @override
  _ClientState createState() => _ClientState();
}

class _ClientState extends State<Client> {
  Color white = Color(0xFFFFFFFF);
  Color grey = Color(0xFF7A8AA3);
  Color green = Color(0xFF3E9DAC);
  Color coldgreen = Color(0xFF01AFB5);
  Color blue = Color(0xFF041E59);
  var controller = Get.put(GeneralProvider());
  var sphController = TextEditingController(text: "7.565");

  var vLGSphController = TextEditingController();
  var vLGEpController = TextEditingController();
  var vLGCylController = TextEditingController();
  var vLGHpController = TextEditingController();
  var vLGAxeController = TextEditingController();
  var vLGHOController = TextEditingController();
  var vLGDrisController = TextEditingController();
  var vLGLqtController = TextEditingController();

  var vLDSphController = TextEditingController();
  var vLDEpController = TextEditingController();
  var vLDCylController = TextEditingController();
  var vLDHpController = TextEditingController();
  var vLDAxeController = TextEditingController();
  var vLDHOController = TextEditingController();
  var vLDDrisController = TextEditingController();
  var vLDLqtController = TextEditingController();

  var vIGSphController = TextEditingController();
  var vIGEpController = TextEditingController();
  var vIGCylController = TextEditingController();
  var vIGHpController = TextEditingController();
  var vIGAxeController = TextEditingController();
  var vIGHOController = TextEditingController();
  var vIGDrisController = TextEditingController();
  var vIGLqtController = TextEditingController();

  var vIDSphController = TextEditingController();
  var vIDEpController = TextEditingController();
  var vIDCylController = TextEditingController();
  var vIDHpController = TextEditingController();
  var vIDAxeController = TextEditingController();
  var vIDHOController = TextEditingController();
  var vIDDrisController = TextEditingController();
  var vIDLqtController = TextEditingController();

  var vPGSphController = TextEditingController();
  var vPGEpController = TextEditingController();
  var vPGCylController = TextEditingController();
  var vPGHpController = TextEditingController();
  var vPGAxeController = TextEditingController();
  var vPGHOController = TextEditingController();
  var vPGDrisController = TextEditingController();
  var vPGLqtController = TextEditingController();

  var vPDSphController = TextEditingController();
  var vPDEpController = TextEditingController();
  var vPDCylController = TextEditingController();
  var vPDHpController = TextEditingController();
  var vPDAxeController = TextEditingController();
  var vPDHOController = TextEditingController();
  var vPDDrisController = TextEditingController();
  var vPDLqtController = TextEditingController();

  var lGSphController = TextEditingController();
  var lGCylController = TextEditingController();
  var lGAxeController = TextEditingController();
  var lGRayonController = TextEditingController();
  var lGDiametreController = TextEditingController();

  var lDSphController = TextEditingController();
  var lDCylController = TextEditingController();
  var lDAxeController = TextEditingController();
  var lDRayonController = TextEditingController();
  var lDDiametreController = TextEditingController();

  void initState() {
    super.initState();

    var contro = Get.put(GeneralProvider());
    if (contro.client.toString() == 'registered') {
      vLGSphController.text = contro.LGSPH.toString();
      vLDSphController.text = contro.LDSPH.toString();
      vLGCylController.text = contro.LGCYL.toString();
      vLDCylController.text = contro.LDCYL.toString();
      vIGSphController.text = contro.IGSPH.toString();
      vIDSphController.text = contro.IDSPH.toString();
      vIGCylController.text = contro.IGCYL.toString();
      vIDCylController.text = contro.IDCYL.toString();
      vPGSphController.text = contro.PGSPH.toString();
      vPDSphController.text = contro.PDSPH.toString();
      vPGCylController.text = contro.PGCYL.toString();
      vPDCylController.text = contro.PDCYL.toString();
      lGSphController.text = contro.lGSPH.toString();
      lGCylController.text = contro.lGCYL.toString();
      lDSphController.text = contro.lDSPH.toString();
      lDCylController.text = contro.lDCYL.toString();
    }

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        Positioned(
          top: 0,
          child: Image.asset(
            "assets/images/background.PNG",
            fit: BoxFit.fill,
          ),
        ),
        Header().header("Client"),
        Positioned(
            top: 30,
            right: 20,
            child: InkWell(
              onTap: () {
                controller.IDCYL = "".obs;
                controller.IDSPH = "".obs;
                controller.IGCYL = "".obs;
                controller.IGSPH = "".obs;
                controller.LDCYL = "".obs;
                controller.LDSPH = "".obs;
                controller.LGCYL = "".obs;
                controller.LGSPH = "".obs;
                controller.PDCYL = "".obs;
                controller.PDSPH = "".obs;
                controller.PGCYL = "".obs;
                controller.PDCYL = "".obs;
                controller.lGSPH = "".obs;
                controller.lGCYL = "".obs;
                controller.lDSPH = "".obs;
                controller.lDCYL = "".obs;
                controller.client = "no".obs;
                Get.defaultDialog(
                  title: "Informations du client supprimés avec succès",
                  titleStyle: TextStyle(
                    color: CommonStyles().blue,
                    fontSize: 30,
                    fontFamily: "Assistant",
                    fontWeight: FontWeight.w600,
                  ),
                  actions: [
                    FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
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
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                  height: 70,
                  width: 70,
                  decoration: CommonStyles.buttonDeco(),
                  child: Icon(
                    Icons.clear,
                    color: Colors.white,
                    size: 40,
                  )),
            )),
        Positioned(
            top: 30,
            right: 120,
            child: InkWell(
              onTap: () {
                print("controller");
                controller.IDCYL = vIDCylController.text.obs;
                controller.IDSPH = vIDSphController.text.obs;
                controller.IGCYL = vIGCylController.text.obs;
                controller.IGSPH = vIGSphController.text.obs;
                controller.LDCYL = vLDCylController.text.obs;
                controller.LDSPH = vLDSphController.text.obs;
                controller.LGCYL = vLGCylController.text.obs;
                controller.LGSPH = vLGSphController.text.obs;
                controller.PDCYL = vPDCylController.text.obs;
                controller.PDSPH = vPDSphController.text.obs;
                controller.PGCYL = vPGCylController.text.obs;
                controller.PGSPH = vPGSphController.text.obs;
                controller.lGSPH = lGSphController.text.obs;
                controller.lGCYL = lGCylController.text.obs;
                controller.lDSPH = lDSphController.text.obs;
                controller.lDCYL = lDCylController.text.obs;
                controller.client = "registered".obs;
                Get.defaultDialog(
                  title: "Informations du client enregistrées avec succès",
                  titleStyle: TextStyle(
                    color: CommonStyles().blue,
                    fontSize: 30,
                    fontFamily: "Assistant",
                    fontWeight: FontWeight.w600,
                  ),
                  actions: [
                    FlatButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          Get.back();
                          Get.back();
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.green),
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
                      SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                          "Les prix relatif aux clients seront affichées dans le détail du produit",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Assistant",
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                  height: 70,
                  width: 70,
                  decoration: CommonStyles.buttonDeco(),
                  child: Icon(
                    Icons.done_outlined,
                    color: Colors.white,
                    size: 40,
                  )),
            )),
        Positioned(
            top: 130,
            left: 10,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SizedBox(
                width: 900,
                height: 500,
                child: DefaultTabController(
                  length: 2,
                  child: Scaffold(
                    extendBodyBehindAppBar: true,
                    backgroundColor: Colors.transparent,
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      flexibleSpace: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TabBar(
                            unselectedLabelColor: green,
                            labelColor: white,
                            indicator: BoxDecoration(
                              // Creates border
                              gradient: LinearGradient(
                                colors: [coldgreen, blue],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            tabs: [
                              Tab(
                                child: Center(
                                  child: Text(
                                    "Verre",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: "Assistant",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Tab(
                                child: Center(
                                  child: Text(
                                    "Lentille",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontFamily: "Assistant",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    body: TabBarView(children: [
                      Container(
                        child: DefaultTabController(
                          length: 3,
                          child: Scaffold(
                            extendBodyBehindAppBar: true,
                            backgroundColor: Colors.transparent,
                            appBar: AppBar(
                              automaticallyImplyLeading: false,
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              flexibleSpace: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TabBar(
                                    unselectedLabelColor: green,
                                    labelColor: white,
                                    indicator: BoxDecoration(
                                      // Creates border
                                      gradient: LinearGradient(
                                        colors: [coldgreen, blue],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                    tabs: [
                                      Tab(
                                        child: Center(
                                          child: Text(
                                            "Vue de Loin",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Center(
                                          child: Text(
                                            "Vue Intermediare",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontFamily: "Assistant",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Center(
                                          child: Text(
                                            "Vue de Près",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            body: TabBarView(
                              children: [
                                Container(
                                  child: DefaultTabController(
                                    length: 2,
                                    child: Scaffold(
                                      extendBodyBehindAppBar: true,
                                      backgroundColor: Colors.transparent,
                                      appBar: AppBar(
                                        automaticallyImplyLeading: false,
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        flexibleSpace: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TabBar(
                                              unselectedLabelColor: green,
                                              labelColor: white,
                                              indicator: BoxDecoration(
                                                // Creates border
                                                gradient: LinearGradient(
                                                  colors: [coldgreen, blue],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                              tabs: [
                                                Tab(
                                                  child: Center(
                                                    child: Text(
                                                      "Oeil Gauche",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontFamily:
                                                              "Assistant",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Tab(
                                                  child: Center(
                                                    child: Text(
                                                      "Oeil Droite",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontFamily:
                                                              "Assistant",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      body: TabBarView(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 185),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vLGSphController,
                                                          'SPH'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vLGEpController,
                                                          "EP"),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vLGCylController,
                                                          'CYL'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vLGHpController,
                                                          'HP'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vLGAxeController,
                                                          'AXE'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vLGHOController,
                                                          'HO'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vLGDrisController,
                                                          'DRIS'),
                                                      SizedBox(
                                                        width: 50.0,
                                                      ),
                                                      customtextfield(
                                                          vLGLqtController,
                                                          'LQT'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 185),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vLDSphController,
                                                          'SPH'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vLDEpController,
                                                          'EP'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vLDCylController,
                                                          'CYL'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vLDHpController,
                                                          'HP'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vLDAxeController,
                                                          'AXE'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vLDHOController,
                                                          'HO'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vLDDrisController,
                                                          'DRIS'),
                                                      SizedBox(
                                                        width: 50.0,
                                                      ),
                                                      customtextfield(
                                                          vLDLqtController,
                                                          'LQT'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: DefaultTabController(
                                    length: 2,
                                    child: Scaffold(
                                      extendBodyBehindAppBar: true,
                                      backgroundColor: Colors.transparent,
                                      appBar: AppBar(
                                        automaticallyImplyLeading: false,
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        flexibleSpace: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TabBar(
                                              unselectedLabelColor: green,
                                              labelColor: white,
                                              indicator: BoxDecoration(
                                                // Creates border
                                                gradient: LinearGradient(
                                                  colors: [coldgreen, blue],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                              tabs: [
                                                Tab(
                                                  child: Center(
                                                    child: Text(
                                                      "Oeil Gauche",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontFamily:
                                                              "Assistant",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Tab(
                                                  child: Center(
                                                    child: Text(
                                                      "Oeil Droite",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontFamily:
                                                              "Assistant",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      body: TabBarView(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 185),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vIGSphController,
                                                          'SPH'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vIGEpController,
                                                          'EP'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vIGCylController,
                                                          'CYL'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vIGHpController,
                                                          'HP'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vIGAxeController,
                                                          'AXE'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vIGHOController,
                                                          'HO'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vIGDrisController,
                                                          'DRIS'),
                                                      SizedBox(
                                                        width: 50.0,
                                                      ),
                                                      customtextfield(
                                                          vIGLqtController,
                                                          'LQT'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 185),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vIDSphController,
                                                          'SPH'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vIDEpController,
                                                          'EP'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vIDCylController,
                                                          'CYL'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vIDHpController,
                                                          'HP'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vIDAxeController,
                                                          'AXE'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vIDHOController,
                                                          'HO'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vIDDrisController,
                                                          'DRIS'),
                                                      SizedBox(
                                                        width: 50.0,
                                                      ),
                                                      customtextfield(
                                                          vIDLqtController,
                                                          'LQT'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: DefaultTabController(
                                    length: 2,
                                    child: Scaffold(
                                      extendBodyBehindAppBar: true,
                                      backgroundColor: Colors.transparent,
                                      appBar: AppBar(
                                        automaticallyImplyLeading: false,
                                        elevation: 0,
                                        backgroundColor: Colors.transparent,
                                        flexibleSpace: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TabBar(
                                              unselectedLabelColor: green,
                                              labelColor: white,
                                              indicator: BoxDecoration(
                                                // Creates border
                                                gradient: LinearGradient(
                                                  colors: [coldgreen, blue],
                                                  begin: Alignment.centerLeft,
                                                  end: Alignment.centerRight,
                                                ),
                                              ),
                                              tabs: [
                                                Tab(
                                                  child: Center(
                                                    child: Text(
                                                      "Oeil Gauche",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontFamily:
                                                              "Assistant",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Tab(
                                                  child: Center(
                                                    child: Text(
                                                      "Oeil Droite",
                                                      style: TextStyle(
                                                          fontSize: 25,
                                                          fontFamily:
                                                              "Assistant",
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      body: TabBarView(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 185),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vPGSphController,
                                                          'SPH'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vPGEpController,
                                                          'EP'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vPGCylController,
                                                          'CYL'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vPGHpController,
                                                          'HP'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vPGAxeController,
                                                          'AXE'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vPGHOController,
                                                          'HO'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vPGDrisController,
                                                          'DRIS'),
                                                      SizedBox(
                                                        width: 50.0,
                                                      ),
                                                      customtextfield(
                                                          vPGLqtController,
                                                          'LQT'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 185),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vPDSphController,
                                                          'SPH'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vPDEpController,
                                                          'EP'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vPDCylController,
                                                          'CYL'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vPDHpController,
                                                          'HP'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vPDAxeController,
                                                          'AXE'),
                                                      SizedBox(
                                                        width: 30.0,
                                                      ),
                                                      customtextfield(
                                                          vPDHOController,
                                                          'HO'),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      customtextfield(
                                                          vPDDrisController,
                                                          'DRIS'),
                                                      SizedBox(
                                                        width: 50.0,
                                                      ),
                                                      customtextfield(
                                                          vPDLqtController,
                                                          'LQT'),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: DefaultTabController(
                          length: 2,
                          child: Scaffold(
                            extendBodyBehindAppBar: true,
                            backgroundColor: Colors.transparent,
                            appBar: AppBar(
                              automaticallyImplyLeading: false,
                              elevation: 0,
                              backgroundColor: Colors.transparent,
                              flexibleSpace: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TabBar(
                                    unselectedLabelColor: green,
                                    labelColor: white,
                                    indicator: BoxDecoration(
                                      // Creates border
                                      gradient: LinearGradient(
                                        colors: [coldgreen, blue],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                      ),
                                    ),
                                    tabs: [
                                      Tab(
                                        child: Center(
                                          child: Text(
                                            "Oeil Gauche",
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Tab(
                                        child: Center(
                                          child: Text(
                                            "Oeil Droite",
                                            style: TextStyle(
                                              fontSize: 25,
                                              fontFamily: "Assistant",
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            body: TabBarView(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 140),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            customtextfield(
                                                lGSphController, 'SPH'),
                                            SizedBox(
                                              width: 30.0,
                                            ),
                                            customtextfield(
                                                lGCylController, 'CYL'),
                                            SizedBox(
                                              width: 30.0,
                                            ),
                                            customtextfield(
                                                lGAxeController, 'AXE'),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            customtextfield(
                                                lGRayonController, 'Rayon'),
                                            SizedBox(
                                              width: 50.0,
                                            ),
                                            customtextfield(
                                                lGDiametreController,
                                                'Diametre'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 140),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            customtextfield(
                                                lDSphController, 'SPH'),
                                            SizedBox(
                                              width: 30.0,
                                            ),
                                            customtextfield(
                                                lDCylController, 'CYL'),
                                            SizedBox(
                                              width: 30.0,
                                            ),
                                            customtextfield(
                                                lDAxeController, 'AXE'),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 15),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            customtextfield(
                                                lDRayonController, 'Rayon'),
                                            SizedBox(
                                              width: 50.0,
                                            ),
                                            customtextfield(
                                                lDDiametreController,
                                                'Diametre'),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ),
            )),
      ]),
    );
  }

  Widget customtextfield(TextEditingController contrl, String labelText) {
    return new Flexible(
      child: TextField(
        controller: contrl,
        readOnly: false,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelStyle: TextStyle(
              color: blue,
              fontFamily: "Nunito",
              fontWeight: FontWeight.bold,
              fontSize: 18),
          labelText: labelText,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: blue,
              width: 2.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: blue,
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
      ),
    );
  }
}
