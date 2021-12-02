import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:instagram_clone/screens/addPostScreen.dart';
import 'package:instagram_clone/screens/auth_screen.dart';
import 'package:instagram_clone/screens/comment_screen.dart';
import 'package:instagram_clone/screens/direct_screen.dart';
import 'package:instagram_clone/screens/home_screen.dart';
import 'package:instagram_clone/screens/post_screen.dart';
import 'package:instagram_clone/screens/searched_user_post_screen.dart';
import 'package:instagram_clone/screens/serachedUserProfileScreen.dart';
import 'package:instagram_clone/screens/user_post_comment_screen.dart';
import 'package:instagram_clone/widgets/choose_profile_image.dart';
import 'package:provider/provider.dart';

import '/screens/exploreScreen.dart';
import '/screens/notification_screen.dart';
import '/screens/user_profile_screen.dart';
import 'package:firebase_core/firebase_core.dart';

import 'widgets/bottom_navigation_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (cont) => Content())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram-Clone',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (ctx, snapshot) {
            if (snapshot.hasData) {
              return MyBottomNavigationBar();
            }
            return AuthScreen();
          },
        ),
        routes: {
          ExploreScreen.routeName: (ctx) => ExploreScreen(),
          NotificationScreen.routeName: (ctx) => NotificationScreen(),
          UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
          AddPostScreen.routeName: (ctx) => AddPostScreen(),
          PostScreen.routeName: (ctx) => PostScreen(),
          ChooseProfileImage.routeName: (ctx) => ChooseProfileImage(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          MyBottomNavigationBar.routeName: (ctx) => MyBottomNavigationBar(),
          SearchedUserProfileScreen.routeName: (ctx) =>
              SearchedUserProfileScreen(),
          DirectScreen.routeName: (ctx) => DirectScreen(),
          CommentScreen.routeName: (ctx) => CommentScreen(),
          UserPostCommentScreen.routeName: (ctx) => UserPostCommentScreen(),
          SearchedUserPostScreen.routeName: (ctx) => SearchedUserPostScreen(),
        },
      ),
    );
  }
}
