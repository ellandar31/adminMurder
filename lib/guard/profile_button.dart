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
        Navigator.push(
          context,
          MaterialPageRoute<ProfileScreen>(
            builder: (context) => ProfileScreen(
              appBar: AppBar(
                title: const Text('User Profile'),
              ),
              actions: [
                SignedOutAction((context) {
                  Navigator.of(context).pop();
                }),
              ],
            ),
          ),
        );
      },
    );
  }
}
