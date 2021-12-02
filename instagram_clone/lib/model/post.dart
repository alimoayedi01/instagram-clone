class Post {
  final imageUrl;
  final caption;
  final name;
  final postsOwnerid;
  List<String> likedBy = [];

  Post(
      {this.imageUrl,
      this.caption,
      this.name,
      this.postsOwnerid,
      this.likedBy = const ['']});
}
