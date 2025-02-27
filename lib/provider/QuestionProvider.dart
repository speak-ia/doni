import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Question {
  final String id;
  final String text;
  final String type;
  final List<String> options;
  final String surveyId;

  Question({
    required this.id,
    required this.text,
    required this.type,
    required this.options,
    required this.surveyId,
  });

  factory Question.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Question(
      id: doc.id,
      text: data['text'] ?? '',
      type: data['type'] ?? '',
      options: (data['options'] != null)
          ? List<String>.from(data['options'])
          : [], // Gestion des valeurs nulles
      surveyId: data['surveyId'] ?? '',
    );
  }
}

class Answer {
  final String questionId;
  final String response;
  final String surveyId;
  final String investigatorId;

  Answer({
    required this.questionId,
    required this.response,
    required this.surveyId,
    required this.investigatorId,
  });

  Map<String, dynamic> toMap() {
    return {
      'questionId': questionId,
      'response': response,
      'surveyId': surveyId,
      'investigatorId': investigatorId,
    };
  }
}

class QuestionProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Question> _questions = [];
  bool _isLoading = false;

  List<Question> get questions => _questions;
  bool get isLoading => _isLoading;

  Future<void> fetchQuestions(String surveyId) async {
    _isLoading = true;
    notifyListeners();

    print("Début de la récupération des questions pour surveyId: $surveyId");

    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('questions')
          .where('surveyId', isEqualTo: surveyId)
          .get();

      print("Nombre de questions trouvées : ${querySnapshot.docs.length}");

      _questions = querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        print("Données Firestore pour la question ${doc.id}: $data");

        return Question(
          id: doc.id,
          text: data['text'] ?? '',
          type: data['type'] ?? '',
          options: (data['options'] is List)
              ? List<String>.from(data['options'])
              : [],
          surveyId: data['surveyId'] ?? '',
        );
      }).toList();

      print("Questions récupérées : $_questions");
    } catch (e) {
      print("Erreur lors de la récupération des questions : $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> submitAnswer(Answer answer) async {
    try {
      await _firestore.collection('answers').add(answer.toMap());
    } catch (e) {
      print("Erreur lors de la soumission de la réponse: $e");
    }
  }
}