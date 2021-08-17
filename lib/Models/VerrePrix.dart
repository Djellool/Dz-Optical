class VerrePrix {
  int id;
  String sPH;
  String cYL;
  String pasSPH;
  String pasCYL;
  int prix;
  int verreId;
  String createdAt;
  String updatedAt;

  VerrePrix(
      {this.id,
      this.sPH,
      this.cYL,
      this.pasSPH,
      this.pasCYL,
      this.prix,
      this.verreId,
      this.createdAt,
      this.updatedAt});

  VerrePrix.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sPH = json['SPH'].toString();
    cYL = json['CYL'].toString();
    pasSPH = json['pas_SPH'].toString();
    pasCYL = json['pas_CYL'].toString();
    prix = int.tryParse(json['prix'].toString());
    verreId = json['verre_id'];
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
    data['verre_id'] = this.verreId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
