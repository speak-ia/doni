import 'package:donidata/screen/QuestionnaireScreen.dart';
import 'package:flutter/material.dart';
import 'package:donidata/screen/profil_screen.dart';

class EnqueteDetailPage extends StatefulWidget {
  final Map<String, String> enquete;

  EnqueteDetailPage({required this.enquete});

  @override
  _EnqueteDetailPageState createState() => _EnqueteDetailPageState();
}

class _EnqueteDetailPageState extends State<EnqueteDetailPage> {
  bool isApplied = false;
  bool isAccepted = false;

  void _applyForSurvey() {
    setState(() {
      isApplied = true;
    });
    
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isAccepted = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Votre candidature a été acceptée ! Vous pouvez répondre aux questions."),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        elevation: 0,
        toolbarHeight: 80,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
            },
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo.png"),
              radius: 30,
            ),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Moussa DIARRA',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Enquêteur',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.message,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              widget.enquete['titre'] ?? "Titre de l'enquête",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            Text(
              widget.enquete['description'] ?? "Description de l'enquête",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isApplied
                  ? null
                  : _applyForSurvey,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A1B34),
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
              child: Text(
                isApplied ? "Candidature envoyée" : "Postuler",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 20),
            if (isApplied && !isAccepted)
              Text("Votre candidature est en attente de validation par l'admin.",
                  style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            if (isAccepted)
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuestionnaireScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: Text(
                  "Répondre aux questions",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
