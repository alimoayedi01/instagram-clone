import 'package:flutter/material.dart';
import 'package:instagram_clone/model/user.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:instagram_clone/widgets/followButton.dart';
import 'package:instagram_clone/widgets/seached_user_post_grid_view.dart';
import 'package:instagram_clone/widgets/searchedUserAppbar.dart';
import 'package:instagram_clone/widgets/searched_user_bio_widget.dart';
import 'package:instagram_clone/widgets/user_post_gridview.dart';
import 'package:provider/provider.dart';

import '../widgets/user_bio_widget.dart';
import '/widgets/user_followers_info.dart';

class SearchedUserProfileScreen extends StatefulWidget {
  const SearchedUserProfileScreen({Key? key}) : super(key: key);
  static const routeName = 'SearchedUserProfileScreen';

  @override
  _SearchedUserProfileScreenState createState() =>
      _SearchedUserProfileScreenState();
}

class _SearchedUserProfileScreenState extends State<SearchedUserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Content>(context, listen: false);
    final userName = ModalRoute.of(context)!.settings.arguments as String;
    //providerData.allUsers();
    providerData.fetchAllUserObjects();
    List<Users> allUsers = [];
    allUsers = providerData.allUserObjects;
    var id;

    for (int i = 0; i < allUsers.length; i++) {
      if (allUsers[i].username == userName) {
        id = allUsers[i].id;
      }
    }
 
    return FutureBuilder(
      future: providerData.fetchSearchedUserPosts(id),
      builder: (context, snapshot1) => snapshot1.hasData
          ? FutureBuilder(
              future: providerData.fetchUserFollowers(),
              builder: (ctx, snapshot) => snapshot.hasData
                  ? Scaffold(
                      backgroundColor: Colors.black,
                      appBar: SearchedUserAppBar(id),
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
                                  UserFollowerInfo(snapshot1.data.toString(),
                                      snapshot.data.toString()),

                                  //custom

                                  SizedBox(
                                    height: 15,
                                  ),

                                  SearchedUserBioWidget(id),

                                  //custom

                                  SizedBox(
                                    height: 15,
                                  ),
                                  //  EditProfileBotton(),
                                  FollowButton(id),
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
                          SearchedUserPostGridView(id)
                        ],
                      ),
                    )
                  : Scaffold(
                      backgroundColor: Colors.black,
                      body: Center(child: CircularProgressIndicator()),
                    ),
            )
          : Scaffold(
              backgroundColor: Colors.black,
              body: Center(child: CircularProgressIndicator())),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => throw UnimplementedError();
}
