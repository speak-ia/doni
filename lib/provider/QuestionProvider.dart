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
      options: List<String>.from(data['options'] ?? []),
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

  try {
    QuerySnapshot snapshot = await _firestore
        .collection('questions') // Assurez-vous que la collection est correcte
        .where('surveyId', isEqualTo: surveyId) // Filtrer par surveyId
        .get();
        print("Nombre de questions récupérées : ${_questions.length}");

    _questions = snapshot.docs.map((doc) => Question.fromFirestore(doc)).toList();
    
  } catch (e) {
    print("Erreur lors de la récupération des questions: $e");
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