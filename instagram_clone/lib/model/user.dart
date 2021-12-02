import 'package:instagram_clone/model/post.dart';

class Users {
  final String username;
  // final int numberOfPosts;
  final List<Post> userPosts;
  final String id;

  Users(
      {required this.username,
      //  required this.numberOfPosts,
      required this.userPosts,
      required this.id});
}
