class Enquete {
  final String titre;
  final String description;
  final DateTime dateDebut;
  final DateTime dateFin;
  final String enqueteurId;

  Enquete({
    required this.titre,
    required this.description,
    required this.dateDebut,
    required this.dateFin,
    required this.enqueteurId,
  });

  factory Enquete.fromJson(Map<String, dynamic> json) {
    return Enquete(
      titre: json['titre'],
      description: json['description'],
      dateDebut: DateTime.parse(json['date_debut']),
      dateFin: DateTime.parse(json['date_fin']),
      enqueteurId: json['enqueteur'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'titre': titre,
      'description': description,
      'date_debut': dateDebut.toIso8601String(),
      'date_fin': dateFin.toIso8601String(),
      'enqueteur': enqueteurId,
    };
  }
}