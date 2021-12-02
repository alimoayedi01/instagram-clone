import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:instagram_clone/model/user.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:instagram_clone/screens/comment_screen.dart';
import 'package:provider/provider.dart';

class PostScreen1 extends StatefulWidget {
  final Post currentPost;
  final List<Users> userFollowings;
  PostScreen1(this.currentPost, this.userFollowings);

  static const routeName = 'PostScreen';

  @override
  _PostScreen1State createState() => _PostScreen1State();
}

class _PostScreen1State extends State<PostScreen1> {
  var likes = 0;

  String fetchData() {
    for (int i = 0; i < widget.userFollowings.length; i++) {
      for (int j = 0; j < widget.userFollowings[i].userPosts.length; j++) {
        if (widget.currentPost.imageUrl ==
            widget.userFollowings[i].userPosts[j].imageUrl) {
          return widget.userFollowings[i].username;
        }
      }
    }
    return '';
  }

  Future<int> numOfLikes(Post post) async {
    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(post.postsOwnerid)
        .collection('user-posts')
        .doc(post.name)
        .get();
    final numOfLikes = url.data()!['numOfLikes'] as int;
    likes = numOfLikes;
    return numOfLikes;
  }

  Future<bool> likeAPost(Post post) async {
    var uid = FirebaseAuth.instance.currentUser!.uid;
    final url3 = await FirebaseFirestore.instance
        .collection('users')
        .doc(post.postsOwnerid)
        .collection('user-posts')
        .doc(post.name)
        .get();
    var likedBy = url3.data()!['likedBy'] as List;
    if (!likedBy.contains(uid)) {
      final url = await FirebaseFirestore.instance
          .collection('users')
          .doc(post.postsOwnerid)
          .collection('user-posts')
          .doc(post.name)
          .update({'numOfLikes': likes + 1});
      final url1 = await FirebaseFirestore.instance
          .collection('users')
          .doc(post.postsOwnerid)
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

  Future<String> fetchLikedBy(Post post) async {
    final url3 = await FirebaseFirestore.instance
        .collection('users')
        .doc(post.postsOwnerid)
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
    // final args = ModalRoute.of(context)!.settings.arguments as Post;
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
          title: Text(
            fetchData(),
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
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
                  widget.currentPost.imageUrl,
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
                                    result =
                                        await likeAPost(widget.currentPost);
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
                      future: fetchLikedBy(widget.currentPost),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: IconButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(
                              CommentScreen.routeName,
                              arguments: widget.currentPost);
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
                                'loading...',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white),
                              ),
                        future: numOfLikes(widget.currentPost),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            fetchData(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
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
                                  widget.currentPost.caption,
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
                              CommentScreen.routeName,
                              arguments: widget.currentPost);
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
      ),
    );
  }
}
