import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

/**
Button to add in the AppBar to access a user profile menu 
(with signOut, delete account, name configuration and back button)
*/
class ProfileButton extends StatelessWidget {
  const ProfileButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.person),
      onPressed: () {
        print('Bouton de profil utilisateur pressé');
        Navigator.push(
          context,
          MaterialPageRoute<ProfileScreen>(
            builder: (context) => ProfileScreen(
              appBar: AppBar(title: const Text('User Profile v5'), actions: [
                IconButton(
                  icon: const Icon(Icons.logout),
                  onPressed: () {
                    signOutMethod(context);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete_forever),
                  onPressed: () {
                    deleteAccountMethod(context);
                  },
                ),
              ]),
            ),
          ),
        );
      },
    );
  }

  void signOutMethod(BuildContext context) {
    try {
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pop();
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
}
