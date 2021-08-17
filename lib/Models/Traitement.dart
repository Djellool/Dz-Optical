class Traitement {
  int id;
  String nom;
  String description;
  int prix;
  String gif;
  int marqueId;
  String createdAt;
  String updatedAt;

  Traitement(
      {this.id,
      this.nom,
      this.description,
      this.prix,
      this.gif,
      this.marqueId,
      this.createdAt,
      this.updatedAt});

  Traitement.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nom = json['nom'];
    description = json['description'];
    prix = json['prix'];
    gif = json['gif'];
    marqueId = json['marque_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom'] = this.nom;
    data['description'] = this.description;
    data['prix'] = this.prix;
    data['gif'] = this.gif;
    data['marque_id'] = this.marqueId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
