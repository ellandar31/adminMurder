
import 'package:cloud_firestore/cloud_firestore.dart';

class UserFireStore {
   String uid;
   String email;
   String role;
   bool isActive;

  static const String admin = "Admin";
  static const String player = "player";

  UserFireStore({
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
  factory UserFireStore.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    Map<String, dynamic>? data = doc.data();
    return UserFireStore(
      uid : doc.id,
      email: data?['email'] ?? '',
      role: data?['role'] ?? 'user',
      isActive: data?['approvedByAdmin'] ?? false,
    );
  }
  
//----------------------------------------------
//     Interaction avec la base de données
//----------------------------------------------
  static Future<List<UserFireStore>> getUserList() async {
    final docUsers = FirebaseFirestore.instance.collection('users');
    final snapshot = await docUsers.get();
    var userList = <UserFireStore>[];
    for (var current in snapshot.docs) {
      userList.add(UserFireStore.fromFirestore(current));
    }
    return userList;
  }

  static Future<void> createUser(UserFireStore user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(user.uid);
    
    // Convertir l'objet User en Map et l'ajouter à Firestore
    await docUser.set(user.toMap());
  }

  static Future<UserFireStore?> getUser(String email) async {
    final docUsers = FirebaseFirestore.instance.collection('users');
    final snapshot = await docUsers.get();

    for (var current in snapshot.docs) {
      UserFireStore curUser = UserFireStore.fromFirestore(current);
      if (curUser.email == email) return curUser;
    }
    return null;
  }

  Future<void> updateUser() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

    // Mettre à jour les champs de l'utilisateur
    await docUser.update(toMap());
  }

  Future<void> deleteUser() async {
    final docUser = FirebaseFirestore.instance.collection('users').doc(uid);

    // Supprimer le document de l'utilisateur
    await docUser.delete();
  }

  static Future<bool> isAdmin(String email) async{
    UserFireStore? user = await getUser(email);
    return user == null ? false : user.role == admin;
  }
}
