import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../store/appstate.dart';

class GridListPage extends StatefulWidget {

  const GridListPage({
    super.key, 
  });

  @override
  _GridListPageState createState() => _GridListPageState();
}

class _GridListPageState extends State<GridListPage> {
  bool _isGridView = true;
  
  final colorActive =  Color.fromARGB(255, 11, 151, 13);
  final colorInactive = Color.fromARGB(255, 91, 87, 87);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.blue,
      appBar: AppBar( //Header de la page permettant d'afficher une grille ou une liste 
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.list : Icons.grid_view),
            onPressed: () {
              setState(() {
                _isGridView = !_isGridView;
              });
            },
          )
        ],
      ),
      body: _isGridView ? _buildGridView(context) : _buildListView(context),
    );
  }

  Widget _buildGridView(BuildContext context) {
    var itemList = context.watch<MyAppState>().userList;

    return GridView.builder(
      padding: const EdgeInsets.all(8.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 4.0,
        mainAxisSpacing: 4.0,
      ),
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final itemCur = itemList[index];
        return SizedBox(
          width: 100,  // Largeur fixe pour chaque carte
          height: 80,  // Hauteur fixe pour chaque carte
          child: InkWell(
          onTap: () {
            context.read<MyAppState>().activeInactiveUser(index, !itemCur.isActive);
          },
          child: Card(
              color: itemCur.isActive ? colorActive : colorInactive,
              elevation: 4.0,
              child: Center(
                child: 
                Column(
                  mainAxisAlignment: MainAxisAlignment.center, // Centre verticalement
                crossAxisAlignment: CrossAxisAlignment.center, // Centre horizontalement
                  children: [
                    Icon(Icons.person_outline,size: 50.0,),
                    Text(
                      itemCur.toString(),
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
    var itemList = context.watch<MyAppState>().userList;

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        final itemCur = itemList[index];
        return ListTile(
          tileColor : itemCur.isActive ? colorActive : colorInactive,
          title: Text(itemCur.toString()),
          trailing: Checkbox(
            value: itemCur.isActive,
            onChanged: (bool? value) {
              context.read<MyAppState>().activeInactiveUser(index, value ?? true);
            },
          ),
        );
      },
    );
  }
}
