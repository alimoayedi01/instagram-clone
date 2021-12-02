import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:instagram_clone/screens/serachedUserProfileScreen.dart';
//import 'package:instagram_clone/widgets/searchBar.dart';
import 'package:provider/provider.dart';

class ExploreScreen extends StatefulWidget {
  ExploreScreen({
    Key? key,
  }) : super(key: key);
  static const routeName = 'ExploreScreen';

  @override
  _ExploreScreenState createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  TextEditingController serachController = new TextEditingController();

  bool isAvailable = false;

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Content>(context);
    final allUsers = providerData.allUsersUserNames;
    return FutureBuilder(
      builder: (ctx, snapshot) => snapshot.hasData
          ? Scaffold(
              backgroundColor: Colors.black,
              extendBodyBehindAppBar: true,
              body: Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                color: Colors.black,
                child: Column(
                  children: [
                    Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).padding.top + 3,
                            horizontal: 10),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                            controller: serachController,
                            onSubmitted: (_) {
                              if (allUsers.contains(serachController.text)) {
                                setState(() {
                                  isAvailable = true;
                                });
                              } else {
                                setState(() {
                                  isAvailable = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              hintStyle: TextStyle(color: Colors.white70),
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 15),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              // suffixIcon: IconButton(
                              //   color: Colors.white,
                              //   icon: Icon(Icons.clear),
                              //   onPressed: () {},
                              // ),
                              hintText: 'Search',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                      width: 1, color: Colors.black)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (isAvailable)
                      GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                            SearchedUserProfileScreen.routeName,
                            arguments: serachController.text),
                        child: ListTile(
                          leading: CircleAvatar(),
                          title: Text(
                            serachController.text,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.black,
              body: Center(child: CircularProgressIndicator())),
      future: providerData.allUsers(),
    );
  }
}
