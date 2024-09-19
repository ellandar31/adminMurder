
import 'package:admin_app/controller/LogController.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';
import 'myhomepage.dart';
import 'store/appstate.dart';

Future<void> main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 94, 97, 240)),
        ),
        home: MyHomePage(),//_handleAuth(),
      ),
    );
  }
}

Widget _handleAuth(){
  return StreamBuilder<User?>(stream: FirebaseAuth.instance.authStateChanges(), 
                            builder: ( BuildContext context, snapshot){
                              if (snapshot.hasData){
                                return MyHomePage();
                              }else{
                                return LogController();
                              }
                            });
}

