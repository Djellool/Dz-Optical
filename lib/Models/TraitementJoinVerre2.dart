class TraitementJoinVerre2 {
  int verreId;
  int note;
  String nom;
  String description;
  int prix;
  String gif;
  int marqueId;

  TraitementJoinVerre2(
      {this.verreId,
      this.nom,
      this.note,
      this.marqueId,
      this.prix,
      this.description,
      this.gif});

  TraitementJoinVerre2.fromJson(Map<String, dynamic> json) {
    verreId = json['verre_id'];
    nom = json['nom'];
    note = json['note'];
    description = json['description'];
    prix = json['prix'];
    gif = json['gif'];
    marqueId = json['marqueId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verre_id'] = this.verreId;
    data['nom'] = this.nom;
    data['note'] = this.note;
    data['description'] = this.description;
    data['gif'] = this.gif;
    data['marqueId'] = this.marqueId;
    data['prix'] = this.prix;
    return data;
  }
}
