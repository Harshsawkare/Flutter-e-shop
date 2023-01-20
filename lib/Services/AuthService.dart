import 'package:eshop/Screens/Homepage.dart';
import 'package:eshop/Screens/Signup.dart';
import 'package:eshop/Services/FirebaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthServices {
  Future<bool?> signupUser(
      String email, String password, String name, BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await FirebaseAuth.instance.currentUser!.updateDisplayName(name);
      await FirebaseAuth.instance.currentUser!.updateEmail(email);
      await FirebaseServices.saveUser(name, email, userCredential.user!.uid, userCredential.user!.photoURL);

      String uid = await FirebaseAuth.instance.currentUser!.uid;

      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          Homepage(uid: uid,)
      ));

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Registration Successful')));
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Password Provided is too weak')));
        return false;
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Email Provided already Exists')));
        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<bool?> signinUser(String email, String password, BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      String uid = await FirebaseAuth.instance.currentUser!.uid;

      Navigator.push(context, MaterialPageRoute(builder: (context) =>
          Homepage(uid: uid,)
      ));

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('You are Logged in')));
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user Found with this Email')));
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            Signup()
        ));
        return false;
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Password did not match')));
        return false;
      }
    }
  }
}