import 'package:get/state_manager.dart';

class GeneralProvider extends GetxController {
  RxList path = RxList();
  RxInt idverre = RxInt();
  RxInt idlentille = RxInt();
  RxString client = RxString();
  RxString PGSPH = RxString();
  RxString PGCYL = RxString();
  RxString PDSPH = RxString();
  RxString PDCYL = RxString();
  RxString IGSPH = RxString();
  RxString IGCYL = RxString();
  RxString IDSPH = RxString();
  RxString IDCYL = RxString();
  RxString LGSPH = RxString();
  RxString LGCYL = RxString();
  RxString LDSPH = RxString();
  RxString LDCYL = RxString();
  RxString lGSPH = RxString();
  RxString lGCYL = RxString();
  RxString lDSPH = RxString();
  RxString lDCYL = RxString();
  RxString date;
  RxString recherche;
  RxString origine;
  RxString matiere;
  RxBool absorb = RxBool(false);
  RxBool keybordOpen = true.obs;
}
