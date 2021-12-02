import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:instagram_clone/widgets/user-profile-appbar.dart';
import 'package:instagram_clone/widgets/user_post_gridview.dart';
import 'package:provider/provider.dart';

import '../widgets/user_edit_profile_botton.dart';
import '../widgets/user_bio_widget.dart';
import '/widgets/user_followers_info.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);
  static const routeName = 'userProfileScreen';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Content>(context, listen: false);
    //final userName = providerData.fetchUserName();
    // providerData.fetchUserFollowings();
    //providerData.allUsers();
    // providerData.showUsersFollowingStories();
    return FutureBuilder(
      future: providerData.fetchPosts(),
      builder: (context, snapshot) => snapshot.hasData
          ? FutureBuilder(
              future: providerData.fetchUserFollowings(),
              builder: (ctx, snapshot1) => snapshot.hasData ||
                      snapshot.data == null
                  ? FutureBuilder(
                      future: providerData.fetchUserFollowers(),
                      builder: (ctx, snapshot) => snapshot.hasData ||
                              snapshot.data == null
                          ? Scaffold(
                              backgroundColor: Colors.black,
                              appBar: MyAppbar(
                                  FirebaseAuth.instance.currentUser!.uid),
                              body: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SingleChildScrollView(
                                    child: Container(
                                      margin: EdgeInsets.all(12),
                                      //  height: MediaQuery.of(context).size.height * .45,
                                      width: double.infinity,
                                      child: Column(
                                        children: [
                                          UserFollowerInfo(
                                              snapshot1.data == null
                                                  ? '0'
                                                  : snapshot1.data.toString(),
                                              snapshot.data == null
                                                  ? '0'
                                                  : snapshot.data.toString()),

                                          //custom

                                          SizedBox(
                                            height: 15,
                                          ),

                                          BioWidget(),

                                          //custom

                                          SizedBox(
                                            height: 15,
                                          ),
                                          EditProfileBotton(),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          Container(
                                            width: double.infinity,
                                            child: Column(
                                              //    mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Story Highlights',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  'Keep your favorite stories on your profile',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  UserPostGridView()
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
            )
          : Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
