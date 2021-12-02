import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/model/post.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:provider/provider.dart';

class UserPostCommentScreen extends StatefulWidget {
  UserPostCommentScreen({Key? key}) : super(key: key);

  static const routeName = 'UserCommentScreen';

  @override
  _UserPostCommentScreenState createState() => _UserPostCommentScreenState();
}

class _UserPostCommentScreenState extends State<UserPostCommentScreen> {
  final TextEditingController commentController = TextEditingController();

  List<Map<String, dynamic>> comments = [];

  Future<void> addComment(Post post, String comment) async {
    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user-posts')
        .doc(post.name)
        .collection('posts-comments')
        .add(
      {'comment': comment, 'user': FirebaseAuth.instance.currentUser!.uid},
    );
  }

  Future<int> fetchComments(Post post) async {
    comments = [];
    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user-posts')
        .doc(post.name)
        .collection('posts-comments')
        .get();
    for (int i = 0; i < url.size; i++) {
      comments.add(url.docs[i].data());
    }
    return comments.length;
  }

  @override
  Widget build(BuildContext context) {
    final post = ModalRoute.of(context)!.settings.arguments as Post;
    final providerData = Provider.of<Content>(context);
    return FutureBuilder(
      future: fetchComments(post),
      builder: (ctx, snapshot) => snapshot.hasData
          ? Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  'Comments',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              body: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                                'http://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png'),
                          ),
                          title: FutureBuilder(
                            future: providerData
                                .fetchSearchedUserUserName(post.postsOwnerid),
                            builder: (ctx, snapshot) => snapshot.hasData
                                ? Text(
                                    snapshot.data.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                : Text(''),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            post.caption,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 0.3,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (ctx, index) => Container(
                        child: ListTile(
                          leading: CircleAvatar(
                            radius: 16,
                            backgroundImage: NetworkImage(
                                'http://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png'),
                          ),
                          title: FutureBuilder(
                            builder: (ctx, snapshot) => snapshot.hasData
                                ? Text(
                                    snapshot.data.toString() +
                                        '    ' +
                                        comments[index]['comment'],
                                    style: TextStyle(color: Colors.white),
                                  )
                                : Text(''),
                            future: providerData.fetchSearchedUserUserName(
                                comments[index]['user']),
                          ),
                        ),
                      ),
                      itemCount: comments.length,
                    ),
                  ),
                  Container(
                    color: Colors.grey[800],
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 20,
                        backgroundImage: NetworkImage(
                            'http://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png'),
                      ),
                      title: TextField(
                        controller: commentController,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          hintText: 'Add a comment...',
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                      ),
                      // ignore: deprecated_member_use
                      trailing: FlatButton(
                        onPressed: () async {
                          addComment(post, commentController.text);
                          setState(() {});
                        },
                        child: Text(
                          'Post',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }
}
