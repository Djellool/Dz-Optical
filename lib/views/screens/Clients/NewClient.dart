import 'package:eos/provider/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:eos/provider/GeneralProvider.dart';
import 'package:eos/views/components/CommonStyles.dart';
import 'package:eos/views/components/Header.dart';

class NewClient extends StatefulWidget {
  @override
  _NewClientState createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  Color white = Color(0xFFFFFFFF);
  Color grey = Color(0xFF7A8AA3);
  Color green = Color(0xFF3E9DAC);
  Color coldgreen = Color(0xFF01AFB5);
  Color blue = Color(0xFF041E59);
  var controller = Get.put(GeneralProvider());
  var sphController = TextEditingController(text: "7.565");

  var vLGSphController = TextEditingController();
  var vLGCylController = TextEditingController();
  var vLGAxeController = TextEditingController();
  var vLGAddController = TextEditingController();

  var vLDSphController = TextEditingController();
  var vLDCylController = TextEditingController();
  var vLDAxeController = TextEditingController();
  var vLDAddController = TextEditingController();

  var vPGSphController = TextEditingController();
  var vPGCylController = TextEditingController();
  var vPGAxeController = TextEditingController();
  var vPGAddController = TextEditingController();

  var vPDSphController = TextEditingController();
  var vPDCylController = TextEditingController();
  var vPDAxeController = TextEditingController();
  var vPDAddController = TextEditingController();

  var lGSphController = TextEditingController();
  var lGCylController = TextEditingController();
  var lGAxeController = TextEditingController();
  var lGAddController = TextEditingController();

  var lDSphController = TextEditingController();
  var lDCylController = TextEditingController();
  var lDAxeController = TextEditingController();
  var lDAddController = TextEditingController();

  String vLODPrice = "Prix";
  String vLOGPrice = "Prix";
  String vPODPrice = "Prix";
  String vPOGPrice = "Prix";

  String lODPrice = "Prix";
  String lOGPrice = "Prix";

  String selectedCategorie;
  List<String> categories = [];

  String selectedSousCategorie;
  List<String> sousCategories = [];

  String selectedTypes;
  List<String> types = [];

  String selectedGammes;
  List<String> gammes = [];

  String selectedLCategorie;
  List<String> lCategories = [];

  String selectedLTypes;
  List<String> lTypes = [];

  String selectedLGammes;
  List<String> lGammes = [];

  void initState() {
    super.initState();
    var contro = Get.put(GeneralProvider());
    if (contro.client.toString() == 'registered') {
      vLGSphController.text = contro.LGSPH.toString();
      vLDSphController.text = contro.LDSPH.toString();
      vLGCylController.text = contro.LGCYL.toString();
      vLDCylController.text = contro.LDCYL.toString();
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
              onTap: () async {
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
                if (selectedCategorie == "Fabrication" &&
                    selectedGammes != null) {
                  var list = await DBProvider.db.getAllVerresFifthLevel(
                      selectedCategorie,
                      selectedSousCategorie,
                      selectedTypes,
                      selectedGammes);

                  if (vLDSphController.text.isNotEmpty &&
                      vLDCylController.text.isNotEmpty) {
                    vLODPrice = await DBProvider.db.getPrixVerre(
                        double.tryParse(vLDSphController.text),
                        double.tryParse(vLDCylController.text),
                        list[0].id);
                    setState(() {});
                  }
                  if (vLGSphController.text.isNotEmpty &&
                      vLGCylController.text.isNotEmpty) {
                    vLOGPrice = await DBProvider.db.getPrixVerre(
                        double.tryParse(vLGSphController.text),
                        double.tryParse(vLGCylController.text),
                        list[0].id);
                    setState(() {});
                  }

                  if (vPDSphController.text.isNotEmpty &&
                      vPDCylController.text.isNotEmpty) {
                    vPODPrice = await DBProvider.db.getPrixVerre(
                        double.tryParse(vPDSphController.text),
                        double.tryParse(vPDCylController.text),
                        list[0].id);
                    setState(() {});
                  }
                  if (vPGSphController.text.isNotEmpty &&
                      vPGCylController.text.isNotEmpty) {
                    vPOGPrice = await DBProvider.db.getPrixVerre(
                        double.tryParse(vPGSphController.text),
                        double.tryParse(vPGCylController.text),
                        list[0].id);
                    setState(() {});
                  }
                } else if (selectedCategorie == "Stock" &&
                    selectedGammes != null) {
                  var list = await DBProvider.db.getAllVerresFourthLevel(
                      selectedCategorie, selectedTypes, selectedGammes);

                  if (vLDSphController.text.isNotEmpty &&
                      vLDCylController.text.isNotEmpty) {
                    vLODPrice = await DBProvider.db.getPrixVerre(
                        double.tryParse(vLDSphController.text),
                        double.tryParse(vLDCylController.text),
                        list[0].id);
                    setState(() {});
                  }
                  if (vLGSphController.text.isNotEmpty &&
                      vLGCylController.text.isNotEmpty) {
                    vLOGPrice = await DBProvider.db.getPrixVerre(
                        double.tryParse(vLGSphController.text),
                        double.tryParse(vLGCylController.text),
                        list[0].id);
                    setState(() {});
                  }

                  if (vPDSphController.text.isNotEmpty &&
                      vPDCylController.text.isNotEmpty) {
                    vPODPrice = await DBProvider.db.getPrixVerre(
                        double.tryParse(vPDSphController.text),
                        double.tryParse(vPDCylController.text),
                        list[0].id);
                    setState(() {});
                  }
                  if (vPGSphController.text.isNotEmpty &&
                      vPGCylController.text.isNotEmpty) {
                    vPOGPrice = await DBProvider.db.getPrixVerre(
                        double.tryParse(vPGSphController.text),
                        double.tryParse(vPGCylController.text),
                        list[0].id);
                    setState(() {});
                  }
                }

                if (selectedLGammes != null) {
                  if (lDSphController.text.isNotEmpty &&
                      lDCylController.text.isNotEmpty) {
                    var lentille =
                        await DBProvider.db.getLentilleID(selectedLGammes);
                    lODPrice = await DBProvider.db.getPrixLentille(
                        double.tryParse(lDSphController.text),
                        double.tryParse(lDCylController.text),
                        lentille);
                    setState(() {});
                  }
                  if (lGSphController.text.isNotEmpty &&
                      lGCylController.text.isNotEmpty) {
                    var lentille =
                        await DBProvider.db.getLentilleID(selectedLGammes);
                    lOGPrice = await DBProvider.db.getPrixLentille(
                        double.tryParse(lGSphController.text),
                        double.tryParse(lGCylController.text),
                        lentille);
                    setState(() {});
                  }
                }

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
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 80),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FutureBuilder(
                                        future: DBProvider.db.getVerreNiveau0(),
                                        builder: (context, snapshot) {
                                          if (snapshot.hasError) {
                                            return Text(
                                                snapshot.error.toString());
                                          } else if (snapshot.hasData) {
                                            categories = snapshot.data;
                                            return Container(
                                              width: 200,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                decoration:
                                                    CommonStyles.textDecoration(
                                                        context,
                                                        "Categorie",
                                                        null),
                                                value: selectedCategorie,
                                                onChanged:
                                                    (String value) async {
                                                  if (value == "Fabrication") {
                                                    var list = await DBProvider
                                                        .db
                                                        .getVerreNiveau1(value);
                                                    selectedGammes = null;
                                                    selectedTypes = null;
                                                    setState(() {
                                                      types = [];
                                                      gammes = [];

                                                      selectedCategorie = value;
                                                      sousCategories = list;
                                                    });
                                                  } else {
                                                    var list = await DBProvider
                                                        .db
                                                        .getVerreNiveau1(value);
                                                    selectedGammes = null;
                                                    selectedTypes = null;
                                                    setState(() {
                                                      types = [];

                                                      gammes = [];
                                                      sousCategories = [];
                                                      selectedCategorie = value;
                                                      types = list;
                                                    });
                                                  }
                                                },
                                                items:
                                                    categories.map((categorie) {
                                                  return DropdownMenuItem(
                                                    child: new Text(
                                                      categorie,
                                                      style: TextStyle(
                                                          fontFamily: "Nunito",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                    value: categorie,
                                                  );
                                                }).toList(),
                                              ),
                                            );
                                          } else
                                            return CircularProgressIndicator();
                                        }),
                                    Container(
                                      width: 200,
                                      child: DropdownButtonFormField<String>(
                                        decoration: CommonStyles.textDecoration(
                                            context, "Sous catégorie", null),
                                        value: selectedSousCategorie,
                                        onChanged: (String value) async {
                                          var list = await DBProvider.db
                                              .getVerreNiveau2(
                                                  selectedCategorie,
                                                  value.toString());

                                          setState(() {
                                            selectedTypes = null;
                                            gammes = [];
                                            selectedSousCategorie = value;
                                            types = list;
                                          });
                                        },
                                        items:
                                            sousCategories.map((sousCategorie) {
                                          return DropdownMenuItem(
                                            child: new Text(
                                              sousCategorie.toString(),
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            value: sousCategorie,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: DropdownButtonFormField<String>(
                                        decoration: CommonStyles.textDecoration(
                                            context, "type", null),
                                        value: selectedTypes,
                                        onChanged: (String value) async {
                                          if (selectedCategorie ==
                                              "Fabrication") {
                                            var list = await DBProvider.db
                                                .getVerreNiveau3(
                                                    selectedCategorie,
                                                    selectedSousCategorie
                                                        .toString(),
                                                    value);
                                            selectedGammes = null;
                                            setState(() {
                                              gammes = [];
                                              selectedTypes = value;
                                              gammes = list;
                                            });
                                          } else {
                                            var list = await DBProvider.db
                                                .getVerreNiveau2(
                                                    selectedCategorie, value);
                                            selectedGammes = null;
                                            setState(() {
                                              gammes = [];
                                              selectedTypes = value;
                                              gammes = list;
                                            });
                                          }
                                        },
                                        items: types.map((type) {
                                          return DropdownMenuItem(
                                            child: new Text(
                                              type,
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            value: type,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: DropdownButtonFormField<String>(
                                        decoration: CommonStyles.textDecoration(
                                            context, "Gamme", null),
                                        value: selectedGammes,
                                        onChanged: (String value) {
                                          setState(() {
                                            selectedGammes = value;
                                          });
                                        },
                                        items: gammes.map((gammes) {
                                          return DropdownMenuItem(
                                            child: new Text(
                                              gammes,
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            value: gammes,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 80),
                                  height: 260,
                                  width: 800,
                                  decoration: BoxDecoration(
                                      color: CommonStyles().white,
                                      border: Border.all(
                                          color: CommonStyles().blue,
                                          width: 3)),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerTheme: DividerThemeData(
                                          color: CommonStyles().blue,
                                        ),
                                        dataTableTheme: DataTableThemeData(
                                            headingRowColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                          if (states
                                              .contains(MaterialState.selected))
                                            return Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.08);
                                          return CommonStyles()
                                              .green; // Use the default value.
                                        }))),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        width: 794,
                                        child: DataTable(columns: [
                                          DataColumn(
                                              label: Center(
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold,
                                                color: CommonStyles().white,
                                              ),
                                            ),
                                          )),
                                          DataColumn(
                                              label: Center(
                                            child: Text(
                                              "SPH",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold,
                                                color: CommonStyles().white,
                                              ),
                                            ),
                                          )),
                                          DataColumn(
                                              label: Center(
                                            child: Text(
                                              "CYL",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold,
                                                color: CommonStyles().white,
                                              ),
                                            ),
                                          )),
                                          DataColumn(
                                              label: Center(
                                            child: Text(
                                              "AXE",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold,
                                                color: CommonStyles().white,
                                              ),
                                            ),
                                          )),
                                          DataColumn(
                                              label: Center(
                                            child: Text(
                                              "ADD",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold,
                                                color: CommonStyles().white,
                                              ),
                                            ),
                                          )),
                                          DataColumn(
                                              label: Center(
                                            child: Text(
                                              "Prix",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold,
                                                color: CommonStyles().white,
                                              ),
                                            ),
                                          )),
                                        ], rows: [
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                Text(
                                                  "OD",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: "Assistant",
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonStyles().green,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vLDSphController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vLDCylController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vLDAxeController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vLDAddController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(Text(vLODPrice,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Assistant",
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                            ],
                                          ),
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                Text(
                                                  "OG",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: "Assistant",
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonStyles().green,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vLGSphController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vLGCylController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vLGAxeController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vLGAddController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(Text(vLOGPrice,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Assistant",
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                            ],
                                          ),
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                Text(
                                                  "OD",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: "Assistant",
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonStyles().green,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vPDSphController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vPDCylController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vPDAxeController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vPDAddController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(Text(vPODPrice,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Assistant",
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                            ],
                                          ),
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                Text(
                                                  "OG",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: "Assistant",
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonStyles().green,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vPGSphController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vPGCylController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      vPGAxeController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 60,
                                                  child: customtextfield(
                                                      vPGAddController,
                                                      "Labes"),
                                                ),
                                              ),
                                              DataCell(Text(vPOGPrice,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Assistant",
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                            ],
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 255,
                            left: 25,
                            child: Text("VL",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24)),
                          ),
                          Positioned(
                            top: 355,
                            left: 25,
                            child: Text("VP",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Nunito",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24)),
                          ),
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 80),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FutureBuilder(
                                        future:
                                            DBProvider.db.getLentilleNiveau0(),
                                        builder: (context, snapshot) {
                                          lCategories = snapshot.data;
                                          if (snapshot.hasData)
                                            return Container(
                                              width: 200,
                                              child: DropdownButtonFormField<
                                                  String>(
                                                decoration:
                                                    CommonStyles.textDecoration(
                                                        context,
                                                        "Categorie",
                                                        null),
                                                value: selectedLCategorie,
                                                onChanged:
                                                    (String value) async {
                                                  selectedLTypes = null;
                                                  selectedLGammes = null;
                                                  if (value == "Régide" ||
                                                      value == "Regide" ||
                                                      value == "Souple") {
                                                    var list = await DBProvider
                                                        .db
                                                        .getLentilleNiveau1(
                                                            value);
                                                    setState(() {
                                                      lTypes = [];
                                                      lGammes = [];
                                                      selectedLCategorie =
                                                          value;
                                                      lTypes = list;
                                                    });
                                                  } else {
                                                    var list = await DBProvider
                                                        .db
                                                        .getLentilleNiveau1Nom(
                                                            value);
                                                    setState(() {
                                                      lTypes = [];
                                                      lGammes = [];
                                                      selectedLCategorie =
                                                          value;
                                                      lGammes = list;
                                                    });
                                                  }
                                                },
                                                items: lCategories
                                                    .map((categorie) {
                                                  return DropdownMenuItem(
                                                    child: new Text(
                                                      categorie,
                                                      style: TextStyle(
                                                          fontFamily: "Nunito",
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14),
                                                    ),
                                                    value: categorie,
                                                  );
                                                }).toList(),
                                              ),
                                            );
                                          else if (snapshot.hasError)
                                            return Text(
                                                snapshot.error.toString());
                                          else
                                            return CircularProgressIndicator();
                                        }),
                                    Container(
                                      width: 200,
                                      child: DropdownButtonFormField<String>(
                                        decoration: CommonStyles.textDecoration(
                                            context, "Type", null),
                                        value: selectedLTypes,
                                        onChanged: (String value) async {
                                          var list = await DBProvider.db
                                              .getLentilleNiveau2Nom(
                                                  selectedLCategorie, value);
                                          selectedGammes = null;
                                          setState(() {
                                            lGammes = [];
                                            selectedLTypes = value;
                                            lGammes = list;
                                          });
                                        },
                                        items: lTypes.map((type) {
                                          return DropdownMenuItem(
                                            child: new Text(
                                              type,
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            value: type,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                    Container(
                                      width: 200,
                                      child: DropdownButtonFormField<String>(
                                        decoration: CommonStyles.textDecoration(
                                            context, "Gamme", null),
                                        value: selectedLGammes,
                                        onChanged: (String value) {
                                          setState(() {
                                            selectedLGammes = value;
                                          });
                                        },
                                        items: lGammes.map((gammes) {
                                          return DropdownMenuItem(
                                            child: new Text(
                                              gammes,
                                              style: TextStyle(
                                                  fontFamily: "Nunito",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                            value: gammes,
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 260,
                                  width: 800,
                                  decoration: BoxDecoration(
                                      color: CommonStyles().white,
                                      border: Border.all(
                                          color: CommonStyles().blue,
                                          width: 3)),
                                  child: Theme(
                                    data: Theme.of(context).copyWith(
                                        dividerTheme: DividerThemeData(
                                          color: CommonStyles().blue,
                                        ),
                                        dataTableTheme: DataTableThemeData(
                                            headingRowColor:
                                                MaterialStateProperty
                                                    .resolveWith<Color>(
                                                        (Set<MaterialState>
                                                            states) {
                                          if (states
                                              .contains(MaterialState.selected))
                                            return Theme.of(context)
                                                .colorScheme
                                                .primary
                                                .withOpacity(0.08);
                                          return CommonStyles()
                                              .green; // Use the default value.
                                        }))),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Container(
                                        width: 794,
                                        child: DataTable(columns: [
                                          DataColumn(
                                              label: Center(
                                            child: Text(
                                              '',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold,
                                                color: CommonStyles().white,
                                              ),
                                            ),
                                          )),
                                          DataColumn(
                                              label: Center(
                                            child: Text(
                                              "SPH",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold,
                                                color: CommonStyles().white,
                                              ),
                                            ),
                                          )),
                                          DataColumn(
                                              label: Center(
                                            child: Text(
                                              "CYL",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold,
                                                color: CommonStyles().white,
                                              ),
                                            ),
                                          )),
                                          DataColumn(
                                              label: Center(
                                            child: Text(
                                              "AXE",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold,
                                                color: CommonStyles().white,
                                              ),
                                            ),
                                          )),
                                          DataColumn(
                                              label: Center(
                                            child: Text(
                                              "ADD",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold,
                                                color: CommonStyles().white,
                                              ),
                                            ),
                                          )),
                                          DataColumn(
                                              label: Center(
                                            child: Text(
                                              "Prix",
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontFamily: "Assistant",
                                                fontWeight: FontWeight.bold,
                                                color: CommonStyles().white,
                                              ),
                                            ),
                                          )),
                                        ], rows: [
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                Text(
                                                  "OD",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: "Assistant",
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonStyles().green,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      lDSphController, "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      lDCylController, "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      lDAxeController, "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      lDAddController, "Labes"),
                                                ),
                                              ),
                                              DataCell(Text(lODPrice,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Assistant",
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                            ],
                                          ),
                                          DataRow(
                                            cells: [
                                              DataCell(
                                                Text(
                                                  "OG",
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: "Assistant",
                                                    fontWeight: FontWeight.bold,
                                                    color: CommonStyles().green,
                                                  ),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      lGSphController, "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      lGCylController, "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      lGAxeController, "Labes"),
                                                ),
                                              ),
                                              DataCell(
                                                Container(
                                                  width: 100,
                                                  height: 50,
                                                  child: customtextfield(
                                                      lGAddController, "Labes"),
                                                ),
                                              ),
                                              DataCell(Text(lOGPrice,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontFamily: "Assistant",
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                            ],
                                          ),
                                        ]),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
    return TextField(
      controller: contrl,
      readOnly: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelStyle:
            TextStyle(color: Colors.black, fontFamily: "Nunito", fontSize: 14),
        labelText: "N/A",
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
