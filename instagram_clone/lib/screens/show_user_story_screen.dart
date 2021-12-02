import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:provider/provider.dart';

class ShowUserStoryScreen extends StatelessWidget {
  final imageUrl;
  ShowUserStoryScreen(this.imageUrl);

  // static const routeName = 'storyScreen';
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Content>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton(
            color: Colors.black,
            icon: Icon(Icons.more_vert_rounded),
            itemBuilder: (ctx) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  'delete',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            onSelected: (value) async => {
              if (value == 0)
                {await providerData.deleteStory(), Navigator.of(context).pop()},
            },
          )
        ],
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
