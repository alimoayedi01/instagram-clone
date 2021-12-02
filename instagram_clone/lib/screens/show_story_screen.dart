import 'package:flutter/material.dart';

class ShowStoryScreen extends StatelessWidget {
  final imageUrl;
  ShowStoryScreen(this.imageUrl);
  // static const routeName = 'storyScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Image.network(imageUrl,
              loadingBuilder: (context, child, loadingProgress) =>
                  //CircularProgressIndicator(),
                  loadingProgress == null
                      ? child
                      : CircularProgressIndicator()),
        ),
      ),
    );
  }
}
