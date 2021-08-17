class Magasin {
  int id;
  String nom;
  String wilaya;
  String commune;
  String adresse;
  String telephone;
  Null createdAt;
  Null updatedAt;

  Magasin(
      {this.id,
      this.nom,
      this.wilaya,
      this.commune,
      this.adresse,
      this.telephone,
      this.createdAt,
      this.updatedAt});

  Magasin.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    wilaya = json['wilaya'];
    commune = json['commune'];
    adresse = json['adresse'];
    telephone = json['telephone'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['wilaya'] = this.wilaya;
    data['commune'] = this.commune;
    data['adresse'] = this.adresse;
    data['telephone'] = this.telephone;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
