// ignore_for_file: use_build_context_synchronously

import 'package:admin_app/myhomepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'snack_bar.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:google_sign_in_web/web_only.dart';


class AuthGoogleWidget extends StatefulWidget {
  const AuthGoogleWidget({super.key});

  @override
  _AuthGoogleWidgetState createState() => _AuthGoogleWidgetState();
}

class _AuthGoogleWidgetState extends State<AuthGoogleWidget> {

  final FirebaseAuth _auth = FirebaseAuth.instance;

    //TODO update with the correct clientId
  final GoogleSignIn _googleSignIn = GoogleSignIn(
  clientId: '312983175067-13o4bs9uq05hc68885u89bdop6oct6ck.apps.googleusercontent.com',);


  // Méthode de connexion avec Google
  Future<UserCredential> _signInWithGoogle() async {
    try {
      // Déclenche le flux d'authentification de Google
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // L'utilisateur a annulé la connexion
      showErrorSnackBar(context,"Utilisateur annulé");
        return Future.error("Utilisateur annulé");
      }

      // Obtenez les détails d'authentification de la demande
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Créez une nouvelle crédential pour l'utilisateur
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Une fois l'utilisateur authentifié, retournez les informations utilisateur
      return await _auth.signInWithCredential(credential);
    } catch (e) {
      showErrorSnackBar(context,"Erreur Google Sign-In: $e");
      return Future.error(e.toString());
    }
  }

  //affichage du bouton de connexion
  Column signGoogle(BuildContext context) {
    return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              renderButton(configuration: GSIButtonConfiguration(
                minimumWidth:50,
                type: GSIButtonType.standard,
                theme: GSIButtonTheme.filledBlack,
                size: GSIButtonSize.large,
                text: GSIButtonText.signin,
                shape: GSIButtonShape.pill,
              )),//doublon
            
              const SizedBox(height: 20),
            
              ElevatedButton.icon(
                icon: const Icon(Icons.login),
                onPressed: () async {
                  try {
                    await _signInWithGoogle();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  } catch (e) {
                    showErrorSnackBar(context,e.toString());
                  }
                },
                label: const Text('Sign in with Google'),
              )
            ]);
  }

  @override
  Widget build(BuildContext context) {
    return signGoogle(context);
  }
}
