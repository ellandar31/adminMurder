import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store/appstate.dart';

class GridListPage<T> extends StatelessWidget {
  GridListPage({
    Key? key,
    required this.isGridView,
    required this.items,
    required this.getItemString,
    required this.isItemActive,
    required this.onItemTap,
    this.activeColor = const Color.fromARGB(255, 11, 151, 13),
    this.inactiveColor = const Color.fromARGB(255, 91, 87, 87),
  }) : super(key: key);

  final bool isGridView;
  final List<T> items;
  final String Function(T item) getItemString;
  final bool Function(T item) isItemActive;
  final void Function(T item) onItemTap;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: isGridView ? _buildGridView(context) : _buildListView(context),
    );
  }

  Widget _buildGridView(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final itemCur = items[index];
        return SizedBox(
          width: 10, // Largeur fixe pour chaque carte
          height: 8, // Hauteur fixe pour chaque carte
          child: InkWell(
            onTap: () {
              onItemTap(itemCur);
            },
            child: Card(
              color: isItemActive(itemCur) ? activeColor : inactiveColor,
              elevation: 4.0,
              child: Center(
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Centre verticalement
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Centre horizontalement
                  children: [
                    Icon(
                      Icons.person_outline,
                      size: 50.0,
                    ),
                    Text(
                      getItemString(itemCur),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildListView(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final itemCur = items[index];
        return ListTile(
          tileColor: isItemActive(itemCur) ? activeColor : inactiveColor,
          title: Text(getItemString(itemCur)),
          trailing: Checkbox(
            value: isItemActive(itemCur),
            onChanged: (bool? value) {
              onItemTap(itemCur);
            },
          ),
        );
      },
    );
  }
}