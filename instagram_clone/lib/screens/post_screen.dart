import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:instagram_clone/screens/comment_screen.dart';
import 'package:instagram_clone/screens/user_post_comment_screen.dart';
import 'package:provider/provider.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({Key? key}) : super(key: key);

  static const routeName = 'PostScreen';

  Future<int> numOfLikes(Post post) async {
    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user-posts')
        .doc(post.name)
        .get();
    final numOfLikes = url.data()!['numOfLikes'] as int;
    return numOfLikes;
  }

  Future<void> deletePost(Post post, BuildContext context) async {
    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user-posts')
        .doc(post.name)
        .delete();

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Post;

    final providerData = Provider.of<Content>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
          //profile image
          child: CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage(
                'http://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png'),
          ),
        ),
        //user name
        title: FutureBuilder(
          builder: (ctx, snapshot) => snapshot.hasData
              ? Text(
                  snapshot.data as String,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                )
              : Text(
                  '',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white),
                ),
          future: providerData.fetchUserName(),
        ),
        actions: [
          PopupMenuButton(
            color: Colors.black,
            icon: Icon(Icons.more_vert_rounded),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  'delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              PopupMenuItem(
                value: 1,
                child: Text(
                  'save',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            onSelected: (value) => {
              if (value == 0) deletePost(args, context),
            },
          )
        ],
      ),
      body: Container(
        color: Colors.black,
        child: Column(
          children: [
            Expanded(
              child: Image.network(
                args.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            UserPostCommentScreen.routeName,
                            arguments: args);
                      },
                      icon: Icon(
                        Icons.add_comment_rounded,
                        color: Colors.white,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                      )),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .40,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_border,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Container(
              width: double.infinity,
              child: Column(
                //    mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
                    child: FutureBuilder(
                      builder: (ctx, snapshot) => snapshot.hasData
                          ? Text(
                              snapshot.data.toString() + " likes",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            )
                          : Text(
                              '',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white),
                            ),
                      future: numOfLikes(args),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder(
                          builder: (ctx, snapshot) => snapshot.hasData
                              ? Text(
                                  snapshot.data as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                )
                              : Text(
                                  '',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                          future: providerData.fetchUserName(),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Container(
                              // height: 50,
                              child: Text(
                                args.caption,
                                style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            UserPostCommentScreen.routeName,
                            arguments: args);
                      },
                      child: Text(
                        'View all comments',
                        style: TextStyle(color: Colors.white60, fontSize: 16),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
