import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:eos/Icons/la_classe_chikoura_icons.dart';
import 'package:eos/Models/TraitementJoinVerre.dart';
import 'package:eos/Models/Verre.dart';
import 'package:eos/provider/GeneralProvider.dart';
import 'package:eos/provider/db_provider.dart';
import 'package:eos/views/components/CommonStyles.dart';
import 'package:eos/views/components/Header.dart';
import 'package:eos/views/screens/Verres/Fabrication.dart';
import 'package:eos/views/screens/Verres/Stock.dart';
import 'Rechercheverre.dart';
import 'VerresDetails.dart';

class Verres extends StatefulWidget {
  @override
  _VerresState createState() => _VerresState();
}

class _VerresState extends State<Verres> with TickerProviderStateMixin {
  final Color blue = Color(0xFF041E59);
  final Color green = Color(0xFF01AFB5);
  var controller = Get.put(GeneralProvider());
  List<Widget> listee = new List<Widget>();

  AnimationController _controller;

  Animation<Offset> _animation;

  Future<List<dynamic>> future1;
  Future<List<dynamic>> future2;
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
    future1 = DBProvider.db.getAllVerres();
    future2 = DBProvider.db.getAllTraitementsavecVerres();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("building verre");
    return Scaffold(
      key: scaffoldKey,
      endDrawer: NavDrawer(),
      body: FutureBuilder(
          future: Future.wait([future1, future2]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData && snapshot.data[0].isNotEmpty) {
              print("Nb_Verre =" + snapshot.data[0].length.toString());
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      "assets/images/background.PNG",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Header().header("Verres"),
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
                  Positioned(
                      top: 135,
                      child: Row(
                        children: [
                          FlatButton(
                            onPressed: () {
                              controller.path.add("Fabrication");
                              Get.to(() => Fabrication());
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              width: 200,
                              height: 75,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [green, blue])),
                              child: Center(
                                  child: Text(
                                "Fabrication",
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
                              controller.path.add("Stock");
                              Get.to(() => Stock());
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              width: 200,
                              height: 75,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [green, blue])),
                              child: Center(
                                  child: Text(
                                "Stock",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Assistant",
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                          ),
                        ],
                      )),
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
                ],
              );
            } else if (snapshot.hasData) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  Positioned(
                    top: -100,
                    child: Image.asset(
                      "assets/images/background.PNG",
                      fit: BoxFit.fill,
                    ),
                  ),
                  Header().header("Verres"),
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
                  Positioned(
                      top: 135,
                      child: Row(
                        children: [
                          FlatButton(
                            onPressed: () {
                              controller.path.add("Fabrication");
                              Get.to(() => Fabrication());
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              width: 200,
                              height: 75,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [green, blue])),
                              child: Center(
                                  child: Text(
                                "Fabrication",
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
                              controller.path.add("Stock");
                              Get.to(() => Stock());
                            },
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8),
                              width: 200,
                              height: 75,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [green, blue])),
                              child: Center(
                                  child: Text(
                                "Stock",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Assistant",
                                    fontSize: 35,
                                    fontWeight: FontWeight.w600),
                              )),
                            ),
                          ),
                        ],
                      )),
                ],
              );
            } else {
              if (snapshot.hasError) {
                return Text("Erreur");
              }
            }
            // By default, show a loading spinner.
            return Center(child: CircularProgressIndicator());
          }),
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
    print("Verre.id = " + verre.id.toString());
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