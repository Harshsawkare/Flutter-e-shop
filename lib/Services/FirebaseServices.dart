import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseServices {
  static saveUser(String name, email, uid, photo) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .set(
        {
          'email': email,
          'name': name,
          'uid' : uid,
          'photo' : photo,
          'joinedOn' : DateTime.now().toUtc()
        }, SetOptions(merge: true));
  }

  Future<Map<String,dynamic>?> getUser(String uid) async {
    Map<String,dynamic> user;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
    .get()
    .then((value){
      user = value.data()!;
      return user;
    });
  }
}