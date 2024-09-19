import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'menus/menuItem.dart';
import 'store/appstate.dart';
import 'widget/grid_list.dart';
import 'menus/menuapp.dart';


class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        print(user.uid);
      }
    });

    return Scaffold(
      body: Container(
        color: Theme.of(context).colorScheme.primaryContainer,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              // Update MyAppState with the error message
              context.read<MyAppState>().errorMessage(snapshot.error.toString());
              return Center(child: Text('Erreur: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              context.read<MyAppState>().initUsersList([]);
              return Center(child: Text('Aucun utilisateur trouvé.'));
            }

            context.read<MyAppState>().initUsersList(snapshot.data!.docs);

            Widget page;
            switch (selectedIndex) {
              case 0:
                page = GridListPage();
                break;
              case 1:
                page = GridListPage();
                break;
              default:
                throw UnimplementedError('no widget for $selectedIndex');
            }

            return page;
          },
        ),
      ),
      bottomNavigationBar: menuFunc(true),
    );
  }

  CustomNavigationRail menuFunc(bool bottomNavBarBool) {
    return CustomNavigationRail(
      itemList: [
        MenuItem(icone: Icon(Icons.grid_3x3), label: 'Grille/Liste'),
        MenuItem(icone: Icon(Icons.grid_3x3), label: 'Grille/Liste'),
      ],
      bottomNavBar: bottomNavBarBool,
      selectedIndex: selectedIndex,
      onDestinationSelected: (value) {
        setState(() {
          selectedIndex = value;
        });
      },
    );
  }
}
