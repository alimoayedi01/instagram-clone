import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/login_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
  static const routeName = 'AuthScreensssss';
}

class _AuthScreenState extends State<AuthScreen> {
  var auth = FirebaseAuth.instance;
  late UserCredential response;
  Future<void> createUser(
      String email, String username, String password, bool isLogin) async {
    if (isLogin) {
     
      response = await auth.signInWithEmailAndPassword(
          email: email, password: password);
    } else {
      response = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await FirebaseFirestore.instance
          .collection('users')
          .doc(response.user!.uid)
          .set({
        'username': username,
        'email': email,
      });
      email = '';
      username = '';
      password = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Card(
            color: Colors.black,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: LoginForm(createUser)),
      ),
    );
  }
}
