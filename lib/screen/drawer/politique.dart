import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Politique De Confidentialité"),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            "Politique de Confidentialité de DoniData",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 10),
          Text(
            "Date d'entrée en vigueur : [14/08/2024]\n\n"
            "Chez DoniData, nous nous engageons à protéger votre vie privée. "
            "Cette politique de confidentialité explique comment nous collectons, utilisons, "
            "partageons et protégeons vos informations personnelles lorsque vous utilisez notre application mobile.\n\n"
            "1. Informations que nous collectons :\n"
            "   - Données fournies par l'utilisateur : ...\n"
            "   - Données de localisation : ...\n"
            "   - Données de l'appareil : ...\n\n"
            "2. Utilisation des informations :\n"
            "   - Fournir, exploiter et améliorer nos services.\n"
            "   - Personnaliser l'expérience utilisateur.\n\n"
            "3. Partage des informations :\n"
            "   - Respect des obligations légales.\n"
            "   - Protection des droits.\n\n"
            "Pour plus de détails, veuillez consulter notre site officiel.",
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}