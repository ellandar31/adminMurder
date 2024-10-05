import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';

import 'config.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final mfaAction = AuthStateChangeAction<MFARequired>(
      (context, state) async {
        final nav = Navigator.of(context);

        await startMFAVerification(
          resolver: state.resolver,
          context: context,
        );

        nav.pushReplacementNamed('/home');
      },
    );

    return SignInScreen(
      providers: [
        EmailAuthProvider(),
        GoogleProvider(clientId: GOOGLE_CLIENT_ID),
      ],
      actions: [
        ForgotPasswordAction((context, email) {
          Navigator.pushNamed(
            context,
            '/forgot-password',
            arguments: {'email': email},
          );
        }),
        AuthStateChangeAction((context, state) {
          // Déclaration de la variable `user`
          final user = state is SignedIn
              ? state.user
              : state is CredentialLinked
                  ? state.user
                  : state is UserCreated
                      ? state.credential.user
                      : null;

          // Vérification si l'utilisateur n'est pas null
          if (user != null) {
            Navigator.pushReplacementNamed(context, '/home');
          }
        }),
        mfaAction,
      ],
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
            child: Image.asset('default/flutterfire_300x.png'),
          ),
        );
      },
    );
  }
}
