import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:instagram_clone/screens/addPostScreen.dart';
import 'package:provider/provider.dart';

import '/screens/user_profile_screen.dart';
import '/screens/exploreScreen.dart';
import '/screens/home_screen.dart';
import '/screens/notification_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
  static const routeName = 'bottomNavigationBar';
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int chosenIndex = 0;
  List<Widget> screens = [
    HomeScreen(),
    ExploreScreen(),
    NotificationScreen(),
    UserProfileScreen()
  ];

  void overrideScreen(int index) {
    if (index == 3) {
      setState(() {
        chosenIndex = 2;
      });
    } else if (index == 4) {
      setState(() {
        chosenIndex = 3;
      });
    } else if (index == 2) {
      Navigator.of(context).pushNamed(AddPostScreen.routeName);
      // showModalBottomSheet(
      //     context: context,
      //     builder: (ctx) => Container(
      //           height: MediaQuery.of(context).size.height * 0.3,
      //           decoration: BoxDecoration(
      //             color: Colors.black87,
      //             borderRadius: BorderRadius.only(
      //               topLeft: Radius.circular(45),
      //               topRight: Radius.circular(45),
      //             ),
      //           ),
      //           child: Column(
      //             children: [
      //               Padding(
      //                 padding: const EdgeInsets.all(15.0),
      //                 child: ListTile(
      //                   leading: Icon(
      //                     Icons.post_add,
      //                     color: Colors.white,
      //                   ),
      //                   title: Text(
      //                     'Post',
      //                     style: TextStyle(color: Colors.white),
      //                   ),
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.all(15.0),
      //                 child: ListTile(
      //                   leading: Icon(
      //                     Icons.add_circle_rounded,
      //                     color: Colors.white,
      //                   ),
      //                   title: Text(
      //                     'Story',
      //                     style: TextStyle(color: Colors.white),
      //                   ),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ),
      //     backgroundColor: Colors.black12);
    } else {
      setState(() {
        chosenIndex = index;
      });
    }
  }

  // Future<String> fetchProfileImage() async {
  //   var userId = FirebaseAuth.instance.currentUser!.uid;
  //   final url = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(userId)
  //       .collection('user-profile-image')
  //       .get();
  //   final link = url.docs[0].data()['imageUrl'];

  //   return link;
  // }

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Content>(context);
    // final url = providerData.fetchUserImageProfileUrl();
    // return FutureBuilder(
    //   builder: (ctx, snapshot) => snapshot.hasData
    //       ?
    return Scaffold(
      body: screens[chosenIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.black,
        ),
        child: BottomNavigationBar(
            //   currentIndex: 3,
            backgroundColor: Colors.black,
            items: [
              BottomNavigationBarItem(
                icon: Center(
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Center(
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Center(
                  child: Icon(
                    Icons.add_box_outlined,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Center(
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Center(
                  child: CircleAvatar(
                    backgroundImage: providerData.hasProfileImage
                        ? NetworkImage(providerData.imageUrl)
                        : NetworkImage(
                            'http://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png'),
                    radius: 15,
                  ),
                ),
                label: "",
              ),
            ],
            onTap: overrideScreen),
      ),
    );
    //       : Center(
    //           child: CircularProgressIndicator(),
    //         ),
    //   future: fetchProfileImage(),
    // );
  }
}
