import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:eos/Models/Lentille.dart';
import 'package:eos/Models/LentillePrix.dart';
import 'package:eos/Models/Magasin.dart';
import 'package:eos/Models/Marque.dart';
import 'package:eos/Models/Traitement.dart';
import 'package:eos/Models/TraitementJoinLentille.dart';
import 'package:eos/Models/TraitementJoinVerre.dart';
import 'package:eos/Models/TraitementJoinVerre2.dart';
import 'package:eos/Models/TraitementLentille.dart';
import 'package:eos/Models/TraitementVerre.dart';
import 'package:eos/Models/Verre.dart';
import 'package:eos/Models/VerrePrix.dart';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'GeneralProvider.dart';

class DBProvider {
  var controller = Get.put(GeneralProvider());

  static Database _database;
  static final DBProvider db = DBProvider._();
  final _storage = FlutterSecureStorage();

  DBProvider._();

  Future<Database> get database async {
    // If database exists, return database
    if (_database != null) return _database;

    // If database don't exists, create one
    _database = await initDB();

    return _database;
  }

  // Create the database and the Employee table
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'dzoptique.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await createDB(db);
    });
  }

  createDB(Database db) async {
    await db.execute('CREATE TABLE Magasins('
        'id INTEGER PRIMARY KEY,'
        'nom TEXT,'
        'wilaya TEXT,'
        'commune TEXT,'
        'adresse TEXT,'
        'telephone TEXT,'
        'created_at TEXT,'
        'updated_at TEXT'
        ')');
    await db.execute('CREATE TABLE Marques('
        'id INTEGER PRIMARY KEY,'
        'nom_commercial TEXT,'
        'nom_technique TEXT,'
        'created_at TEXT,'
        'updated_at TEXT'
        ')');
    await db.execute('CREATE TABLE Traitements('
        'id INTEGER PRIMARY KEY,'
        'nom TEXT,'
        'description TEXT,'
        'prix INTEGER,'
        'gif TEXT,'
        'marque_id INTEGER,'
        'created_at TEXT,'
        'updated_aT TEXT,'
        'FOREIGN KEY(marque_id) REFERENCES Marque(id)'
        ')');
    await db.execute('CREATE TABLE Verres('
        'id INTEGER PRIMARY KEY,'
        'origine TEXT,'
        'matiere TEXT,'
        'nom_commercial TEXT,'
        'indice TEXT,'
        'type TEXT,'
        'diametre TEXT,'
        'distance TEXT,'
        'addition TEXT,'
        'image TEXT,'
        'niveau0 TEXT,'
        'niveau1 TEXT,'
        'niveau2 TEXT,'
        'niveau3 TEXT,'
        'niveau4 TEXT,'
        'niveau5 TEXT,'
        'marque_id INTEGER,'
        'created_at TEXT,'
        'updated_at TEXT,'
        'FOREIGN KEY(marque_id) REFERENCES Marque(id)'
        ')');
    await db.execute('CREATE TABLE Lentilles('
        'id INTEGER PRIMARY KEY,'
        'origine TEXT,'
        'marque TEXT,'
        'modele TEXT,'
        'matiere TEXT,'
        'diametre INTEGER,'
        'rayon INTEGER,'
        'image TEXT,'
        'niveau0 TEXT,'
        'niveau1 TEXT,'
        'niveau2 TEXT,'
        'niveau3 TEXT,'
        'niveau4 TEXT,'
        'niveau5 TEXT,'
        'created_at TEXT,'
        'updated_at TEXT'
        ')');
    await db.execute('CREATE TABLE TraitementVerres('
        'id INTEGER PRIMARY KEY,'
        'verre_id INTEGER,'
        'traitement_id INTEGER,'
        'note INTEGER,'
        'created_at STRING,'
        'updated_at STRING,'
        'FOREIGN KEY(verre_id) REFERENCES Verres(id),'
        'FOREIGN KEY(traitement_id) REFERENCES Traitements(id)'
        ')');

    await db.execute('CREATE TABLE LentillePrix('
        'id INTEGER PRIMARY KEY,'
        'SPH INTEGER,'
        'CYL INTEGER,'
        'pas_SPH INTEGER,'
        'pas_CYL INTEGER,'
        'prix INTEGER,'
        'lentille_id INTEGER,'
        'created_at STRING,'
        'updated_at STRING,'
        'FOREIGN KEY(lentille_id) REFERENCES Lentilles(id)'
        ')');

    await db.execute('CREATE TABLE VerresPrix('
        'id INTEGER PRIMARY KEY,'
        'CYL TEXT,'
        'SPH TEXT,'
        'pas_SPH TEXT,'
        'pas_CYL TEXT,'
        'prix INTEGER,'
        'verre_id INTEGER,'
        'created_at STRING,'
        'updated_at STRING,'
        'FOREIGN KEY(verre_id) REFERENCES Verres(id)'
        ')');

    await db.execute('CREATE TABLE TraitementLentilles('
        'id INTEGER PRIMARY KEY,'
        'lentille_id INTEGER,'
        'traitement_id INTEGER,'
        'note INTEGER,'
        'created_at STRING,'
        'updated_at STRING,'
        'FOREIGN KEY(lentille_id) REFERENCES Lentilles(id),'
        'FOREIGN KEY(traitement_id) REFERENCES Traitements(id)'
        ')');

    await db.execute('CREATE TABLE Date('
        'date TEXT'
        ')');
  }

  // Insert employee on database
  createMagasin(Magasin newMagasin) async {
    final db = await database;
    final res = await db.insert('Magasins', newMagasin.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllMagasins() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Magasins');

    return res;
  }

  Future<List<Magasin>> getAllMagasins() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Magasins");

    List<Magasin> list =
        res.isNotEmpty ? res.map((c) => Magasin.fromJson(c)).toList() : [];

    return list;
  }

  // Insert employee on database
  createVerre(Verre newVerre) async {
    final db = await database;
    int value;
    String number = await _storage.read(key: "number");
    value = int.tryParse(number);

    await _storage.write(key: "number", value: (value + 1).toString());
    /****************************************************************** */
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    File file = File(join(
        documentDirectory.path, 'image' + (value + 1).toString() + '.png'));
    if (await file.exists()) await file.delete();
    await file.writeAsString(newVerre.image);

    /****************************************************************** */

    newVerre.image = "image" + (value + 1).toString();

    print("Verre :" + newVerre.image);

    final res = await db.insert('Verres', newVerre.toJson());
    await Future.delayed(Duration(seconds: 1));

    return res;
  }

  // Delete all employees
  Future<int> deleteAllVerres() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Verres');
    return res;
  }

  Future<List<Verre>> getAllVerres() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Verres");

    List<Verre> list =
        res.isNotEmpty ? res.map((c) => Verre.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<dynamic>> getAllVerreslevel(
      int level, String first, String last) async {
    final db = await database;
    print("level = " + level.toString());
    print("first = " + first.toString());
    print("Last = " + last.toString());
    var res;
    if (level == 1) {
      res = await db.rawQuery("SELECT * FROM Verres WHERE niveau0='$first'");
    } else {
      if (level == 2) {
        res = await db.rawQuery(
            "SELECT * FROM Verres WHERE niveau0 = '$first' AND niveau1 = '$last'");
      } else {
        if (level == 3) {
          res = await db.rawQuery(
              "SELECT * FROM Verres WHERE niveau0 = '$first' AND niveau2 = '$last'");
        } else {
          if (level == 4) {
            res = await db.rawQuery(
                "SELECT * FROM Verres WHERE niveau0 = '$first' AND niveau3 = '$last'");
          } else {
            if (level == 5) {
              res = await db.rawQuery(
                  "SELECT * FROM Verres WHERE niveau0 = '$first' AND niveau4 = '$last'");
            } else {
              res = await db.rawQuery(
                  "SELECT * FROM Verres WHERE niveau0 = '$first' AND niveau5 = '$last");
            }
          }
        }
      }
    }

    List<dynamic> list =
        res.isNotEmpty ? res.map((c) => Verre.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<dynamic>> getVerrebyId(String id) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Verres WHERE Verres.id='$id'");

    List<dynamic> list =
        res.isNotEmpty ? res.map((c) => Verre.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<dynamic>> getVerrebyfiltre(
      String recherche, String origine, String matiere) async {
    final db = await database;
    var res = await db.rawQuery(
        "SELECT * FROM Verres WHERE nom_commercial LIKE '%$recherche%' AND origine LIKE '%$origine%' AND matiere LIKE '%$matiere%'");

    List<dynamic> list =
        res.isNotEmpty ? res.map((c) => Verre.fromJson(c)).toList() : [];

    return list;
  }

  // Insert employee on database
  createMarque(Marque newMarque) async {
    await deleteAllMarques();
    final db = await database;
    final res = await db.insert('Marques', newMarque.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllMarques() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Marques');

    return res;
  }

  Future<List<Marque>> getAllMarques() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Marques");

    List<Marque> list =
        res.isNotEmpty ? res.map((c) => Marque.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<dynamic>> getMarquebyId(String marqueId) async {
    final db = await database;
    var res =
        await db.rawQuery("SELECT * FROM Marques WHERE Marques.id='$marqueId'");

    List<dynamic> list =
        res.isNotEmpty ? res.map((c) => Marque.fromJson(c)).toList() : [];

    return list;
  }

  createLentille(Lentille newLentille) async {
    final db = await database;
    int value;
    String number = await _storage.read(key: "number");
    value = int.tryParse(number) + 1;

    await _storage.write(key: "number", value: value.toString());
    /****************************************************************** */
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    File file =
        File(join(documentDirectory.path, 'image' + value.toString() + '.png'));
    if (await file.exists()) await file.delete();
    await file.writeAsString(newLentille.image);
    /****************************************************************** */

    newLentille.image = "image" + value.toString();

    print("Lentille :" + newLentille.image);

    final res = await db.insert('Lentilles', newLentille.toJson());
    await Future.delayed(Duration(seconds: 1));
    return res;
  }

  // Delete all employees
  Future<int> deleteAllLentilles() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Lentilles');

    return res;
  }

  Future<List<Lentille>> getAllLentilles() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Lentilles");

    List<Lentille> list =
        res.isNotEmpty ? res.map((c) => Lentille.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Lentille>> getAllLentillessecondlevel(String niveau0) async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM Lentilles WHERE niveau0='$niveau0'");

    List<Lentille> list =
        res.isNotEmpty ? res.map((c) => Lentille.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Lentille>> getAllLentillesthirdlevel(
      String niveau0, String niveau1) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM Lentilles WHERE niveau0='$niveau0' AND niveau1='$niveau1'");

    List<Lentille> list =
        res.isNotEmpty ? res.map((c) => Lentille.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Lentille>> getAllLentillesfourthlevel(
      String niveau0, String niveau1, String niveau2) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM Lentilles WHERE niveau0='$niveau0' AND niveau1='$niveau1' AND niveau2='$niveau2'");

    List<Lentille> list =
        res.isNotEmpty ? res.map((c) => Lentille.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Lentille>> getAllLentillesfifthlevel(
      String niveau0, String niveau1, String niveau2, String niveau3) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM Lentilles WHERE niveau0='$niveau0' AND niveau1='$niveau1' AND niveau2='$niveau2' AND niveau3='$niveau3'");

    List<Lentille> list =
        res.isNotEmpty ? res.map((c) => Lentille.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<dynamic>> getLentillebyId(String id) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Lentilles WHERE id='$id'");

    List<dynamic> list =
        res.isNotEmpty ? res.map((c) => Lentille.fromJson(c)).toList() : [];

    return list;
  }

  createTraitement(Traitement newTraitement) async {
    final db = await database;
    int value;
    String number = await _storage.read(key: "number");
    if (number != null) value = int.tryParse(number);
    if (value == null) {
      await _storage.write(key: "number", value: "1");
      /****************************************************************** */
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      File file = File(join(documentDirectory.path, 'image1.png'));

      if (await file.exists()) await file.delete();
      await file.writeAsString(newTraitement.gif);
      /****************************************************************** */
      newTraitement.gif = "image" + "1";
    } else {
      value++;
      await _storage.delete(key: "number");
      await _storage.write(key: "number", value: value.toString());
      /****************************************************************** */
      Directory documentDirectory = await getApplicationDocumentsDirectory();
      File file = File(
          join(documentDirectory.path, 'image' + value.toString() + '.png'));
      if (await file.exists()) await file.delete();
      await file.writeAsString(newTraitement.gif);
      /****************************************************************** */
      newTraitement.gif = "image" + value.toString();
    }
    print("traitement :" + newTraitement.gif);
    int res = await db.insert('Traitements', newTraitement.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllTraitement() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Traitements');

    return res;
  }

  Future<List<Traitement>> getAllTraitements() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Traitements");

    List<Traitement> list =
        res.isNotEmpty ? res.map((c) => Traitement.fromJson(c)).toList() : [];

    return list;
  }

  createTraitementVerre(TraitementVerre newTraitementverre) async {
    final db = await database;
    final res =
        await db.insert('TraitementVerres', newTraitementverre.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllTraitementVerres() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM TraitementVerres');

    return res;
  }

  Future<List<TraitementVerre>> getAllTraitementsVerres() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM TraitementVerres");

    List<TraitementVerre> list = res.isNotEmpty
        ? res.map((c) => TraitementVerre.fromJson(c)).toList()
        : [];

    return list;
  }

  createLentillePrix(LentillePrix newLentillePrix) async {
    final db = await database;
    final res = await db.insert('LentillePrix', newLentillePrix.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllLentillePrix() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM LentillePrix');

    return res;
  }

  Future<List<LentillePrix>> getAllLentillesPrix() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM LentillePrix");

    List<LentillePrix> list =
        res.isNotEmpty ? res.map((c) => LentillePrix.fromJson(c)).toList() : [];

    return list;
  }

  createVerrePrix(VerrePrix newverrePrix) async {
    final db = await database;
    final res = await db.insert('VerresPrix', newverrePrix.toJson());

    return res;
  }

  // Delete all employees
  Future<int> deleteAllVerresPrix() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM VerresPrix');

    return res;
  }

  Future<List<VerrePrix>> getAllVerresPrix() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM VerresPrix");

    List<VerrePrix> list =
        res.isNotEmpty ? res.map((c) => VerrePrix.fromJson(c)).toList() : [];

    return list;
  }

  createTraitementLentille(TraitementLentille newTraitementlentille) async {
    final db = await database;
    final res =
        await db.insert(' TraitementLentilles', newTraitementlentille.toJson());
    return res;
  }

  createDate() async {
    final db = await database;
    final res =
        await db.rawQuery("INSERT INTO DATE (Date) VALUES( CURRENT_DATE )");
    return res;
  }

  Future<int> deleteDate() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM  Date');

    return res;
  }

  Future<String> getDate() async {
    try {
      final db = await database;
      final res = await db.rawQuery("SELECT * FROM Date");
      String date = res.isNotEmpty ? res[0]["date"] : "Pas encore";
      return date;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  // Delete all employees
  Future<int> deleteAllTraitementLentilles() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM  TraitementLentilles');

    return res;
  }

  Future<List<TraitementLentille>> getAllTraitementsLentilles() async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM  TraitementLentilles");

    List<TraitementLentille> list = res.isNotEmpty
        ? res.map((c) => TraitementLentille.fromJson(c)).toList()
        : [];

    return list;
  }

  /*---------------------------------------------------------------------- Traitements --------------------------------------------------------------------------*/

  Future<List<TraitementJoinVerre>> getAllTraitementsavecVerres() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT tv.verre_id ,tv.note , t.nom FROM TraitementVerres as tv INNER JOIN Traitements as t ON t.id = tv.traitement_id");

    List<TraitementJoinVerre> list = res.isNotEmpty
        ? res.map((c) => TraitementJoinVerre.fromJson(c)).toList()
        : [];

    return list;
  }

  Future<List<TraitementJoinLentille>> getAllTraitementsavecLentilles() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT tl.lentille_id ,tl.note , t.nom FROM TraitementLentilles as tl INNER JOIN Traitements as t ON t.id = tl.traitement_id");

    List<TraitementJoinLentille> list = res.isNotEmpty
        ? res.map((c) => TraitementJoinLentille.fromJson(c)).toList()
        : [];

    return list;
  }

  Future<List<TraitementJoinVerre2>> getAllTraitementsavecVerres2() async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT tv.verre_id ,tv.note ,t.nom,t.description,t.prix,t.gif,t.marque_id  FROM TraitementVerres as tv INNER JOIN Traitements as t ON t.id = tv.traitement_id");

    List<TraitementJoinVerre2> list = res.isNotEmpty
        ? res.map((c) => TraitementJoinVerre2.fromJson(c)).toList()
        : [];

    return list;
  }

  Future<List<VerrePrix>> getAllVVerreprixbyid(int verreId) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM VerresPrix WHERE verre_id='$verreId' ORDER BY id ASC");

    List<VerrePrix> list =
        res.isNotEmpty ? res.map((c) => VerrePrix.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<LentillePrix>> getAlllentilleprixbyid(int lentilleId) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM LentillePrix WHERE lentille_id='$lentilleId' ORDER BY id ASC");

    List<LentillePrix> list =
        res.isNotEmpty ? res.map((c) => LentillePrix.fromJson(c)).toList() : [];

    return list;
  }

  Future<int> deleteAllDate() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM  Date');

    return res;
  }

  Future<List> getLentilleNiveau0() async {
    final db = await database;
    var res = await db.rawQuery("SELECT DISTINCT niveau0 FROM lentilles");

    List<dynamic> list =
        res.isNotEmpty ? res.map((e) => e["niveau0"]).toList() : [];
    return list;
  }

  Future<List> getLentilleNiveau1(String niveau0) async {
    final db = await database;

    var res = await db.rawQuery(
        "SELECT DISTINCT niveau1 FROM lentilles WHERE niveau0= '$niveau0'");
    List<dynamic> list =
        res.isNotEmpty ? res.map((e) => e["niveau1"]).toList() : [];
    return list;
  }

  Future<List> getLentilleNiveau2(String niveau0, String niveau1) async {
    final db = await database;

    var res = await db.rawQuery(
        "SELECT DISTINCT niveau2 FROM lentilles WHERE niveau0= '$niveau0' AND niveau1= '$niveau1'");
    List<dynamic> list =
        res.isNotEmpty ? res.map((e) => e["niveau2"]).toList() : [];
    return list;
  }

  Future<List> getLentilleNiveau3(
      String niveau0, String niveau1, String niveau2) async {
    final db = await database;

    var res = await db.rawQuery(
        "SELECT DISTINCT niveau3 FROM lentilles WHERE niveau0= '$niveau0' AND niveau1= '$niveau1' AND niveau2= '$niveau2'");
    List<dynamic> list =
        res.isNotEmpty ? res.map((e) => e["niveau3"]).toList() : [];
    return list;
  }

  Future<List> getVerreNiveau0() async {
    final db = await database;
    var res = await db.rawQuery("SELECT DISTINCT niveau0 FROM verres");

    List<dynamic> list =
        res.isNotEmpty ? res.map((e) => e["niveau0"]).toList() : [];
    return list;
  }

  Future<List> getVerreNiveau1(String niveau0) async {
    final db = await database;

    var res = await db.rawQuery(
        "SELECT DISTINCT niveau1 FROM verres WHERE niveau0= '$niveau0'");
    List<dynamic> list =
        res.isNotEmpty ? res.map((e) => e["niveau1"]).toList() : [];
    return list;
  }

  Future<List> getVerreNiveau2(String niveau0, String niveau1) async {
    final db = await database;

    var res = await db.rawQuery(
        "SELECT DISTINCT niveau2 FROM verres WHERE niveau0= '$niveau0' AND niveau1= '$niveau1'");
    List<dynamic> list =
        res.isNotEmpty ? res.map((e) => e["niveau2"]).toList() : [];
    return list;
  }

  Future<List> getVerreNiveau3(
      String niveau0, String niveau1, String niveau2) async {
    final db = await database;

    var res = await db.rawQuery(
        "SELECT DISTINCT niveau3 FROM verres WHERE niveau0= '$niveau0' AND niveau1= '$niveau1' AND niveau2= '$niveau2'");
    List<dynamic> list =
        res.isNotEmpty ? res.map((e) => e["niveau3"]).toList() : [];
    return list;
  }

  Future<List<Verre>> getAllVerresSecondLevel(String niveau0) async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM verres WHERE niveau0='$niveau0'");

    List<Verre> list =
        res.isNotEmpty ? res.map((c) => Verre.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Verre>> getAllVerresThirdLevel(
      String niveau0, String niveau1) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM verres WHERE niveau0='$niveau0' AND niveau1='$niveau1'");

    List<Verre> list =
        res.isNotEmpty ? res.map((c) => Verre.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Verre>> getAllVerresFourthLevel(
      String niveau0, String niveau1, String niveau2) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM verres WHERE niveau0='$niveau0' AND niveau1='$niveau1' AND niveau2='$niveau2'");

    List<Verre> list =
        res.isNotEmpty ? res.map((c) => Verre.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<Verre>> getAllVerresFifthLevel(
    String niveau0,
    String niveau1,
    String niveau2,
    String niveau3,
  ) async {
    final db = await database;
    final res = await db.rawQuery(
        "SELECT * FROM verres WHERE niveau0='$niveau0' AND niveau1='$niveau1' AND niveau2='$niveau2'");

    List<Verre> list =
        res.isNotEmpty ? res.map((c) => Verre.fromJson(c)).toList() : [];

    return list;
  }
}
