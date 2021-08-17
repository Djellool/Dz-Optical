import 'dart:convert';
import 'dart:io';

import 'package:eos/provider/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:eos/Icons/la_classe_chikoura_icons.dart';
import 'package:eos/Models/TraitementJoinVerre.dart';
import 'package:eos/Models/Verre.dart';
import 'package:eos/provider/GeneralProvider.dart';
import 'package:eos/provider/db_provider.dart';
import 'package:eos/views/components/CommonStyles.dart';
import 'package:path_provider/path_provider.dart';

import 'Rechercheverre.dart';
import 'VerresDetails.dart';

class Stock extends StatefulWidget {
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> with TickerProviderStateMixin {
  final Color blue = Color(0xFF041E59);
  final Color green = Color(0xFF01AFB5);
  var controller = Get.put(GeneralProvider());

  List<Widget> listee = new List<Widget>();

  var scaffoldKey = GlobalKey<ScaffoldState>();

  AnimationController _controller;
  Animation<Offset> _animation;

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
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1400),
      vsync: this,
    )..forward();

    _animation = Tween<Offset>(
      begin: const Offset(3, 0.0),
      end: const Offset(-0.1, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        controller.path.removeLast();
        Get.back();
      },
      child: Scaffold(
        key: scaffoldKey,
        endDrawer: NavDrawer(),
        body: FutureBuilder(
            future: Future.wait([
              DBProvider.db.getAllVerreslevel(controller.path.length,
                  controller.path.first, controller.path.last),
              DBProvider.db.getAllTraitementsavecVerres(),
            ]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return Stack(alignment: Alignment.topCenter, children: [
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      "assets/images/background.PNG",
                      fit: BoxFit.fill,
                    ),
                  ),
                  header(),
                  Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                          height: 70,
                          width: 70,
                          decoration: CommonStyles.buttonDeco(),
                          child: IconButton(
                            onPressed: () =>
                                scaffoldKey.currentState.openEndDrawer(),
                            icon: Icon(
                              LaClasseChikoura.sliders,
                              color: Colors.white,
                              size: 40,
                            ),
                          ))),
                  (() {
                    switch (controller.path.length) {
                      case 1:
                        {
                          return lvl1();
                        }

                      case 2:
                        {
                          return lvl2();
                        }
                        break;
                      case 3:
                        {
                          return lvl3();
                        }
                        break;
                    }
                  }()),
                  Positioned(
                    top: 230,
                    left: 20,
                    child: Container(
                      width: 900,
                      height: 360,
                      child: ShaderMask(
                        shaderCallback: (Rect rect) {
                          return LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              green,
                              Colors.transparent,
                              Colors.transparent,
                              blue
                            ],
                            stops: [
                              0.0,
                              0.10,
                              0.90,
                              1.0
                            ], // 10% purple, 80% transparent, 10% purple
                          ).createShader(rect);
                        },
                        blendMode: BlendMode.dstOut,
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          padding: EdgeInsets.all(10),
                          scrollDirection: Axis.horizontal,
                          itemCount: snapshot.data[0].length + 2,
                          itemBuilder: (context, int index) {
                            if (index == 0 ||
                                index == snapshot.data[0].length + 1) {
                              return Opacity(
                                  opacity: 0,
                                  child: Container(
                                    width: 100,
                                  ));
                            } else {
                              return verre(snapshot.data[0][index - 1],
                                  snapshot.data[1]);
                            }
                          },
                          separatorBuilder: (context, index) =>
                              VerticalDivider(),
                        ),
                      ),
                    ),
                  ),
                ]);
              } else if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Text("Erreur");
              }
              // By default, show a loading spinner.
              return Center(child: CircularProgressIndicator());
            }),
      ),
    );
  }

  Widget header() {
    return Stack(alignment: Alignment.topCenter, children: [
      Positioned(
        top: 20,
        left: 20,
        child: Row(
          children: [
            (() {
              if (controller.path.length == 1) {
                return header1();
              }
              if (controller.path.length == 2) {
                return header2();
              }
              if (controller.path.length == 3) {
                return header3();
              }
            }())
          ],
        ),
      ),
    ]);
  }

  Widget header1() {
    return Row(children: [
      InkWell(
        onTap: () {
          controller.path.removeLast();
          Get.back();
        },
        child: Container(
            height: 70,
            width: 70,
            decoration: CommonStyles.buttonDeco(),
            child: Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 40,
            )),
      ),
      Icon(
        Icons.arrow_forward_ios_outlined,
        color: CommonStyles().grey,
      ),
      Text(
        controller.path.last,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            foreground: Paint()..shader = CommonStyles().linearGradient,
            fontSize: 55,
            fontFamily: "Assistant"),
      ),
    ]);
  }

  Widget header2() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            controller.path.removeLast();
            controller.path.removeLast();
            Get.back();
            Get.back();
          },
          child: Container(
              height: 70,
              width: 70,
              decoration: CommonStyles.buttonDeco(),
              child: Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 40,
              )),
        ),
        Icon(
          Icons.arrow_forward_ios_outlined,
          color: CommonStyles().grey,
        ),
        InkWell(
            onTap: () {
              controller.path.removeLast();
              Get.back();
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: CommonStyles.buttonDeco(),
              child: Center(
                child: Text("Stck",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Nunito",
                        fontSize: 25,
                        fontWeight: FontWeight.w600)),
              ),
            )),
        Icon(
          Icons.arrow_forward_ios_outlined,
          color: CommonStyles().grey,
        ),
        Text(
          controller.path.last,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              foreground: Paint()..shader = CommonStyles().linearGradient,
              fontSize: 55,
              fontFamily: "Assistant"),
        ),
      ],
    );
  }

  Widget header3() {
    return Row(
      children: [
        InkWell(
          onTap: () {
            controller.path.removeLast();
            controller.path.removeLast();
            controller.path.removeLast();
            Get.back();
            Get.back();
            Get.back();
          },
          child: Container(
              height: 70,
              width: 70,
              decoration: CommonStyles.buttonDeco(),
              child: Icon(
                Icons.home_outlined,
                color: Colors.white,
                size: 40,
              )),
        ),
        Icon(
          Icons.arrow_forward_ios_outlined,
          color: CommonStyles().grey,
        ),
        InkWell(
            onTap: () {
              controller.path.removeLast();
              controller.path.removeLast();
              Get.back();
              Get.back();
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: CommonStyles.buttonDeco(),
              child: Center(
                child: Text("Stck",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Nunito",
                        fontSize: 25,
                        fontWeight: FontWeight.w600)),
              ),
            )),
        Icon(
          Icons.arrow_forward_ios_outlined,
          color: CommonStyles().grey,
        ),
        InkWell(
            onTap: () {
              controller.path.removeLast();
              Get.back();
            },
            child: Container(
              height: 70,
              width: 70,
              decoration: CommonStyles.buttonDeco(),
              child: Center(
                child: Text(
                    (() {
                      switch (controller.path.elementAt(1)) {
                        case "Blanc":
                          return "Blc";
                          break;
                        case "Photocromique":
                          return "Phc";
                          break;
                        case "Solaire":
                          return "Sol";
                          break;
                        case "Anti Fatigue":
                          return "A.F";
                          break;
                        default:
                      }
                    }()),
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Nunito",
                        fontSize: 25,
                        fontWeight: FontWeight.w600)),
              ),
            )),
        Icon(
          Icons.arrow_forward_ios_outlined,
          color: CommonStyles().grey,
        ),
        Text(
          controller.path.last,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              foreground: Paint()..shader = CommonStyles().linearGradient,
              fontSize: 55,
              fontFamily: "Assistant"),
        ),
      ],
    );
  }

  Widget lvl1() {
    return Positioned(
        top: 135,
        child: Row(
          children: [
            FlatButton(
              onPressed: () {
                controller.path.add("Blanc");
                Get.to(Stock());
              },
              padding: EdgeInsets.all(0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                width: 220,
                height: 75,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [green, blue])),
                child: Center(
                    child: Text(
                  "Blanc",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Assistant",
                      fontSize: 35,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ),
            FlatButton(
              onPressed: () {
                controller.path.add("Photocromique");
                Get.to(Stock());
              },
              padding: EdgeInsets.all(0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                width: 220,
                height: 75,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [green, blue])),
                child: Center(
                    child: Text(
                  "Photocromique",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Assistant",
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ),
            FlatButton(
              onPressed: () {
                controller.path.add("Solaire");
                Get.to(Stock());
              },
              padding: EdgeInsets.all(0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                width: 220,
                height: 75,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [green, blue])),
                child: Center(
                    child: Text(
                  "Solaire",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Assistant",
                      fontSize: 35,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ),
          ],
        ));
  }

  Widget lvl2() {
    return Positioned(
        top: 135,
        child: Row(
          children: [
            FlatButton(
              onPressed: () {
                controller.path.add("Haut de gamme");
                Get.to(() => Stock());
              },
              padding: EdgeInsets.all(0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 75,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [green, blue])),
                child: Center(
                    child: Text(
                  "Haut de gamme",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Assistant",
                      fontSize: 35,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ),
            FlatButton(
              onPressed: () {
                controller.path.add("Moyen de gamme");
                Get.to(() => Stock());
              },
              padding: EdgeInsets.all(0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 75,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [green, blue])),
                child: Center(
                    child: Text(
                  "Moyen de gamme",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Assistant",
                      fontSize: 30,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ),
            FlatButton(
              onPressed: () {
                controller.path.add("Entée de gamme");
                Get.to(() => Stock());
              },
              padding: EdgeInsets.all(0),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 75,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [green, blue])),
                child: Center(
                    child: Text(
                  "Entrée de gamme",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Assistant",
                      fontSize: 35,
                      fontWeight: FontWeight.w600),
                )),
              ),
            ),
          ],
        ));
  }

  Widget lvl3() {
    return Container();
  }

  Widget menu() {
    if (listee.isEmpty) {
      return Container(
        height: 10,
        color: Colors.transparent,
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.transparent,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          indicatorPadding: EdgeInsets.all(0),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              text: "",
            ),
          ],
        ),
      );
    } else {
      return Container(
        height: 10,
        color: Colors.transparent,
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.transparent,
          indicatorColor: Colors.white,
          indicatorWeight: 3,
          indicatorPadding: EdgeInsets.all(0),
          indicatorSize: TabBarIndicatorSize.tab,
          tabs: [
            Tab(
              text: "",
            ),
            Tab(
              text: "",
            ),
          ],
        ),
      );
    }
  }

  Widget verre(Verre verre, List<TraitementJoinVerre> list) {
    getlistee(verre.id, list);
    return SlideTransition(
      position: _animation,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          controller.idverre = verre.id.obs;
          Get.to(() => VerreDetail());
        },
        child: Container(
          padding: EdgeInsets.all(10),
          width: 250,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [green, blue])),
          child: Column(
            children: [
              Image.asset("assets/images/glasses.jpg"),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  verre.nomCommercial,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Assitant",
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Divider(
                color: Colors.white,
              ),
              Container(
                width: 240,
                height: 100,
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: tabbarcontroller(verre.id, list),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget caracteristique(double rating, String caract) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "$caract :",
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontFamily: "Assitant",
              fontWeight: FontWeight.w500),
        ),
        RatingBar.builder(
          ignoreGestures: true,
          unratedColor: Colors.transparent,
          itemSize: 15,
          initialRating: rating,
          direction: Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            size: 2,
            color: Colors.white,
          ),
          onRatingUpdate: null,
        )
      ],
    );
  }

  Widget gettraitementsWidgets(int verreId, List<TraitementJoinVerre> list) {
    listee.clear();
    List<Widget> liste = new List<Widget>();
    for (var i = 0; i < list.length; i++) {
      if (list[i].verreId == verreId) {
        if (liste.length < 5) {
          liste.add(caracteristique(list[i].note.toDouble(), list[i].nom));
        } else {
          listee.add(caracteristique(list[i].note.toDouble(), list[i].nom));
        }
      }
    }
    return new Column(children: liste);
  }

  void getlistee(int verreId, List<TraitementJoinVerre> list) {
    List<Widget> liste = new List<Widget>();
    for (var i = 0; i < list.length; i++) {
      if (list[i].verreId == verreId) {
        if (liste.length < 5) {
          liste.add(caracteristique(list[i].note.toDouble(), list[i].nom));
        } else {
          listee.add(caracteristique(list[i].note.toDouble(), list[i].nom));
        }
      }
    }
  }

  Widget tabbarcontroller(int id, List<TraitementJoinVerre> list) {
    if (listee.isEmpty) {
      return DefaultTabController(
        length: 1,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: menu(),
          body: TabBarView(physics: ClampingScrollPhysics(), children: [
            gettraitementsWidgets(id, list),
          ]),
        ),
      );
    } else {
      return DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          bottomNavigationBar: menu(),
          body: TabBarView(physics: ClampingScrollPhysics(), children: [
            gettraitementsWidgets(id, list),
            gettraitementsWidgets2(),
          ]),
        ),
      );
    }
  }

  Widget gettraitementsWidgets2() {
    return new Column(children: listee);
  }
}

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
