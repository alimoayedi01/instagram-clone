import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:provider/provider.dart';

class UserFollowerInfo extends StatelessWidget {
  final numOfFollowings;
  final numOfFollowers;
  UserFollowerInfo(
    this.numOfFollowings,
    this.numOfFollowers,
  );

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Content>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          radius: 35,
          backgroundImage: NetworkImage(
            'http://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png',
          ),
        ),
        Container(
          height: 50,
          child: Column(
            children: [
              Text(
                providerData.postedImages.length.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Posts',
                style: TextStyle(
                    color: Colors.white,
                    //  fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            ],
          ),
        ),
        Container(
          height: 50,
          child: Column(
            children: [
              Text(
                numOfFollowers,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Followers',
                style: TextStyle(
                    color: Colors.white,
                    // fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            ],
          ),
        ),
        Container(
          height: 50,
          child: Column(
            children: [
              Text(
                numOfFollowings,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Following',
                style: TextStyle(
                    color: Colors.white,
                    //   fontWeight: FontWeight.bold,
                    fontSize: 16),
              )
            ],
          ),
        ),
      ],
    );
  }
}
