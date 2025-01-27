class Enqueteur {
  final String firebaseId;
  final String nom;
  final String email;
  final String numero;

  Enqueteur({
    required this.firebaseId,
    required this.nom,
    required this.email,
    required this.numero,
  });

  factory Enqueteur.fromJson(Map<String, dynamic> json) {
    return Enqueteur(
      firebaseId: json['firebase_id'],
      nom: json['nom'],
      email: json['email'],
      numero: json['numero'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firebase_id': firebaseId,
      'nom': nom,
      'email': email,
      'numero': numero,
    };
  }
}