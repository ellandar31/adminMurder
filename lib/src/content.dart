import 'package:admin_app/guard/profile.dart';
import 'package:admin_app/src/store/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../menus/menuItem.dart';
import 'store/appstate.dart';
import 'widget/grid_list.dart';
import '../menus/menuapp.dart';

class MyContent extends StatefulWidget {
  @override
  State<MyContent> createState() => _MyContentState();
}

class _MyContentState extends State<MyContent> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

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
              context
                  .read<MyAppState>()
                  .errorMessage(snapshot.error.toString());
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
                page = GridListPage(isGridView: true,                                
                  items: context.watch<MyAppState>().userList,
                  getItemString: (user) => user.toString(),
                  isItemActive: (user) => user.isActive,
                  onItemTap: (user) {
                    context.read<MyAppState>().activeInactiveUser(user);
                  },                  
                );
                break;
              case 1:
                page = GridListPage(isGridView: true,                             
                  items: context.watch<MyAppState>().userList,
                  getItemString: (user) => user.toString(),
                  isItemActive: (user) =>  user.role == UserFireStore.admin,
                  onItemTap: (user) {
                    context.read<MyAppState>().changeRole(user);
                  },                  
                );
                break;
              case 2:
                page = ProfilePage(false);
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
        MenuItem(icone: Icon(Icons.rule), label: 'Activation'),
        MenuItem(icone: Icon(Icons.admin_panel_settings), label: 'Role'),
        MenuItem(icone: Icon(Icons.person), label: 'Profil'),
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
