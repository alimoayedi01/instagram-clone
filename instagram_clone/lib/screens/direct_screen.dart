import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/direct_screen_appbar.dart';
import 'package:instagram_clone/widgets/direct_search_bar.dart';

class DirectScreen extends StatelessWidget {
  const DirectScreen({Key? key}) : super(key: key);
  static const routeName = 'directScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: DirectScreenAppBarr(FirebaseAuth.instance.currentUser!.uid),
      body: Column(
        children: [
          DirectSearchBar(),
        ],
      ),
    );
  }
}
