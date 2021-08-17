class TraitementJoinLentille {
  int lentilleId;
  int note;
  String nom;

  TraitementJoinLentille({this.lentilleId, this.nom, this.note});

  TraitementJoinLentille.fromJson(Map<String, dynamic> json) {
    lentilleId = json['lentille_id'];
    nom = json['nom'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lentille_id'] = this.lentilleId;
    data['nom'] = this.nom;
    data['note'] = this.note;
    return data;
  }
}
