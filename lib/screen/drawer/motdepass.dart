import 'package:donidata/authentification/login.dart';
import 'package:donidata/authentification/mdpforgot.dart';
import 'package:donidata/authentification/custom_textfield.dart'; 
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PasswordManagementPage extends StatefulWidget {
  @override
  _PasswordManagementPageState createState() => _PasswordManagementPageState();
}

class _PasswordManagementPageState extends State<PasswordManagementPage> {
  final _auth = FirebaseAuth.instance;

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _updatePassword() async {
  final currentPassword = _currentPasswordController.text;
  final newPassword = _newPasswordController.text;
  final confirmPassword = _confirmPasswordController.text;

  if (newPassword != confirmPassword) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Les nouveaux mots de passe ne correspondent pas.')),
    );
    return;
  }

  try {
    final user = _auth.currentUser;

    if (user != null) {
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);

      
      await user.updatePassword(newPassword);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mot de passe mis à jour avec succès !')),
      );

    
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()), 
        (route) => false, 
      );
    }
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur : Le mot de passe actuel est incorrect.')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion Mot De Passe'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: _currentPasswordController,
              icon: Icons.lock,
              hintText: 'Mot De Passe Actuel',
              obscureText: true,
            ),
            SizedBox(height: screenHeight * 0.02),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Mdpforgot(),
                    ),
                  );
                },
                child: Text('Mot De Passe Oublié'),
              ),
            ),
            CustomTextField(
              controller: _newPasswordController,
              icon: Icons.lock,
              hintText: 'Nouveau Mot De Passe',
              obscureText: true,
            ),
            SizedBox(height: screenHeight * 0.02),
            CustomTextField(
              controller: _confirmPasswordController,
              icon: Icons.lock,
              hintText: 'Confirmer Nouveau Mot De Passe',
              obscureText: true,
            ),
            SizedBox(height: screenHeight * 0.02),
            SizedBox(
              height: screenHeight * 0.08,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _updatePassword,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff0A1B34),
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Confirmer le Changement', style: TextStyle(color: Colors.white),),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
