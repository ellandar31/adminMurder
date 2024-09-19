import 'package:cloud_firestore/cloud_firestore.dart';

class User {
   String uid;
   String email;
   String role;
   bool isActive;

  User({
    required this.uid,
    required this.email,
    required this.role,
    required this.isActive,
  });

  @override
  String toString() {    
    return "$email \n($role)";
  }

//----------------------------------------------
//     Transformers
//----------------------------------------------

  // Méthode pour convertir un User en Map pour Firestore
   Map<String, dynamic> toMap() {
    return {
        'email': email,
        'role': role,
        'approvedByAdmin': isActive,
      };
  }

  // Méthode pour créer un User à partir d'un DocumentSnapshot de Firestore
  factory User.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic>? data = doc.data();
    return User(
      uid : doc.id,
      email: data?['email'] ?? '',
      role: data?['role'] ?? 'user',
      isActive: data?['approvedByAdmin'] ?? false,
    );
  }
  
//----------------------------------------------
//     Interaction avec la base de données
//----------------------------------------------

  Future<void> createUser(User user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(user.email);
    
    // Convertir l'objet User en Map et l'ajouter à Firestore
    await docUser.set(user.toMap());
  }

  Future<User?> getUser(String email) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(email);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return User.fromFirestore(snapshot);
    } else {
      return null; // L'utilisateur n'existe pas
    }
  }

  Future<void> updateUser() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

    // Mettre à jour les champs de l'utilisateur
    await docUser.update(toMap());
  }

  Future<void> deleteUser(String email) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(email);

    // Supprimer le document de l'utilisateur
    await docUser.delete();
  }

}
