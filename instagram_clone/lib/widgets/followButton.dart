import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:provider/provider.dart';

class FollowButton extends StatefulWidget {
  final id;
  FollowButton(this.id);

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  bool followed = false;

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Content>(context);

    return FutureBuilder(
      future: providerData.fetchUserFollowings(),
      builder: (ctx, snapshot) => snapshot.hasData
          ? Row(
              children: [
                Expanded(
                  child: !providerData.userFollowersId.contains(widget.id)
                      ? !followed
                          ? RaisedButton(
                              onPressed: () {
                                providerData
                                    .addFollowing(widget.id)
                                    .then((value) {
                                  setState(() {
                                    followed = !followed;
                                  });
                                });
                              },
                              child: Text(
                                'Follow',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.blue,
                            )
                          : RaisedButton(
                              onPressed: () {
                                providerData
                                    .addFollowing(widget.id)
                                    .then((value) {
                                  setState(() {
                                    followed = !followed;
                                  });
                                });
                              },
                              child: Text(
                                'Followed',
                                style: TextStyle(color: Colors.white),
                              ),
                              color: Colors.black,
                            )
                      : RaisedButton(
                          onPressed: () {
                            providerData.addFollowing(widget.id).then((value) {
                              setState(() {
                                followed = !followed;
                              });
                            });
                          },
                          child: Text(
                            'Followed',
                            style: TextStyle(color: Colors.white),
                          ),
                          color: Colors.black,
                        ),
                ),
                Expanded(
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      'Message',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.black,
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
