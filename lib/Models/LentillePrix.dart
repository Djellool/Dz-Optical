class LentillePrix {
  int id;
  String sPH;
  String cYL;
  String pasSPH;
  String pasCYL;
  String prix;
  int lentilleId;
  String createdAt;
  String updatedAt;

  LentillePrix(
      {this.id,
      this.sPH,
      this.cYL,
      this.pasSPH,
      this.pasCYL,
      this.prix,
      this.lentilleId,
      this.createdAt,
      this.updatedAt});

  LentillePrix.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sPH = json['SPH'];
    cYL = json['CYL'];
    pasSPH = json['pas_SPH'].toString();
    pasCYL = json['pas_CYL'].toString();
    prix = json['prix'].toString();
    lentilleId = json['lentille_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['SPH'] = this.sPH;
    data['CYL'] = this.cYL;
    data['pas_SPH'] = this.pasSPH;
    data['pas_CYL'] = this.pasCYL;
    data['prix'] = this.prix;
    data['lentille_id'] = this.lentilleId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
