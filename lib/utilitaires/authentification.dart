
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class Authentification {

  var instance = FirebaseAuth.instance;/*
  final _formKey = GlobalKey<FormState>(); 

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();*/

  Future<void> signUp() 
  async {
    // ... (code d'inscription)
  }

  Future<UserCredential> signInWithGoogle() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({
      'login_hint': 'user@example.com'
    });

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);

    // Or use signInWithRedirect
    // return await FirebaseAuth.instance.signInWithRedirect(googleProvider);
  }

  Future<UserCredential> signInWithGoogleMobile() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<void> signInEmailPassword(context,email,password) async {
  try {
      UserCredential userCredential = await instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Connexion réussie')),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: 
            Text('Aucun utilisateur trouvé pour cette adresse email.')),
        );
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Mot de passe incorrect.')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(  

          const SnackBar(content: Text('Une erreur s\'est produite. Veuillez réessayer.')),
        );
      }
    }
  }

  Future<void> deconnection() async {
    await FirebaseAuth.instance.signOut();
  }
/*
  String? getCurrentUser(){
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
        for (final providerProfile in currentUser.providerData) {
            // ID of the provider (google.com, apple.com, etc.)
            final provider = providerProfile.providerId;

            // UID specific to the provider
            final uid = providerProfile.uid;

            // Name, email address, and profile photo URL
            final name = providerProfile.displayName;
            return providerProfile.email;
        }
    }
    return null;
  }
*/}