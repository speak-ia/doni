import 'package:flutter/material.dart';
import 'package:donidata/screen/profil_screen.dart';

class EnqueteDetailPage extends StatefulWidget {
  final Map<String, String> enquete;

  EnqueteDetailPage({required this.enquete});

  @override
  _EnqueteDetailPageState createState() => _EnqueteDetailPageState();
}

class _EnqueteDetailPageState extends State<EnqueteDetailPage> {
  bool _isApplying = false;

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
            onPressed: () {
              // Action pour l'icône de message (simulée)
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              // Action pour l'icône de menu (simulée)
            },
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
              onPressed: _isApplying
                  ? null
                  : () {
                      setState(() {
                        _isApplying = true;
                      });
                      Future.delayed(const Duration(seconds: 2), () {
                        setState(() {
                          _isApplying = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Candidature simulée avec succès"),
                          ),
                        );
                      });
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0A1B34),
                padding: const EdgeInsets.symmetric(
                    horizontal: 50, vertical: 15),
              ),
              child: _isApplying
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text(
                      'APPLIQUER',
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
