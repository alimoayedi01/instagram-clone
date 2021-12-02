import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:instagram_clone/screens/addPostScreen.dart';
import 'package:provider/provider.dart';

class MyAppbar extends StatelessWidget implements PreferredSizeWidget {
  final id;
  MyAppbar(this.id);

  void createContent(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(
              height: MediaQuery.of(context).size.height * 0.4,
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
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(AddPostScreen.routeName);
                            // Provider.of<Content>(context, listen: false)
                            //     .addPost(context,
                            //         FirebaseAuth.instance.currentUser!.uid);
                          },
                          icon: Icon(Icons.add_box_outlined),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Post',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {
                            Provider.of<Content>(context, listen: false)
                                .fetchPosts();
                          },
                          icon: Icon(Icons.add_circle_rounded),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Story',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.circle_notifications_outlined),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Story Highlight',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.tv),
                          color: Colors.white,
                        ),
                        title: Text(
                          'IGTV Video',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.menu_book),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Guide',
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

  void drawer(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => Container(
              height: MediaQuery.of(context).size.height * 0.5,
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
                          onPressed: () {},
                          icon: Icon(Icons.settings),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Settings',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.archive_outlined),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Archive',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.lock_clock_outlined),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Your Activity',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.qr_code_scanner_rounded),
                          color: Colors.white,
                        ),
                        title: Text(
                          'QR Code',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.bookmark_border),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Saved',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.menu_open_rounded),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Close Friends',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.healing_outlined),
                          color: Colors.white,
                        ),
                        title: Text(
                          'COVID-19 Information Center',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () async {
                            await FirebaseAuth.instance.signOut();
                            Navigator.of(context).pop();
                            // setState(() {});
                            // Navigator.of(context)
                            //     .pushNamed(AuthScreen.routeName);
                          },
                          icon: Icon(Icons.logout),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Logout',
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
    final providerData = Provider.of<Content>(context, listen: false);

    return FutureBuilder(
      builder: (ctx, snapshot) => snapshot.hasData
          ? AppBar(
              backgroundColor: Colors.black,
              leading: Icon(Icons.lock_outline),
              title: Text(
                snapshot.data as String,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
              ),
              actions: [
                IconButton(
                  onPressed: () => createContent(context),
                  icon: Icon(Icons.add_box_outlined),
                ),
                IconButton(
                    onPressed: () => drawer(context),
                    icon: Icon(Icons.menu_rounded))
              ],
            )
          : Text(''),
      future: providerData.fetchSearchedUserUserName(id),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return new Size.fromHeight(50.0);
    throw UnimplementedError();
  }
}
