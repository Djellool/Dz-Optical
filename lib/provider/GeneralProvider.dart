import 'package:get/state_manager.dart';

class GeneralProvider extends GetxController {
  RxList path = RxList();
  RxInt idverre;
  RxInt idlentille;
  RxString client;
  RxString PGSPH;
  RxString PGCYL;
  RxString PDSPH;
  RxString PDCYL;
  RxString IGSPH;
  RxString IGCYL;
  RxString IDSPH;
  RxString IDCYL;
  RxString LGSPH;
  RxString LGCYL;
  RxString LDSPH;
  RxString LDCYL;
  RxString lGSPH;
  RxString lGCYL;
  RxString lDSPH;
  RxString lDCYL;
  RxString date;
  RxString recherche;
  RxString origine;
  RxString matiere;
  RxBool absorb = RxBool(false);
  RxBool keybordOpen = true.obs;
}
