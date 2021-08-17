class Lentille {
  int id;
  String origine;
  String marque;
  String modele;
  String matiere;
  int diametre;
  int rayon;
  String image;
  String niveau0;
  String niveau1;
  String niveau2;
  String niveau3;
  String niveau4;
  String niveau5;
  String createdAt;
  String updatedAt;

  Lentille(
      {this.id,
      this.origine,
      this.marque,
      this.modele,
      this.matiere,
      this.diametre,
      this.rayon,
      this.image,
      this.niveau0,
      this.niveau1,
      this.niveau2,
      this.niveau3,
      this.niveau4,
      this.niveau5,
      this.createdAt,
      this.updatedAt});

  Lentille.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    origine = json['origine'];
    marque = json['marque'];
    modele = json['modele'];
    matiere = json['matiere'];
    diametre = json['diametre'];
    rayon = json['rayon'];
    image = json['image'];
    niveau0 = json['niveau0'];
    niveau1 = json['niveau1'];
    niveau2 = json['niveau2'];
    niveau3 = json['niveau3'];
    niveau4 = json['niveau4'];
    niveau5 = json['niveau5'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['origine'] = this.origine;
    data['marque'] = this.marque;
    data['modele'] = this.modele;
    data['matiere'] = this.matiere;
    data['diametre'] = this.diametre;
    data['rayon'] = this.rayon;
    data['image'] = this.image;
    data['niveau0'] = this.niveau0;
    data['niveau1'] = this.niveau1;
    data['niveau2'] = this.niveau2;
    data['niveau3'] = this.niveau3;
    data['niveau4'] = this.niveau4;
    data['niveau5'] = this.niveau5;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
