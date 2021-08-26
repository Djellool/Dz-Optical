import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:eos/Models/Lentille.dart';
import 'package:eos/Models/TraitementJoinLentille.dart';
import 'package:eos/provider/GeneralProvider.dart';
import 'package:eos/provider/db_provider.dart';
import 'package:eos/views/components/CommonStyles.dart';

import 'LentilleDetails.dart';
import 'ThirdLevel.dart';

class SecondLevel extends StatefulWidget {
  @override
  _SecondLevelState createState() => _SecondLevelState();
}

class _SecondLevelState extends State<SecondLevel>
    with TickerProviderStateMixin {
  final Color blue = Color(0xFF041E59);
  final Color green = Color(0xFF01AFB5);
  final int itemCount = 5;
  var controller = Get.put(GeneralProvider());

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
      begin: const Offset(2.5, 0.0),
      end: const Offset(-0.2, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    ));
  }

  @override
  Widget build(BuildContext context) {
    print("level 2");

    print(controller.path.toString());

    return WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        Get.back();
        controller.path.removeLast();
      },
      child: Scaffold(
        body: FutureBuilder(
            future: Future.wait([
              DBProvider.db
                  .getAllLentillessecondlevel(controller.path.last.toString()),
              DBProvider.db.getAllTraitementsavecLentilles(),
              DBProvider.db.getLentilleNiveau1(controller.path[0])
            ]),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData && snapshot.data[0].isNotEmpty) {
                print("Nb_Lentille = " + snapshot.data[0].length.toString());
                return Stack(alignment: Alignment.topCenter, children: [
                  Image.asset(
                    "assets/images/background.PNG",
                    fit: BoxFit.fill,
                  ),
                  header(),
                  Positioned(
                      top: 135,
                      child: Container(
                        height: 100,
                        width: 600,
                        child: Center(
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data[2].length,
                            itemBuilder: (context, int index) {
                              if (snapshot.data[2][index] != null) {
                                if (snapshot.data[2][index].isNotEmpty)
                                  return niveau1(snapshot.data[2][index]);
                              } else
                                return null;
                              return null;
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: 5,
                            ),
                          ),
                        ),
                      )),
                  Positioned(
                    top: 230,
                    left: 20,
                    child: Container(
                      width: 900,
                      height: 370,
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
              } else if (snapshot.hasData) {
                return Stack(alignment: Alignment.topCenter, children: [
                  Image.asset(
                    "assets/images/background.PNG",
                    fit: BoxFit.fill,
                  ),
                  header(),
                  Positioned(
                      top: 135,
                      child: Container(
                        height: 100,
                        width: 600,
                        child: Center(
                          child: ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data[2].length,
                            itemBuilder: (context, int index) {
                              if (snapshot.data[2][index] != null) {
                                if (snapshot.data[2][index].isNotEmpty)
                                  return niveau1(snapshot.data[2][index]);
                              } else
                                return null;
                            },
                            separatorBuilder: (context, index) => SizedBox(
                              width: 5,
                            ),
                          ),
                        ),
                      )),
                ]);
              } else {
                if (snapshot.hasError) {
                  return Text("Erreur");
                }
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
          children: [header1()],
        ),
      ),
    ]);
  }

  Widget header1() {
    return Row(children: [
      InkWell(
        onTap: () {
          Get.back();
          controller.path.removeLast();
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

  Widget verre(Lentille lentille, List<TraitementJoinLentille> list) {
    return SlideTransition(
      position: _animation,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        onPressed: () {
          controller.idlentille = lentille.id.obs;
          Get.to(() => LentilleDetails());
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
              Image.asset("assets/images/lenses.jpg"),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  lentille.modele.toString(),
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
                  height: 115,
                  child: gettraitementsWidgets(lentille.id, list)),
            ],
          ),
        ),
      ),
    );
  }

  Widget gettraitementsWidgets(
      int lentilleId, List<TraitementJoinLentille> list) {
    List<Widget> liste = new List<Widget>();
    for (var i = 0; i < list.length; i++) {
      if (list[i].lentilleId == lentilleId) {
        if (liste.length < 6) {
          liste.add(caracteristique(list[i].note.toDouble(), list[i].nom));
        }
      }
    }
    return new Column(children: liste);
  }

  Widget caracteristique(double rating, String caract) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FittedBox(
          child: Text(
            "$caract :",
            style: TextStyle(
                color: Colors.white,
                fontFamily: "Assitant",
                fontWeight: FontWeight.w500),
          ),
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
            color: Colors.amber,
          ),
          onRatingUpdate: null,
        )
      ],
    );
  }

  Widget niveau1(String niveau1) {
    return FlatButton(
      onPressed: () {
        controller.path.add(niveau1);
        Get.to(ThirdLevel());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        height: 75,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [green, blue])),
        child: Center(
            child: Text(
          niveau1,
          style: TextStyle(
              color: Colors.white,
              fontFamily: "Assistant",
              fontSize: 35,
              fontWeight: FontWeight.w600),
        )),
      ),
    );
  }
}
