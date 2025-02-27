import 'package:donidata/models/enqueteModel.dart';
import 'package:donidata/provider/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donidata/provider/QuestionProvider.dart';
import 'package:donidata/provider/enquete_provider.dart'; 
//import 'package:donidata/provider/user_provider.dart'; // Utilisation de user_provider.dart
import 'package:donidata/screen/accueil.dart';

class QuestionnaireScreen extends StatefulWidget {
  final String surveyId; // Utilisation de surveyId comme identifiant de l'enquête

  QuestionnaireScreen({required this.surveyId});

  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int _currentQuestionIndex = 0;
  String? selectedAnswer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
      print("Appel de fetchQuestions avec surveyId: ${widget.surveyId}");
      questionProvider.fetchQuestions(widget.surveyId);
    });
  }

  void _nextQuestion() {
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    if (_currentQuestionIndex < questionProvider.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        selectedAnswer = null; // Réinitialise la réponse sélectionnée pour la nouvelle question
      });
    } else {
      _finishQuestionnaire();
    }
  }

  void _finishQuestionnaire() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Survey Completed"),
          content: Text("Thank you for participating in our survey!"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Accueil()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);
    final enqueteProvider = Provider.of<EnqueteProvider>(context, listen: false); // Évite de réécouter ici
    final userProvider = Provider.of<UserProvider>(context);
    final questions = questionProvider.questions;
    final currentEnquete = enqueteProvider.enquetes.firstWhere(
      (enquete) => enquete.surveyId == widget.surveyId,
      orElse: () => Enquete(
        surveyId: "", 
        title: "Survey not found",
        description: "",
        status: "",
        startDate: "",
        endDate: "",
        investigatorId: userProvider.user?.uid ?? "", 
      ),
    );

    final bool isLastQuestion = _currentQuestionIndex == questions.length - 1;

    if (questionProvider.isLoading) {
      return Scaffold(
        appBar: AppBar(
          title: Text(currentEnquete.title),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text(currentEnquete.title),
        ),
        body: Center(child: Text("No questions available for this survey.")),
      );
    }

    final currentQuestion = questions[_currentQuestionIndex];
    final currentUser = userProvider.user; 

    return Scaffold(
      appBar: AppBar(
        title: Text(currentEnquete.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              currentQuestion.text,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ...currentQuestion.options.map((option) {
              return ListTile(
                title: Text(option),
                trailing: selectedAnswer == option ? Icon(Icons.check, color: Colors.black) : null,
                onTap: () {
                  setState(() {
                    selectedAnswer = option;
                  });
                },
              );
            }).toList(),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: selectedAnswer == null
                  ? null
                  : () {
                      final answer = Answer(
                        questionId: currentQuestion.id,
                        response: selectedAnswer!,
                        surveyId: currentQuestion.surveyId,
                        investigatorId: currentUser?.uid ?? "", 
                      );
                      questionProvider.submitAnswer(answer);
                      _nextQuestion(); 
                    },
              child: Text(isLastQuestion ? "Finish" : "Next"),
            ),
          ],
        ),
      ),
    );
  }
}