import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Enquete {
  //final String id;
  final String title;
  final String description;
  final String status;
  final String startDate;
  final String endDate;

  Enquete({
    //required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.startDate,
    required this.endDate,
  });

  factory Enquete.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Enquete(
      title: data['title'] ?? 'Titre inconnu',
      description: data['description'] ?? '',
      status: data['status'] ?? '',
      startDate: data['startDate'] ?? '',
      endDate: data['endDate'] ?? '', 
    );
  }
}

class EnqueteProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Enquete> _enquetes = [];
  bool _isLoading = false;

  List<Enquete> get enquetes => _enquetes;
  bool get isLoading => _isLoading;

  Future<void> fetchEnquetes() async {
    _isLoading = true;
    notifyListeners();

    try {
      QuerySnapshot snapshot = await _firestore.collection('surveys').get();
      _enquetes = snapshot.docs.map((doc) => Enquete.fromFirestore(doc)).toList();
    } catch (e) {
      print("Erreur lors de la récupération des enquêtes: $e");
    }

    _isLoading = false;
    notifyListeners();
  }
}
