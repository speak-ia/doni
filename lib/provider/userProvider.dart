import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donidata/models/usermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class UserProvider with ChangeNotifier {
  UserModel? _user;
  bool _isLoading = true;
  bool _isDarkMode = false;

  UserModel? get user => _user;
  bool get isLoading => _isLoading;
  bool get isDarkMode => _isDarkMode;

  UserProvider() {
    // Surveiller les changements d'utilisateur
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        fetchUserData(); 
      } else {
        _user = null; 
        notifyListeners();
      }
    });
  }

  Future<void> fetchUserData() async {
  try {
    _isLoading = true;
    notifyListeners();

    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      print("⚠️ Aucun utilisateur connecté.");
      _user = null;
      _isLoading = false;
      notifyListeners();
      return;
    }

    final uid = currentUser.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection('investigators')
        .doc(uid)
        .get();

    if (snapshot.exists && snapshot.data() != null) {
      _user = UserModel.fromDocument(snapshot.data()!);
      print("Données utilisateur chargées : ${_user!.fullname}");
    } else {
      print("⚠️ Aucune donnée trouvée pour cet utilisateur.");
      _user = null;
    }

  } catch (e) {
    print("Erreur lors de la récupération des données utilisateur : $e");
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}


  Future<void> updateUserData({
    required String fullname,
    required String email,
    required String phone,
  }) async {
    try {
      if (_user != null) {
        final uid = FirebaseAuth.instance.currentUser!.uid;

        await FirebaseFirestore.instance
            .collection('investigators')
            .doc(uid)
            .update({
          'fullname': fullname,
          'email': email,
          'phone': phone,
        });

        _user = UserModel(
          uid: _user!.uid,
          fullname: fullname,
          email: email,
          phone: phone,
          photoUrl: _user!.photoUrl,
        );

        notifyListeners();
      } else {
        throw Exception("Utilisateur non disponible pour mise à jour.");
      }
    } catch (e) {
      print("Erreur lors de la mise à jour des données utilisateur : $e");
      rethrow;
    }
  }

  Future<void> updateUserLocation(LatLng location) async {
  try {
    if (_user != null) {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      await FirebaseFirestore.instance
          .collection('investigators')
          .doc(uid)
          .update({
        'location': {
          'latitude': location.latitude,
          'longitude': location.longitude,
        },
      });

      _user = UserModel(
        uid: _user!.uid,
        fullname: _user!.fullname,
        email: _user!.email,
        phone: _user!.phone,
        photoUrl: _user!.photoUrl,
        location: location,
      );

      notifyListeners();
    } else {
      throw Exception("Utilisateur non disponible pour mise à jour.");
    }
  } catch (e) {
    print("Erreur lors de la mise à jour de la localisation : $e");
    rethrow;
  }
}

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
