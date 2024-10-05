import 'package:admin_app/src/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'firebase_options.dart';
import 'decorations.dart';
import 'guard/auth_gate.dart';
import 'src/store/appstate.dart';

final actionCodeSettings = ActionCodeSettings(
  url: 'https://murderparty-83b6c.firebaseapp.com',
  handleCodeInApp: true,
  androidMinimumVersion: '1',
  androidPackageName: 'io.flutter.plugins.firebase_ui.firebase_ui_example',
  iOSBundleId: 'io.flutter.plugins.fireabaseUiExample',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  String get initialRoute {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return '/';
    }
    return '/home';
  }

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

    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
          title: 'Murder Party Admin',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromARGB(255, 94, 97, 240)),
          ),
          initialRoute: initialRoute,
          routes: {
            '/': (context) {
              return AuthGate();
            },
            '/forgot-password': (context) {
              final arguments = ModalRoute.of(context)?.settings.arguments
                  as Map<String, dynamic>?;

              return ForgotPasswordScreen(
                email: arguments?['email'],
                headerMaxExtent: 200,
                headerBuilder: headerIcon(Icons.lock),
                sideBuilder: sideIcon(Icons.lock),
              );
            },           
            '/home': (context) {
              return HomeScreen();
            },
          }),
    );
  }
}
