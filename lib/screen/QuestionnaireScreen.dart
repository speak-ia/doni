import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:donidata/provider/QuestionProvider.dart';
import 'package:donidata/provider/enquete_provider.dart'; 
import 'package:donidata/screen/accueil.dart';

class QuestionnaireScreen extends StatefulWidget {
  final String surveyId;

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
      questionProvider.fetchQuestions(widget.surveyId);
    });
  }

  void _nextQuestion() {
    final questionProvider = Provider.of<QuestionProvider>(context, listen: false);
    if (_currentQuestionIndex < questionProvider.questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        selectedAnswer = null;
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
          title: Text("Enquête Terminée"),
          content: Text("Merci d'avoir participé à notre enquête!"),
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
    final enqueteProvider = Provider.of<EnqueteProvider>(context);
    final questions = questionProvider.questions;
    final currentEnquete = enqueteProvider.enquetes.firstWhere(
      (enquete) => enquete.title == widget.surveyId,
      orElse: () => Enquete(
        title: "Enquête inconnue",
        description: "",
        status: "",
        startDate: "",
        endDate: "",
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
        body: Center(child: Text("Aucune question disponible pour cette enquête.")),
      );
    }

    final currentQuestion = questions[_currentQuestionIndex];

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
                        investigatorId: "DFXxUcUoXZJmzJDYvKio",
                      );
                      questionProvider.submitAnswer(answer);
                      _nextQuestion();
                    },
              child: Text(isLastQuestion ? "Terminer" : "Suivant"),
            ),
          ],
        ),
      ),
    );
  }
}
