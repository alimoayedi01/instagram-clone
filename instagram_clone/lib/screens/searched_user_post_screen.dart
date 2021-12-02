import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:instagram_clone/model/user.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:instagram_clone/screens/comment_screen.dart';
import 'package:provider/provider.dart';

class SearchedUserPostScreen extends StatefulWidget {
  static const routeName = 'SearchedUserPostScreen';

  @override
  _SearchedUserPostScreenState createState() => _SearchedUserPostScreenState();
}

class _SearchedUserPostScreenState extends State<SearchedUserPostScreen> {
  var likes = 0;

  // String fetchData() {
  //   for (int i = 0; i < widget.userFollowings.length; i++) {
  //     for (int j = 0; j < widget.userFollowings[i].userPosts.length; j++) {
  //       if (widget.currentPost.imageUrl ==
  //           widget.userFollowings[i].userPosts[j].imageUrl) {
  //         return widget.userFollowings[i].username;
  //       }
  //     }
  //   }
  //   return '';
  // }

  Future<int> numOfLikes(Post post, String id) async {
   
    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('user-posts')
        .doc(post.name)
        .get();
    final numOfLikes = url.data()!['numOfLikes'] as int;
    likes = numOfLikes;
    return numOfLikes;
  }

  Future<bool> likeAPost(Post post, String id) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    final url3 = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('user-posts')
        .doc(post.name)
        .get();
    var likedBy = url3.data()!['likedBy'] as List;
    if (!likedBy.contains(uid)) {
      final url = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('user-posts')
          .doc(post.name)
          .update({'numOfLikes': likes + 1});
      final url1 = await FirebaseFirestore.instance
          .collection('users')
          .doc(id)
          .collection('user-posts')
          .doc(post.name)
          .update({
        'likedBy': FieldValue.arrayUnion([uid]),
      });
      // likedBy = url3.data()!['likedBy'] as List;
      return true;
    } else {
      return false;
    }

    //final newValue = url.data()!.update('numOfLikes', (value) => value += 1);
  }

  Future<String> fetchLikedBy(Post post, String id) async {
   
    final url3 = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('user-posts')
        .doc(post.name)
        .get();
 
    var likedBy2 = url3.data()!['likedBy'] as List;
  
    if (likedBy2.contains(FirebaseAuth.instance.currentUser!.uid)) {
      return FirebaseAuth.instance.currentUser!.uid;
    } else {
      return '';
    }
  }

  var result = false;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    final providerData = Provider.of<Content>(context);
    final mediaQuery = MediaQuery.of(context);

    return Container(
      height: mediaQuery.size.height * 0.7,
      width: mediaQuery.size.width,
      child: Scaffold(
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
            future: providerData.fetchSearchedUserUserName(args[1]),
            builder: (ctx, snapshot) => snapshot.hasData
                ? Text(
                    snapshot.data as String,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                  )
                : Text(''),
          ),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
          ],
        ),
        body: Container(
          color: Colors.black,
          child: Column(
            children: [
              Expanded(
                child: Image.network(
                  // args.imageUrl,
                  args[0].imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: FutureBuilder(
                      builder: (ctx, snapshot) => snapshot.hasData
                          ? snapshot.data == ''
                              ? IconButton(
                                  onPressed: () async {
                                    result = await likeAPost(args[0], args[1]);
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    result == false
                                        ? Icons.favorite_border
                                        : Icons.favorite,
                                    color: Colors.white,
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.white,
                                  ),
                                )
                          : Text(''),
                      future: fetchLikedBy(args[0], args[1]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              CommentScreen.routeName,
                              arguments: args[0]);
                        },
                        icon: Icon(
                          Icons.insert_comment,
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
                    width: MediaQuery.of(context).size.width * .45,
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 3),
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
                        future: numOfLikes(args[0], args[1]),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                            future:
                                providerData.fetchSearchedUserUserName(args[1]),
                            builder: (ctx, snapshot) => snapshot.hasData
                                ? Text(
                                    snapshot.data as String,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white),
                                  )
                                : Text(''),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Container(
                                // height: 50,
                                child: Text(
                                  //  args.caption,
                                  args[0].caption,
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
                        onPressed: () {},
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
      ),
    );
  }
}
