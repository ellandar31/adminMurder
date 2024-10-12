
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'user.dart';

class MyAppState extends ChangeNotifier{

  String? _errorMessage;
  var userList =  [ ];

  initUsersList(List<QueryDocumentSnapshot> docs)
  {
    //purge
    userList.removeRange(0, userList.length);
    //remplissage
    for (var doc in docs)
    {
        userList.add(UserFireStore.fromFirestore(doc as DocumentSnapshot<Map<String, dynamic>>));
    }
    notifyListeners();
  }
    
  errorMessage(dynamic error)
  {
    _errorMessage = 'Erreur: ${error.toString()}';
    print(_errorMessage );
    notifyListeners();
  }
  
  void activeInactiveUser(UserFireStore user) {    
    user.isActive = !user.isActive;
    user.updateUser();
    notifyListeners();
  }
  
  void changeRole(UserFireStore user) {
    user.role = user.role == UserFireStore.player ? UserFireStore.admin : UserFireStore.player;
    user.updateUser();
    notifyListeners();
  }
}