class TraitementVerre {
  int id;
  int verreId;
  int traitementId;
  int note;
  String createdAt;
  String updatedAt;

  TraitementVerre(
      {this.id,
      this.verreId,
      this.traitementId,
      this.note,
      this.createdAt,
      this.updatedAt});

  TraitementVerre.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    verreId = json['verre_id'];
    traitementId = json['traitement_id'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['verre_id'] = this.verreId;
    data['traitement_id'] = this.traitementId;
    data['note'] = this.note;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
