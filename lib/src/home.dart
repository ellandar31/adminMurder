import 'package:admin_app/guard/profile.dart';
import 'package:admin_app/src/content.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

}
