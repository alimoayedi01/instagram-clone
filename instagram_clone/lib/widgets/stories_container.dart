import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/show_story_screen.dart';

class StoriesContainer extends StatelessWidget {
  final List<Map<String, String>> followingStoriesImageUrl;
  StoriesContainer(this.followingStoriesImageUrl);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 110,
        child: ListView.builder(
          itemBuilder: (ctx, index) => Padding(
            padding: const EdgeInsets.all(6.0),
            child: GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return ShowStoryScreen(
                        followingStoriesImageUrl[index]['imageUrl']);
                  },
                ),
              ),
              child: Container(
                //  height: 90,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundImage: NetworkImage(
                          'http://assets.stickpng.com/images/585e4bf3cb11b227491c339a.png'),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      followingStoriesImageUrl[index]['userName'] as String,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          itemCount: followingStoriesImageUrl.length,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
