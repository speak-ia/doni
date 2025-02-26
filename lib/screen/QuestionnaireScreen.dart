import 'package:flutter/material.dart';

class QuestionnaireScreen extends StatefulWidget {
  @override
  _QuestionnaireScreenState createState() => _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends State<QuestionnaireScreen> {
  int _currentQuestionIndex = 0;
  List<String> questions = [
    "Avez-vous déjà essayé un service de livraison de kit repas?",
    "Êtes-vous satisfait de la qualité des repas?",
    "Recommanderiez-vous ce service à d'autres?",
  ];
  String? selectedAnswer;

  void _nextQuestion() {
    if (_currentQuestionIndex < questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        selectedAnswer = null;
      });
    } else {
      // Action à effectuer lorsque l'enquête est terminée
      _finishQuestionnaire();
    }
  }

  void _finishQuestionnaire() {
    // Ajoutez ici le code pour gérer la fin de l'enquête
    // Par exemple, afficher un message de succès ou naviguer vers une autre page
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
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLastQuestion = _currentQuestionIndex == questions.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text("Enquêtes Alimentaire"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    questions[_currentQuestionIndex],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ListTile(
                    title: Text("Oui"),
                    trailing: selectedAnswer == "Oui" ? Icon(Icons.check, color: Colors.black) : null,
                    onTap: () {
                      setState(() {
                        selectedAnswer = "Oui";
                      });
                    },
                  ),
                  ListTile(
                    title: Text("Non"),
                    trailing: selectedAnswer == "Non" ? Icon(Icons.check, color: Colors.black) : null,
                    onTap: () {
                      setState(() {
                        selectedAnswer = "Non";
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _nextQuestion,
                    child: Text(isLastQuestion ? "Terminer" : "Suivant"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}