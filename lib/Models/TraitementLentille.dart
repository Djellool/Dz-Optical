class TraitementLentille {
  int id;
  int lentilleId;
  int traitementId;
  int note;
  String createdAt;
  String updatedAt;

  TraitementLentille(
      {this.id,
      this.lentilleId,
      this.traitementId,
      this.note,
      this.createdAt,
      this.updatedAt});

  TraitementLentille.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lentilleId = json['lentille_id'];
    traitementId = json['traitement_id'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lentille_id'] = this.lentilleId;
    data['traitement_id'] = this.traitementId;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
