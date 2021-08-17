import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:eos/Models/TraitementJoinVerre.dart';
import 'package:eos/Models/Verre.dart';
import 'package:eos/provider/GeneralProvider.dart';
import 'package:eos/provider/db_provider.dart';
import 'package:eos/views/components/CommonStyles.dart';
import 'package:eos/views/components/Header.dart';

import 'VerresDetails.dart';

class RerchercheClasse extends StatefulWidget {
  @override
  _RerchercheClasseState createState() => _RerchercheClasseState();
}

class _RerchercheClasseState extends State<RerchercheClasse>
    with TickerProviderStateMixin {
  final Color blue = Color(0xFF041E59);
  final Color green = Color(0xFF01AFB5);
  var controller = Get.put(GeneralProvider());
  List<Widget> listee = new List<Widget>();

  AnimationController _controller;

  Animation<Offset> _animation;

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

  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    print("Origine = " + controller.origine.toString());
    print("Matiere = " + controller.matiere.toString());
    print("recherche = " + controller.recherche.toString());
    return Scaffold(
      key: scaffoldKey,
      body: FutureBuilder(
          future: Future.wait([
            DBProvider.db.getVerrebyfiltre(controller.recherche.toString(),
                controller.origine.toString(), controller.matiere.toString()),
            DBProvider.db.getAllTraitementsavecVerres(),
          ]),
          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
            if (snapshot.hasData && snapshot.data[0].isNotEmpty) {
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
                  Header().header("Recherche"),
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
                          itemCount: snapshot.data.length + 2,
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
                  Header().header("Recherche"),
                  Positioned(
                      top: 200,
                      child: Center(
                        child: Text(
                          "Aucun Resultat trouve pour ces criteres",
                          style: TextStyle(
                              color: CommonStyles().blue,
                              fontSize: 45,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Assistant"),
                        ),
                      )),
                ],
              );
            } else {
              if (snapshot.hasError) {
                return Text(
                  "Erreur",
                  style: TextStyle(
                      color: CommonStyles().blue,
                      fontSize: 45,
                      fontWeight: FontWeight.w600,
                      fontFamily: "Assistant"),
                );
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
