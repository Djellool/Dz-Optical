class Marque {
  int id;
  String nomCommercial;
  String nomTechnique;
  String createdAt;
  String updatedAt;

  Marque(
      {this.id,
      this.nomCommercial,
      this.nomTechnique,
      this.createdAt,
      this.updatedAt});

  Marque.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nomCommercial = json['nom_commercial'];
    nomTechnique = json['nom_technique'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nom_commercial'] = this.nomCommercial;
    data['nom_technique'] = this.nomTechnique;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
