

// import 'package:donidata/models/enqueteModel.dart';
// import 'package:donidata/services/serviceApi.dart';
// import 'package:flutter/material.dart';

// class EnqueteProvider with ChangeNotifier {
//   final ApiService _apiService = ApiService();
//   List<Enquete> _enquetes = [];
//   Enquete? _selectedEnquete;
//   bool _isLoading = false;

//   List<Enquete> get enquetes => _enquetes;
//   Enquete? get selectedEnquete => _selectedEnquete;
//   bool get isLoading => _isLoading;

//   // Charger toutes les enquêtes
//   Future<void> getAllEnquetes() async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final response = await _apiService.get('/enquetes/');
//       _enquetes = (response.data as List)
//           .map((json) => Enquete.fromJson(json))
//           .toList();
//     } catch (e) {
//       print('Erreur lors du chargement des enquêtes: $e');
//       rethrow;
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   Future<void> applyForEnquete(String? enqueteId) async {
//     if (enqueteId == null) throw Exception('ID de l\'enquête invalide');
//     // Add your API call or database logic here
//     // For example:
//     // await _api.postApplication(enqueteId);
//   }
// }
