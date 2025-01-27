import 'package:donidata/authentification/custom_textfield.dart';
import 'package:donidata/authentification/login.dart';
import 'package:donidata/services/firebase_auth.dart';
import 'package:donidata/services/toas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();

  final TextEditingController _fullnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool isSigningUp = false;

  @override
  void dispose() {
    _fullnameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[100]!, Colors.green[100]!, Colors.blue[300]!],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    height: 150,
                  ),
                  SizedBox(height: 30),
                  CustomTextField(
                    controller: _fullnameController,
                    icon: Icons.person,
                    hintText: 'Nom & Prénom',
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    controller: _emailController,
                    icon: Icons.email,
                    hintText: 'Email',
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    controller: _phoneController,
                    icon: Icons.phone,
                    hintText: 'Numéro de Téléphone...',
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    controller: _passwordController,
                    icon: Icons.lock,
                    hintText: 'Mot de Passe',
                    obscureText: true,
                  ),
                  SizedBox(height: 15),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    icon: Icons.lock,
                    hintText: 'Confirmer Mot de Passe',
                    obscureText: true,
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: isSigningUp ? null : _signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff0A1B34),
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 40,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: isSigningUp
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Text(
                            "S'inscrire",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Vous Avez Déjà Un Compte?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                            (route) => false,
                          );
                        },
                        child: Text(
                          'Se Connecter',
                          style: TextStyle(
                            color: Color(0xff0A1B34),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _signUp() async {
    if (_fullnameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      showToast(message: "Toutes les données sont requises");
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      showToast(message: "Passwords do not match");
      return;
    }

    setState(() {
      isSigningUp = true;
    });

    String fullname = _fullnameController.text;
    String email = _emailController.text;
    String phone = _phoneController.text;
    String password = _passwordController.text;

    try {
      User? user = await _auth.signUpWithEmailAndPassword(email, password);

      if (user != null) {
        
        await FirebaseFirestore.instance.collection('investigators').doc(user.uid).set({
          'fullname': fullname,
          'email': email,
          'phone': phone,
          'createdAt': DateTime.now(),
        });

        showToast(message: "Utilisateur créé avec succès");
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
          (route) => false,
        );
      }
    } catch (e) {
      showToast(message: e.toString());
    } finally {
      setState(() {
        isSigningUp = false;
      });
    }
  }
}
