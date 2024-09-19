import 'package:flutter/material.dart';

void showErrorSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.red, // Couleur d'arrière-plan pour les erreurs
    duration: const Duration(seconds: 10), // Durée d'affichage
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}