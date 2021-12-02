import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:instagram_clone/widgets/bottom_navigation_bar.dart';
import 'package:instagram_clone/widgets/choose_profile_image.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final Function createUser;
  LoginForm(this.createUser);

  @override
  _LoginFormState createState() => _LoginFormState();
}

final formKey = GlobalKey<FormState>();
var username = '';
var password = '';
var email = '';

bool isLogin = false;

//bool hasProfile = false;

//var profilePic;

class _LoginFormState extends State<LoginForm> {
  void submitData(bool loading) async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      formKey.currentState!.save();
      widget.createUser(email, username, password, isLogin);
    }
    // if (loading) {
    //   Navigator.of(context).pushNamed(MyBottomNavigationBar.routeName);
    // } else {
    //   Navigator.of(context).pushNamed(ChooseProfileImage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Instagram',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.white),
            ),
            SizedBox(
              height: 12,
            ),

            Card(
              color: Colors.grey[800],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  key: ValueKey('email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (data) {
                    if (data!.isEmpty) return "please type in your email";
                  },
                  onSaved: (data) {
                    email = data!;
                  },
                  decoration: InputDecoration(
                    errorStyle: TextStyle(color: Colors.white),
                    labelText: 'email address',
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 12,
            ),
            if (!isLogin)
              Card(
                color: Colors.grey[800],
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: TextFormField(
                    style: TextStyle(color: Colors.white),
                    key: ValueKey('user'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (data) {
                      if (data!.isEmpty)
                        return "please type in your username or email";
                    },
                    onSaved: (data) {
                      username = data!;
                    },
                    decoration: InputDecoration(
                      errorStyle: TextStyle(color: Colors.white),
                      labelText: 'username',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            SizedBox(
              height: 5,
            ),
            Card(
              color: Colors.grey[800],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  key: ValueKey('password'),
                  validator: (data) {
                    if (data!.length < 7) {
                      return 'password must be at least 7 charachters';
                    }
                  },
                  onSaved: (data) {
                    password = data!;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    labelText: 'Password',
                    errorStyle: TextStyle(color: Colors.white),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 50),
              color: Colors.blue,
              onPressed: () => submitData(isLogin),
              child: Text(
                isLogin ? 'Log In' : 'Sign Up',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 50),
              color: Colors.blue,
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(
                isLogin ? 'Sign up' : "I already have an account",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
