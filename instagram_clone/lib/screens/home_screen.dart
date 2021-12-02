import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:instagram_clone/screens/direct_screen.dart';
import 'package:instagram_clone/screens/post_screen1.dart';
import 'package:instagram_clone/screens/show_story_screen.dart';
import 'package:instagram_clone/screens/show_user_story_screen.dart';
import 'package:provider/provider.dart';

import '/screens/post_screen.dart';

import '/widgets/badge.dart';
import '/widgets/stories_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
  static const routeName = 'HomeScreen';
}

class _HomeScreenState extends State<HomeScreen> {
  var chosenImage;

  void choseInput(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () async {
                            // Provider.of<Content>(context, listen: false)
                            //     .addPost(
                            //         context,
                            //         FirebaseAuth.instance.currentUser!.uid,
                            //         ImageSource.gallery);
                            Provider.of<Content>(context, listen: false)
                                .pickStoryImage(ImageSource.gallery, context);

                            // Provider.of<Content>(context, listen: false)
                            //     .pickedStoryImage(context);
                          },
                          icon: Icon(Icons.add_box_outlined),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Gallery',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () async {
                            //     Provider.of<Content>(context, listen: false)
                            //         .addPost(
                            //   context,
                            //   FirebaseAuth.instance.currentUser!.uid,
                            //   ImageSource.camera,
                            // );
                            Provider.of<Content>(context, listen: false)
                                .pickStoryImage(ImageSource.camera, context);

                            // Provider.of<Content>(context, listen: false)
                            //     .pickedStoryImage(context);
                          },
                          icon: Icon(Icons.add_circle_rounded),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Camera',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        backgroundColor: Colors.black12);
  }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Content>(context);

    final mediaQuery = MediaQuery.of(context);
    return FutureBuilder(
      future: providerData.fetchAllUserObjects(),
      builder: (ctx, snapshot1) => snapshot1.hasData
          ? FutureBuilder(
              future: providerData.fetchUserFollowings(),
              builder: (ctx, snapshot) => snapshot.hasData ||
                      snapshot.data == null
                  ? Scaffold(
                      appBar: AppBar(
                        title: Text(
                          'Instagram',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: Colors.white),
                        ),
                        actions: [
                          IconButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(DirectScreen.routeName);
                              },
                              icon: Icon(
                                Icons.keyboard_arrow_right_outlined,
                                color: Colors.white,
                              )),
                        ],
                        backgroundColor: Colors.black,
                      ),
                      backgroundColor: Colors.black,
                      body: Column(
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(children: [
                            Padding(
                              // the users account picture... trigers posting a story function.
                              padding: const EdgeInsets.all(8.0),
                              child: FutureBuilder(
                                builder: (ctx, snapshot) => snapshot.hasData
                                    ? GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) {
                                                return ShowUserStoryScreen(
                                                    snapshot.data);
                                              },
                                            ),
                                          );
                                        },
                                        child: CircleAvatar(
                                          radius: 35,
                                          backgroundImage: NetworkImage(
                                              'https://thumbs.dreamstime.com/z/social-media-icon-user-user-frame-instagram-gradient-insta-user-button-symbol-sign-instagram-stories-user-logo-image-vector-154768156.jpg'),
                                        ),
                                      )
                                    : GestureDetector(
                                        child: Badge(),
                                        onTap: () => choseInput(context),
                                      ),
                                future: providerData.fetchUserStoryUrl(),
                              ),
                            ),
                            // users following stories
                            FutureBuilder(
                              builder: (ctx, snapshot) => snapshot.hasData
                                  ? StoriesContainer(snapshot.data
                                      as List<Map<String, String>>)
                                  : Center(
                                      child: CircularProgressIndicator(),
                                    ),
                              future: providerData.showUsersFollowingStories(),
                            ),
                          ]),
                          // Divider(
                          //   thickness: 0.16,
                          //   color: Colors.grey,
                          // ),
                          Expanded(
                            child: ListView.builder(
                              //shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (ctx, index) => PostScreen1(
                                  Content.userFollowingsPosts[index],
                                  Content.usersFollowings),
                              itemCount: Content.numberOfPostsToShow,
                            ),
                          ),

                          // Container(
                          //     height: mediaQuery.size.height * 0.7,
                          //     width: mediaQuery.size.width,
                          //     child: PostScreen()),
                        ],
                      ),
                    )
                  : Scaffold(
                      backgroundColor: Colors.black,
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
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
