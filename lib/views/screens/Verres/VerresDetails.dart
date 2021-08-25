import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eos/Models/TraitementJoinVerre2.dart';
import 'package:eos/provider/GeneralProvider.dart';
import 'package:eos/provider/db_provider.dart';
import 'package:eos/views/components/CommonStyles.dart';
import 'package:path_provider/path_provider.dart';

class VerreDetail extends StatefulWidget {
  @override
  _VerreDetailState createState() => _VerreDetailState();
}

class _VerreDetailState extends State<VerreDetail> {
  Directory directory;

  getImage(String image) async {
    String text;
    try {
      if (directory == null)
        directory = await getApplicationDocumentsDirectory();
      File file = File('${directory.path}/$image.png');
      text = await file.readAsString();
    } catch (e) {
      print(e.toString());
    }
    return text;
  }

  var controller = Get.put(GeneralProvider());

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DBProvider.db.getVerrebyId(controller.idverre.toString()),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData && snapshot.data.isNotEmpty) {
            return Scaffold(
                body: Stack(alignment: Alignment.topCenter, children: [
              Image.asset(
                "assets/images/detailverre.png",
                fit: BoxFit.fill,
              ),
              header(""),
              Positioned(
                top: 165,
                child: FutureBuilder(
                    future: getImage(snapshot.data[0].image),
                    builder: (context, snapshoott) {
                      if (snapshoott.hasData) {
                        Uint8List bytes = base64Decode(snapshoott.data);
                        return new Container(
                          width: 270.0,
                          height: 270.0,
                          decoration: new BoxDecoration(
                            color: CommonStyles().grey,
                            image: new DecorationImage(
                              image: MemoryImage(bytes),
                              fit: BoxFit.fitHeight,
                            ),
                            borderRadius:
                                new BorderRadius.all(new Radius.circular(270)),
                            border: new Border.all(
                              color: CommonStyles().blue,
                              width: 4.0,
                            ),
                          ),
                        );
                      } else
                        return Center(child: CircularProgressIndicator());
                    }),
              ),
              origine(snapshot.data[0].origine),
              FutureBuilder(
                  future: DBProvider.db
                      .getMarquebyId(snapshot.data[0].marqueId.toString()),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshott) {
                    if (snapshott.hasData) {
                      return marque(snapshott.data[0].nomCommercial.toString());
                    } else if (snapshott.hasError) {
                      return Text("Erreur");
                    }
                    // By default, show a loading spinner.
                    return Center(child: CircularProgressIndicator());
                  }),
              nom(snapshot.data[0].nomCommercial.toString()),
              matiere(snapshot.data[0].matiere.toString()),
              distance(snapshot.data[0].distance.toString()),
              addition(snapshot.data[0].addition.toString()),
              indice(snapshot.data[0].indice.toString()),
              diametre(snapshot.data[0].diametre.toString()),
              type(snapshot.data[0].type.toString()),
              categorie(snapshot.data[0].niveau0.toString()),
            ]));
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Text("Erreur");
          }
          // By default, show a loading spinner.
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget origine(String title) {
    return Positioned(
        top: 115,
        left: 46,
        child: Container(
          padding: EdgeInsets.all(8),
          width: 190,
          height: 75,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [CommonStyles().green, CommonStyles().blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: FittedBox(
              child: Center(
                  child: Column(
            children: [
              Text(
                "Origine :",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Assistant", fontSize: 8),
              ),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Assistant",
                    fontWeight: FontWeight.w600),
              ),
            ],
          ))),
        ));
  }

  Widget marque(String title) {
    return Positioned(
        top: 210,
        left: 46,
        child: Container(
          padding: EdgeInsets.all(8),
          width: 190,
          height: 75,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [CommonStyles().green, CommonStyles().blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: FittedBox(
              child: Center(
                  child: Column(
            children: [
              Text(
                "Marque :",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Assistant", fontSize: 8),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontFamily: "Assistant"),
              ),
            ],
          ))),
        ));
  }

  Widget nom(String title) {
    return Positioned(
        top: 305,
        left: 46,
        child: Container(
          padding: EdgeInsets.all(8),
          width: 190,
          height: 75,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [CommonStyles().green, CommonStyles().blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: FittedBox(
              child: Center(
                  child: Column(
            children: [
              Text(
                "Nom :",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Assistant", fontSize: 8),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontFamily: "Assistant"),
              ),
            ],
          ))),
        ));
  }

  Widget matiere(String title) {
    return Positioned(
        top: 403,
        left: 46,
        child: Container(
          padding: EdgeInsets.all(8),
          width: 190,
          height: 75,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [CommonStyles().green, CommonStyles().blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: FittedBox(
              child: Center(
                  child: Column(
            children: [
              Text(
                "Matiere : ",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Assistant", fontSize: 8),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontFamily: "Assistant"),
              ),
            ],
          ))),
        ));
  }

  Widget distance(String title) {
    return Positioned(
        top: 490,
        left: 180,
        child: Container(
          padding: EdgeInsets.all(8),
          width: 190,
          height: 75,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [CommonStyles().green, CommonStyles().blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: FittedBox(
              child: Center(
                  child: Column(
            children: [
              Text(
                "Distance :",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Assistant", fontSize: 8),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontFamily: "Assistant"),
              ),
            ],
          ))),
        ));
  }

  Widget addition(String title) {
    return Positioned(
        top: 490,
        right: 179,
        child: Container(
          padding: EdgeInsets.all(8),
          width: 190,
          height: 75,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [CommonStyles().green, CommonStyles().blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: FittedBox(
              child: Center(
                  child: Column(
            children: [
              Text(
                "Addition :",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Assistant", fontSize: 8),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontFamily: "Assistant"),
              ),
            ],
          ))),
        ));
  }

  Widget type(String title) {
    return Positioned(
        top: 403,
        right: 46,
        child: Container(
          padding: EdgeInsets.all(8),
          width: 190,
          height: 75,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [CommonStyles().green, CommonStyles().blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: FittedBox(
              child: Center(
                  child: Column(
            children: [
              Text(
                "Type :",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Assistant", fontSize: 8),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontFamily: "Assistant"),
              ),
            ],
          ))),
        ));
  }

  Widget indice(String title) {
    return Positioned(
        top: 305,
        right: 46,
        child: Container(
          padding: EdgeInsets.all(8),
          width: 190,
          height: 75,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [CommonStyles().green, CommonStyles().blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: FittedBox(
              child: Center(
                  child: Column(
            children: [
              Text(
                "Indice :",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Assistant", fontSize: 8),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontFamily: "Assistant"),
              ),
            ],
          ))),
        ));
  }

  Widget categorie(String title) {
    return Positioned(
        top: 210,
        right: 46,
        child: Container(
          padding: EdgeInsets.all(8),
          width: 190,
          height: 75,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [CommonStyles().green, CommonStyles().blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: FittedBox(
              child: Center(
                  child: Column(
            children: [
              Text(
                "Categorie :",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Assistant", fontSize: 8),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontFamily: "Assistant"),
              ),
            ],
          ))),
        ));
  }

  Widget diametre(String title) {
    return Positioned(
        top: 115,
        right: 46,
        child: Container(
          padding: EdgeInsets.all(8),
          width: 190,
          height: 75,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [CommonStyles().green, CommonStyles().blue],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: FittedBox(
              child: Center(
                  child: Column(
            children: [
              Text(
                "Diametre :",
                style: TextStyle(
                    color: Colors.white, fontFamily: "Assistant", fontSize: 8),
              ),
              Text(
                title,
                style: TextStyle(color: Colors.white, fontFamily: "Assistant"),
              ),
            ],
          ))),
        ));
  }

  header(String header) {
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
          top: 30,
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
      Positioned(
          top: 30,
          right: 20,
          child: InkWell(
            onTap: () {
              if (controller.client.toString() != "registered") {
                Get.defaultDialog(
                  title: "Prix",
                  titleStyle: TextStyle(
                      color: CommonStyles().blue,
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Assistant"),
                  content: FutureBuilder(
                      future: DBProvider.db
                          .getAllVVerreprixbyid(controller.idverre.toInt()),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot2) {
                        if (snapshot2.hasData) {
                          if (snapshot2.data.isNotEmpty) {
                            {
                              return Container(
                                  margin: const EdgeInsets.only(
                                      left: 30, right: 30),
                                  height: 260,
                                  width: 800,
                                  child: Container(
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
                                                      .resolveWith<Color>((Set<
                                                              MaterialState>
                                                          states) {
                                            if (states.contains(
                                                MaterialState.selected))
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
                                                'SPH/CYL',
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
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0),
                                                    child: Text(
                                                      snapshot2.data[0].cYL,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Assistant",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CommonStyles()
                                                            .white,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4),
                                                    child: Text(
                                                      'Pas = ' +
                                                          snapshot2
                                                              .data[0].pasCYL,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Assistant",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CommonStyles()
                                                            .white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                            DataColumn(
                                                label: Center(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0),
                                                    child: Text(
                                                      snapshot2.data[1].cYL,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Assistant",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CommonStyles()
                                                            .white,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4),
                                                    child: Text(
                                                      snapshot2.data[1].pasCYL,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Assistant",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CommonStyles()
                                                            .white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                            DataColumn(
                                                label: Center(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0),
                                                    child: Text(
                                                      snapshot2.data[2].cYL,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Assistant",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CommonStyles()
                                                            .white,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4),
                                                    child: Text(
                                                      'Pas = ' +
                                                          snapshot2
                                                              .data[2].pasCYL,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Assistant",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CommonStyles()
                                                            .white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                            DataColumn(
                                                label: Center(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4.0),
                                                    child: Text(
                                                      snapshot2.data[3].cYL,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Assistant",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CommonStyles()
                                                            .white,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 4),
                                                    child: Text(
                                                      'Pas = ' +
                                                          snapshot2
                                                              .data[3].pasCYL,
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        fontFamily: "Assistant",
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: CommonStyles()
                                                            .white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                          ], rows: [
                                            DataRow(
                                              cells: [
                                                DataCell(
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 0.0),
                                                        child: Text(
                                                          snapshot2.data[0].sPH,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .green,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 0),
                                                        child: Text(
                                                          'Pas = ' +
                                                              snapshot2.data[0]
                                                                  .pasSPH,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .green,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                DataCell(Text(
                                                    snapshot2.data[0].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                                DataCell(Text(
                                                    snapshot2.data[1].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                                DataCell(Text(
                                                    snapshot2.data[2].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                                DataCell(Text(
                                                    snapshot2.data[3].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                              ],
                                            ),
                                            DataRow(
                                              cells: [
                                                DataCell(
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 0.0),
                                                        child: Text(
                                                          snapshot2.data[4].sPH,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .green,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 0),
                                                        child: Text(
                                                          'Pas = ' +
                                                              snapshot2.data[4]
                                                                  .pasSPH,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .green,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                DataCell(Text(
                                                    snapshot2.data[4].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                                DataCell(Text(
                                                    snapshot2.data[5].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                                DataCell(Text(
                                                    snapshot2.data[6].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                                DataCell(Text(
                                                    snapshot2.data[7].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                              ],
                                            ),
                                            DataRow(
                                              cells: [
                                                DataCell(
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 0.0),
                                                        child: Text(
                                                          snapshot2.data[8].sPH,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .green,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 0),
                                                        child: Text(
                                                          'Pas = ' +
                                                              snapshot2.data[8]
                                                                  .pasSPH,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .green,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                DataCell(Text(
                                                    snapshot2.data[8].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                                DataCell(Text(
                                                    snapshot2.data[9].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                                DataCell(Text(
                                                    snapshot2.data[10].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                                DataCell(Text(
                                                    snapshot2.data[11].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                              ],
                                            ),
                                            DataRow(
                                              cells: [
                                                DataCell(
                                                  Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 2.0),
                                                        child: Text(
                                                          snapshot2
                                                              .data[12].sPH,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .green,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 0),
                                                        child: Text(
                                                          'Pas = ' +
                                                              snapshot2.data[12]
                                                                  .pasSPH,
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .green,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                DataCell(Text(
                                                    snapshot2.data[12].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                                DataCell(Text(
                                                    snapshot2.data[13].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                                DataCell(Text(
                                                    snapshot2.data[14].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                                DataCell(Text(
                                                    snapshot2.data[15].prix
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily: "Assistant",
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600))),
                                              ],
                                            ),
                                          ]),
                                        ),
                                      ),
                                    ),
                                  ));
                            }
                          } else {
                            return Center(
                              child: Text("Aucun prix attribuee."),
                            );
                          }
                        } else if (snapshot2.hasError) {
                          print("snapshot2.error");
                          print(snapshot2.error.toString());
                          return Text("Erreur");
                        }
                        // By default, show a loading spinner.
                        return Center(child: CircularProgressIndicator());
                      }),
                );
              } else {
                print("Client = registred");
                int pgsph = 0;
                int pgcyl = 0;
                int jointurepg = 50;
                int pdsph = 0;
                int pdcyl = 0;
                int jointurepd = 50;
                int idsph = 0;
                int idcyl = 0;
                int jointureid = 50;
                int igsph = 0;
                int igcyl = 0;
                int jointureig = 50;
                int ldsph = 0;
                int ldcyl = 0;
                int jointureld = 50;
                int lgsph = 0;
                int lgcyl = 0;
                int jointurelg = 50;
                if (controller.PGSPH.toString() != "" &&
                    controller.PGCYL.toString() != "") {
                  print("In pgcyl");
                  pgcyl = getcase(controller.PGCYL.toString());
                  pgsph = getcase(controller.PGSPH.toString());
                  jointurepg = getcaseverte(pgsph, pgcyl);
                }
                if (controller.PDSPH.toString() != "" &&
                    controller.PDCYL.toString() != "") {
                  print("In pdcyl");
                  pdcyl = getcase(controller.PDCYL.toString());
                  pdsph = getcase(controller.PDSPH.toString());
                  jointurepd = getcaseverte(pdsph, pdcyl);
                }
                print("LGSPH=" +
                    controller.LGSPH.toString() +
                    " LGCYL = " +
                    controller.LGCYL.toString());
                if (controller.LGSPH.toString() != "" &&
                    controller.LGCYL.toString() != "") {
                  print("In lgsph");
                  lgcyl = getcase(controller.LGCYL.toString());
                  lgsph = getcase(controller.LGSPH.toString());
                  jointurelg = getcaseverte(lgsph, lgcyl);
                }
                if (controller.LDSPH.toString() != "" &&
                    controller.LDCYL.toString() != "") {
                  print("LDSPH");
                  print("LDSPH");
                  ldcyl = getcase(controller.LDCYL.toString());
                  ldsph = getcase(controller.LDSPH.toString());
                  jointureld = getcaseverte(ldsph, ldcyl);
                }
                Get.defaultDialog(
                  title: "Prix",
                  titleStyle: TextStyle(
                      color: CommonStyles().blue,
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Assistant"),
                  content: Column(
                    children: [
                      FutureBuilder(
                          future: DBProvider.db
                              .getAllVVerreprixbyid(controller.idverre.toInt()),
                          builder: (context,
                              AsyncSnapshot<List<dynamic>> snapshot2) {
                            if (snapshot2.hasData) {
                              if (snapshot2.data.isNotEmpty) {
                                {
                                  return Container(
                                      margin: const EdgeInsets.only(
                                          left: 30, right: 30),
                                      height: 260,
                                      width: 800,
                                      child: Container(
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
                                                          .resolveWith<
                                                              Color>((Set<
                                                                  MaterialState>
                                                              states) {
                                                if (states.contains(
                                                    MaterialState.selected))
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
                                                    'SPH/CYL',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: "Assistant",
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          CommonStyles().white,
                                                    ),
                                                  ),
                                                )),
                                                DataColumn(
                                                    label: Center(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 4.0),
                                                        child: Text(
                                                          snapshot2.data[0].cYL,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .white,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 4),
                                                        child: Text(
                                                          'Pas = ' +
                                                              snapshot2.data[0]
                                                                  .pasCYL,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                                DataColumn(
                                                    label: Center(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 4.0),
                                                        child: Text(
                                                          snapshot2.data[1].cYL,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .white,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 4),
                                                        child: Text(
                                                          snapshot2
                                                              .data[1].pasCYL,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                                DataColumn(
                                                    label: Center(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 4.0),
                                                        child: Text(
                                                          snapshot2.data[2].cYL,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .white,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 4),
                                                        child: Text(
                                                          'Pas = ' +
                                                              snapshot2.data[2]
                                                                  .pasCYL,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                                DataColumn(
                                                    label: Center(
                                                  child: Column(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 4.0),
                                                        child: Text(
                                                          snapshot2.data[3].cYL,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .white,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 4),
                                                        child: Text(
                                                          'Pas = ' +
                                                              snapshot2.data[3]
                                                                  .pasCYL,
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            fontFamily:
                                                                "Assistant",
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                CommonStyles()
                                                                    .white,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                              ], rows: [
                                                DataRow(
                                                  cells: [
                                                    DataCell(
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0.0),
                                                            child: Text(
                                                              snapshot2
                                                                  .data[0].sPH,
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    "Assistant",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    CommonStyles()
                                                                        .green,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0),
                                                            child: Text(
                                                              'Pas = ' +
                                                                  snapshot2
                                                                      .data[0]
                                                                      .pasSPH,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Assistant",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    CommonStyles()
                                                                        .green,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    datacelle(
                                                        snapshot2.data[0].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        0),
                                                    datacelle(
                                                        snapshot2.data[1].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        1),
                                                    datacelle(
                                                        snapshot2.data[2].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        2),
                                                    datacelle(
                                                        snapshot2.data[3].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        3),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0.0),
                                                            child: Text(
                                                              snapshot2
                                                                  .data[4].sPH,
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    "Assistant",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    CommonStyles()
                                                                        .green,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0),
                                                            child: Text(
                                                              'Pas = ' +
                                                                  snapshot2
                                                                      .data[4]
                                                                      .pasSPH,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Assistant",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    CommonStyles()
                                                                        .green,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    datacelle(
                                                        snapshot2.data[4].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        4),
                                                    datacelle(
                                                        snapshot2.data[5].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        5),
                                                    datacelle(
                                                        snapshot2.data[6].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        6),
                                                    datacelle(
                                                        snapshot2.data[7].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        7),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0.0),
                                                            child: Text(
                                                              snapshot2
                                                                  .data[8].sPH,
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    "Assistant",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    CommonStyles()
                                                                        .green,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0),
                                                            child: Text(
                                                              'Pas = ' +
                                                                  snapshot2
                                                                      .data[8]
                                                                      .pasSPH,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Assistant",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    CommonStyles()
                                                                        .green,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    datacelle(
                                                        snapshot2.data[8].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        8),
                                                    datacelle(
                                                        snapshot2.data[9].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        9),
                                                    datacelle(
                                                        snapshot2.data[10].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        10),
                                                    datacelle(
                                                        snapshot2.data[11].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        11),
                                                  ],
                                                ),
                                                DataRow(
                                                  cells: [
                                                    DataCell(
                                                      Column(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 2.0),
                                                            child: Text(
                                                              snapshot2
                                                                  .data[12].sPH,
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                fontFamily:
                                                                    "Assistant",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    CommonStyles()
                                                                        .green,
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    top: 0),
                                                            child: Text(
                                                              'Pas = ' +
                                                                  snapshot2
                                                                      .data[12]
                                                                      .pasSPH,
                                                              style: TextStyle(
                                                                fontSize: 16,
                                                                fontFamily:
                                                                    "Assistant",
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color:
                                                                    CommonStyles()
                                                                        .green,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    datacelle(
                                                        snapshot2.data[12].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        12),
                                                    datacelle(
                                                        snapshot2.data[13].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        13),
                                                    datacelle(
                                                        snapshot2.data[14].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        14),
                                                    datacelle(
                                                        snapshot2.data[15].prix
                                                            .toString(),
                                                        jointurepg,
                                                        jointurepd,
                                                        jointureid,
                                                        jointureig,
                                                        jointurelg,
                                                        jointureld,
                                                        15),
                                                  ],
                                                ),
                                              ]),
                                            ),
                                          ),
                                        ),
                                      ));
                                }
                              } else {
                                return Center(
                                  child: Text("Aucun prix attribuee."),
                                );
                              }
                            } else if (snapshot2.hasError) {
                              print("snapshot2.error");
                              print(snapshot2.error.toString());
                              return Text("Erreur");
                            }
                            // By default, show a loading spinner.
                            return Center(child: CircularProgressIndicator());
                          }),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 200,
                              child: Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          color: Colors.green,
                                          border:
                                              Border.all(color: Colors.black)),
                                    ),
                                    Text(
                                      " : VP - Oeil gauche",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          color: Colors.red[600],
                                          border:
                                              Border.all(color: Colors.black)),
                                    ),
                                    Text(
                                      " : VP - Oeil droite",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )
                              ]),
                            ),
                            Container(
                              width: 200,
                              child: Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          color: Colors.orange,
                                          border:
                                              Border.all(color: Colors.black)),
                                    ),
                                    Text(
                                      " : VI - Oeil gauche",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          color: Colors.deepPurple,
                                          border:
                                              Border.all(color: Colors.black)),
                                    ),
                                    Text(
                                      " : VI - Oeil droite",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )
                              ]),
                            ),
                            Container(
                              width: 200,
                              child: Column(children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          border:
                                              Border.all(color: Colors.black)),
                                    ),
                                    Text(
                                      " : VL - Oeil gauche",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 15,
                                      height: 15,
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent,
                                          border:
                                              Border.all(color: Colors.black)),
                                    ),
                                    Text(
                                      " : VL - Oeil droite",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600),
                                    )
                                  ],
                                )
                              ]),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
            },
            child: Container(
                height: 70,
                width: 70,
                decoration: CommonStyles.buttonDeco(),
                child: Icon(
                  Icons.attach_money_outlined,
                  color: Colors.white,
                  size: 40,
                )),
          )),
      Positioned(
          top: 30,
          right: 110,
          child: InkWell(
            onTap: () {
              Get.defaultDialog(
                title: "Traitements",
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
                content: FutureBuilder(
                    future: DBProvider.db.getAllTraitementsavecVerres2(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot2) {
                      if (snapshot2.hasData) {
                        return Container(
                          width: 600,
                          height: 400,
                          child: MaterialApp(
                              debugShowCheckedModeBanner: false,
                              home: gettabcontroller(snapshot2.data)),
                        );
                      } else if (snapshot2.hasError) {
                        print(snapshot2.error.toString());
                        return Text("Erreur");
                      }
                      // By default, show a loading spinner.
                      return Center(child: CircularProgressIndicator());
                    }),
              );
            },
            child: Container(
                height: 70,
                width: 70,
                decoration: CommonStyles.buttonDeco(),
                child: Icon(
                  Icons.description_outlined,
                  color: Colors.white,
                  size: 40,
                )),
          )),
    ]);
  }

  menu(int length) {
    return Container(
      height: 10,
      color: Colors.transparent,
      child: TabBar(
        unselectedLabelColor: Colors.transparent,
        indicatorColor: CommonStyles().blue,
        indicatorWeight: 3,
        indicatorPadding: EdgeInsets.all(0),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: gettabs(length),
      ),
    );
  }

  List<Widget> gettabs(int length) {
    List<Widget> liste = new List<Widget>();
    for (var i = 0; i < length; i++) {
      liste.add(
        Tab(
          text: "",
        ),
      );
    }
    return liste;
  }

  Widget gettabcontroller(List<TraitementJoinVerre2> list) {
    List<TraitementJoinVerre2> liste =
        getlistee(controller.idverre.toInt(), list);
    return DefaultTabController(
        length: liste.length,
        child: Container(
          child: Scaffold(
              backgroundColor: Colors.transparent,
              bottomNavigationBar: menu(liste.length),
              body: gettraitementsWidgets(liste)),
        ));
  }

  Widget traitement(String nom, String description, String gif) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          nom,
          style: TextStyle(
              foreground: Paint()..shader = CommonStyles().linearGradient,
              fontFamily: "Assistant",
              fontSize: 40,
              fontWeight: FontWeight.bold),
        ),
        FutureBuilder(
            future: getImage(gif),
            builder: (context, snapshoott) {
              if (snapshoott.hasData) {
                Uint8List bytes = base64Decode(snapshoott.data);
                return Container(
                  height: 300,
                  child: Image.memory(bytes),
                );
              } else
                return Center(child: CircularProgressIndicator());
            }),
      ],
    );
  }

  Widget gettraitementsWidgets(List<TraitementJoinVerre2> list) {
    List<Widget> liste = new List<Widget>();
    for (var i = 0; i < list.length; i++) {
      print("String =" + list[i].gif.toString());
      liste.add(traitement(list[i].nom, list[i].description, list[i].gif));
    }
    return new TabBarView(physics: ClampingScrollPhysics(), children: liste);
  }

  List<TraitementJoinVerre2> getlistee(
      int verreId, List<TraitementJoinVerre2> list) {
    List<TraitementJoinVerre2> listee = List<TraitementJoinVerre2>();
    for (var i = 0; i < list.length; i++) {
      if (list[i].verreId == verreId) {
        listee.add(list[i]);
      }
    }
    return listee;
  }

  int getcase(String string) {
    print("string =" + string);
    var stringg = double.tryParse(string.toString());
    int value = 0;
    if (0 < stringg && stringg < 2) {
      value = 1;
    } else {
      if (2 <= stringg && stringg < 4) {
        value = 2;
      } else {
        if (4 <= stringg && stringg < 6) {
          value = 3;
        } else {
          if (6 <= stringg && stringg < 8) {
            value = 4;
          }
        }
      }
    }
    return value;
  }

  int getcaseverte(int sph, int cyl) {
    int nb_case = 0;
    if (sph == 0 || cyl == 0) {
      nb_case = 50;
    } else {
      if (sph == 1) {
        if (cyl == 1) {
          nb_case = 0;
        } else {
          if (cyl == 2) {
            nb_case = 1;
          } else {
            if (cyl == 3) {
              nb_case = 2;
            } else {
              if (cyl == 4) {
                nb_case = 3;
              }
            }
          }
        }
      } else {
        if (sph == 2) {
          if (cyl == 1) {
            nb_case = 4;
          } else {
            if (cyl == 2) {
              nb_case = 5;
            } else {
              if (cyl == 3) {
                nb_case = 6;
              } else {
                if (cyl == 4) {
                  nb_case = 7;
                }
              }
            }
          }
        } else {
          if (sph == 3) {
            if (cyl == 1) {
              nb_case = 8;
            } else {
              if (cyl == 2) {
                nb_case = 9;
              } else {
                if (cyl == 3) {
                  nb_case = 10;
                } else {
                  if (cyl == 4) {
                    nb_case = 11;
                  }
                }
              }
            }
          } else {
            if (sph == 4) {
              if (cyl == 1) {
                nb_case = 12;
              } else {
                if (cyl == 2) {
                  nb_case = 13;
                } else {
                  if (cyl == 3) {
                    nb_case = 14;
                  } else {
                    if (cyl == 4) {
                      nb_case = 15;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }

    return nb_case;
  }

  DataCell datacelle(String prix, int caseverte, int case_rouge, case_move,
      case_orange, case_marron, case_bleu, int nb_case) {
    print(" numero de la case = " +
        nb_case.toString() +
        " case marron = " +
        case_marron.toString() +
        " case bleu = " +
        case_bleu.toString());
    if (nb_case == caseverte) {
      return DataCell(Text(prix,
          style: TextStyle(
              fontSize: 19,
              fontFamily: "Assistant",
              color: Colors.green,
              fontWeight: FontWeight.bold)));
    } else {
      if (nb_case == case_rouge) {
        return DataCell(Text(prix,
            style: TextStyle(
                fontSize: 19,
                fontFamily: "Assistant",
                color: Colors.red,
                fontWeight: FontWeight.bold)));
      } else {
        if (nb_case == case_move) {
          return DataCell(Text(prix,
              style: TextStyle(
                  fontSize: 19,
                  fontFamily: "Assistant",
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold)));
        } else {
          if (nb_case == case_orange) {
            return DataCell(Text(prix,
                style: TextStyle(
                    fontSize: 19,
                    fontFamily: "Assistant",
                    color: Colors.orange,
                    fontWeight: FontWeight.bold)));
          } else {
            if (nb_case == case_bleu) {
              return DataCell(Text(prix,
                  style: TextStyle(
                      fontSize: 19,
                      fontFamily: "Assistant",
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold)));
            } else {
              if (nb_case == case_marron) {
                return DataCell(Text(prix,
                    style: TextStyle(
                        fontSize: 19,
                        fontFamily: "Assistant",
                        color: Colors.yellow,
                        fontWeight: FontWeight.bold)));
              } else {
                return DataCell(Text(prix,
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: "Assistant",
                        color: Colors.black,
                        fontWeight: FontWeight.w600)));
              }
            }
          }
        }
      }
    }
  }
}
