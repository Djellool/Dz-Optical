import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:eos/Models/Lentille.dart';
import 'package:eos/Models/LentillePrix.dart';
import 'package:eos/Models/Magasin.dart';
import 'package:eos/Models/Marque.dart';
import 'package:eos/Models/Traitement.dart';
import 'package:eos/Models/TraitementLentille.dart';
import 'package:eos/Models/TraitementVerre.dart';
import 'package:eos/Models/Verre.dart';
import 'package:eos/Models/VerrePrix.dart';
import 'package:eos/provider/db_provider.dart';

class ApiProvider {
  var apiurl = "http://app.dz-fashion-glasses.dz/api";

  Future<List<Magasin>> getAllMagasins() async {
    Response response = await Dio().get(apiurl + "/Magasin");

    return (response.data as List).map((magasin) {
      DBProvider.db.createMagasin(Magasin.fromJson(magasin));
    }).toList();
  }

  Future<void> getAllVerres() async {
    Response response = await Dio().get(apiurl + "/Verre");
    print('aftev response');

    await Stream.fromIterable((jsonDecode(response.data.toString()) as List))
        .asyncMap((verre) async {
      await DBProvider.db.createVerre(Verre.fromJson(verre));
    }).toList();
  }

  Future<List<Marque>> getAllMarques() async {
    Response response = await Dio().get(apiurl + "/Marque");

    return (response.data as List).map((marque) {
      DBProvider.db.createMarque(Marque.fromJson(marque));
    }).toList();
  }

  Future<void> getAllLentilles() async {
    Response response = await Dio().get(apiurl + "/Lentille");

    await Stream.fromIterable((jsonDecode(response.data.toString()) as List))
        .asyncMap((lentille) async {
      await DBProvider.db.createLentille(Lentille.fromJson(lentille));
    }).toList();
  }

  Future<void> getAllTraitements() async {
    Response response = await Dio().get(apiurl + "/Traitement");
    await Stream.fromIterable((jsonDecode(response.data.toString()) as List))
        .asyncMap((traitement) async {
      await DBProvider.db.createTraitement(Traitement.fromJson(traitement));
    }).toList();
  }

  Future<List<Traitement>> getAllTraitementsVerres() async {
    Response response = await Dio().get(apiurl + "/TraitementVerre");

    return (response.data as List).map((traitement) {
      DBProvider.db.createTraitementVerre(TraitementVerre.fromJson(traitement));
    }).toList();
  }

  Future<List<LentillePrix>> getAllLentillesPrix() async {
    Response response = await Dio().get(apiurl + "/LentillePrix");

    return (response.data as List).map((traitement) {
      DBProvider.db.createLentillePrix(LentillePrix.fromJson(traitement));
    }).toList();
  }

  Future<List<Traitement>> getAllVerresPrix() async {
    Response response = await Dio().get(apiurl + "/VerrePrix");

    return (response.data as List).map((traitement) {
      DBProvider.db.createVerrePrix(VerrePrix.fromJson(traitement));
    }).toList();
  }

  Future<List<TraitementLentille>> getAllTraitementsLentilles() async {
    Response response = await Dio().get(apiurl + "/TraitementLentille");

    return (response.data as List).map((traitement) {
      DBProvider.db
          .createTraitementLentille(TraitementLentille.fromJson(traitement));
    }).toList();
  }
}
