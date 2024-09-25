import 'package:admin_app/src/content.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Murder Party - Admin'),
        actions: [
          //TODO add your actions here
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              signOutMethod(context);
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: MyContent(),
    );
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
}
