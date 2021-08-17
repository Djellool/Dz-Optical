class TraitementJoinVerre {
  int verreId;
  int note;
  String nom;

  TraitementJoinVerre({this.verreId, this.nom, this.note});

  TraitementJoinVerre.fromJson(Map<String, dynamic> json) {
    verreId = json['verre_id'];
    nom = json['nom'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['verre_id'] = this.verreId;
    data['nom'] = this.nom;
    data['note'] = this.note;
    return data;
  }
}
