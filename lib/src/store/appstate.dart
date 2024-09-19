
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'user.dart';

class MyAppState extends ChangeNotifier{

  String? _errorMessage;

  initUsersList(List<QueryDocumentSnapshot> docs)
  {
    //purge
    userList.removeRange(0, userList.length);
    //remplissage
    for (var doc in docs)
    {
        userList.add(User.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>));
    }
    notifyListeners();
  }
  
  
  errorMessage(dynamic error)
  {
    _errorMessage = 'Erreur: ${error.toString()}';
    print(_errorMessage );
    notifyListeners();
  }

//----------------------------------------------
//     WordPair
//----------------------------------------------
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

//----------------------------------------------
//     Favorites
//----------------------------------------------

  var favorites = <WordPair>[];

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

//----------------------------------------------
//     Users
//----------------------------------------------

  var userList =  [ ];

  
  void activeInactiveUser(int index, bool active ) {
    User toUpdate = userList.elementAt(index);
    toUpdate.isActive = active;
    toUpdate.updateUser();
    notifyListeners();
  }
}