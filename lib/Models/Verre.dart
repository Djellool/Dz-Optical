class Verre {
  int id;
  String origine;
  String matiere;
  String nomCommercial;
  String indice;
  String type;
  String diametre;
  String distance;
  String addition;
  String image;
  String niveau0;
  String niveau1;
  String niveau2;
  String niveau3;
  String niveau4;
  String niveau5;
  int marqueId;
  String createdAt;
  String updatedAt;

  Verre(
      {this.id,
      this.origine,
      this.matiere,
      this.nomCommercial,
      this.indice,
      this.type,
      this.diametre,
      this.distance,
      this.addition,
      this.image,
      this.niveau0,
      this.niveau1,
      this.niveau2,
      this.niveau3,
      this.niveau4,
      this.niveau5,
      this.marqueId,
      this.createdAt,
      this.updatedAt});

  Verre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    origine = json['origine'];
    matiere = json['matiere'];
    nomCommercial = json['nom_commercial'];
    indice = json['indice'];
    type = json['type'];
    diametre = json['diametre'];
    distance = json['distance'];
    addition = json['addition'];
    image = json['image'];
    niveau0 = json['niveau0'];
    niveau1 = json['niveau1'];
    niveau2 = json['niveau2'];
    niveau3 = json['niveau3'];
    niveau4 = json['niveau4'];
    niveau5 = json['niveau5'];
    marqueId = json['marque_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['origine'] = this.origine;
    data['matiere'] = this.matiere;
    data['nom_commercial'] = this.nomCommercial;
    data['indice'] = this.indice;
    data['type'] = this.type;
    data['diametre'] = this.diametre;
    data['distance'] = this.distance;
    data['addition'] = this.addition;
    data['image'] = this.image;
    data['niveau0'] = this.niveau0;
    data['niveau1'] = this.niveau1;
    data['niveau2'] = this.niveau2;
    data['niveau3'] = this.niveau3;
    data['niveau4'] = this.niveau4;
    data['niveau5'] = this.niveau5;
    data['marque_id'] = this.marqueId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
