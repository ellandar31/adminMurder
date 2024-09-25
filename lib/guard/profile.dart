import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;

class ProfilePage extends StatelessWidget {
  late String name;
  late String email;
  late String profileImageUrl;

  ProfilePage({
    super.key,
  }) {
    var user = FirebaseAuth.instance.currentUser;
    name = user!.displayName ?? '';
    email = user!.email ?? '';
    profileImageUrl = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mon Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            // Photo de profil
            Icon(
              Icons.account_circle,
              size: 100.0,
            ),

            // Nom de l'utilisateur
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Adresse e-mail de l'utilisateur
            Text(
              email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Bouton de déconnexion
            ElevatedButton.icon(
              onPressed: () {
                signOutMethod(context);
              },
              icon: const Icon(Icons.logout),
              label: const Text('Se déconnecter'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                deleteAccountMethod(context);
              },
              icon: const Icon(Icons.delete, color: Colors.white),
              label: const Text('Supprimer mon compte',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

void signOutMethod(BuildContext context) {
  try {
    Navigator.pushReplacementNamed(context, '/');
    //FirebaseAuth.instance.signOut();
    //Navigator.of(context).pop();
  } catch (e) {
    debugPrint('Erreur lors de la déconnexion: $e');
  }
}

void deleteAccountMethod(BuildContext context) async {
  try {
    // Demander confirmation avant de supprimer le compte
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Supprimer le compte'),
        content: const Text('Voulez-vous vraiment supprimer votre compte ?'),
        actions: [
          TextButton(
            child: const Text('Non'),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: const Text('Oui'),
            onPressed: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );

    if (confirm ?? false) {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        debugPrint('Compte supprimé avec succès');
        Navigator.of(context, rootNavigator: true).pop();
      } else {
        debugPrint('Erreur : Utilisateur non connecté');
      }
    }
  } catch (e) {
    debugPrint('Erreur lors de la suppression du compte: $e');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Erreur lors de la suppression du compte: $e')),
    );
  }
}
