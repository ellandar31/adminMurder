import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

import '../src/home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  //TODO UPDATE with the key of your firebase project
  static const clientId =
      '312983175067-13o4bs9uq05hc68885u89bdop6oct6ck.apps.googleusercontent.com';

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              EmailAuthProvider(),
              GoogleProvider(clientId: clientId),
            ],
            /*
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(1),
                child: AspectRatio(
                  aspectRatio: 100,
                  child: Image.asset('default/flutterfire_300x.png'),
                ),
              );
            },*/
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to FlutterFire, please sign in!')
                    : const Text('Welcome to Flutterfire, please sign up!'),
              );
            },
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(2),
                child: AspectRatio(
                  aspectRatio: 10,
                  //child: Image.asset('default/flutterfire_300x.png'),
                ),
              );
            },
          );
        }

        return const HomeScreen();
      },
    );
  }
}
