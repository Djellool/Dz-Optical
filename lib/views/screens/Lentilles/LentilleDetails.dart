import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eos/provider/GeneralProvider.dart';
import 'package:eos/provider/db_provider.dart';
import 'package:eos/views/components/CommonStyles.dart';
import 'package:path_provider/path_provider.dart';

class LentilleDetails extends StatefulWidget {
  @override
  _LentilleDetailsState createState() => _LentilleDetailsState();
}

class _LentilleDetailsState extends State<LentilleDetails> {
  var controller = Get.put(GeneralProvider());
  bool stock = true;

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

  @override
  void dispose() {
    print("Disposing");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Id lentille = " + controller.idlentille.toString());
    return Scaffold(
      body: FutureBuilder(
          future:
              DBProvider.db.getLentillebyId(controller.idlentille.toString()),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData) {
              return Stack(alignment: Alignment.topCenter, children: [
                Image.asset(
                  "assets/images/background_lentille.PNG",
                  fit: BoxFit.fill,
                ),
                header(""),
                Positioned(
                  top: 197,
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
                              borderRadius: new BorderRadius.all(
                                  new Radius.circular(270)),
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
                origine(snapshot.data[0].origine.toString()),
                marque(snapshot.data[0].marque.toString()),
                modele(snapshot.data[0].modele),
                matiere(snapshot.data[0].matiere),
                diametre(snapshot.data[0].diametre.toString()),
                type(snapshot.data[0].niveau0.toString()),
                rayon(snapshot.data[0].rayon.toString()),
              ]);
            } else if (snapshot.hasError) {
              print(snapshot.error.toString());
              return Text("Erreur");
            }
            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  Widget origine(String title) {
    return Positioned(
        top: 125,
        left: 80,
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
        top: 235,
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

  Widget modele(String title) {
    return Positioned(
        top: 400,
        left: 50,
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
                "Modele : ",
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
        top: 508,
        left: 380,
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
                "Matiere :",
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
        top: 400,
        right: 50,
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

  Widget rayon(String title) {
    return Positioned(
        top: 235,
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
                "Rayon :",
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
        top: 125,
        right: 80,
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
                      future: DBProvider.db.getAlllentilleprixbyid(
                          controller.idlentille.toInt()),
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
                int lgsph = 0;
                int lgcyl = 0;
                int jointurelg = 50;
                int ldsph = 0;
                int ldcyl = 0;
                int jointureld = 50;
                print("ldSPH =" +
                    controller.lDSPH.toString() +
                    " lDCYL = " +
                    controller.lDCYL.toString());
                if (controller.lGSPH.toString() != "" &&
                    controller.lGCYL.toString() != "") {
                  lgcyl = getcase(controller.lGCYL.toString());
                  lgsph = getcase(controller.lGSPH.toString());
                  jointurelg = getcaseverte(lgsph, lgcyl);
                }
                if (controller.lDSPH.toString() != "" &&
                    controller.lDCYL.toString() != "") {
                  ldcyl = getcase(controller.PDCYL.toString());
                  ldsph = getcase(controller.PDSPH.toString());
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
                          future: DBProvider.db.getAlllentilleprixbyid(
                              controller.idlentille.toInt()),
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
                                                        jointurelg,
                                                        jointureld,
                                                        0),
                                                    datacelle(
                                                        snapshot2.data[1].prix
                                                            .toString(),
                                                        jointurelg,
                                                        jointureld,
                                                        1),
                                                    datacelle(
                                                        snapshot2.data[2].prix
                                                            .toString(),
                                                        jointurelg,
                                                        jointureld,
                                                        2),
                                                    datacelle(
                                                        snapshot2.data[3].prix
                                                            .toString(),
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
                                                        jointurelg,
                                                        jointureld,
                                                        4),
                                                    datacelle(
                                                        snapshot2.data[5].prix
                                                            .toString(),
                                                        jointurelg,
                                                        jointureld,
                                                        5),
                                                    datacelle(
                                                        snapshot2.data[6].prix
                                                            .toString(),
                                                        jointurelg,
                                                        jointureld,
                                                        6),
                                                    datacelle(
                                                        snapshot2.data[7].prix
                                                            .toString(),
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
                                                        jointurelg,
                                                        jointureld,
                                                        8),
                                                    datacelle(
                                                        snapshot2.data[9].prix
                                                            .toString(),
                                                        jointurelg,
                                                        jointureld,
                                                        9),
                                                    datacelle(
                                                        snapshot2.data[10].prix
                                                            .toString(),
                                                        jointurelg,
                                                        jointureld,
                                                        10),
                                                    datacelle(
                                                        snapshot2.data[11].prix
                                                            .toString(),
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
                                                        jointurelg,
                                                        jointureld,
                                                        12),
                                                    datacelle(
                                                        snapshot2.data[13].prix
                                                            .toString(),
                                                        jointurelg,
                                                        jointureld,
                                                        13),
                                                    datacelle(
                                                        snapshot2.data[14].prix
                                                            .toString(),
                                                        jointurelg,
                                                        jointureld,
                                                        14),
                                                    datacelle(
                                                        snapshot2.data[15].prix
                                                            .toString(),
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
                        child: Center(
                          child: Container(
                            width: 600,
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
                                    " : Oeil gauche",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
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
                                    " : Oeil droite",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  )
                                ],
                              )
                            ]),
                          ),
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
    ]);
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

  DataCell datacelle(String prix, int caseverte, case_move, int nb_case) {
    print(" numero de la case = " +
        nb_case.toString() +
        " case m = " +
        caseverte.toString() +
        " case move = " +
        case_move.toString());
    if (nb_case == caseverte) {
      return DataCell(Text(prix,
          style: TextStyle(
              fontSize: 19,
              fontFamily: "Assistant",
              color: Colors.green,
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
