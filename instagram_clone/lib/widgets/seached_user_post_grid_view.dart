import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:instagram_clone/screens/searched_user_post_screen.dart';
import 'package:provider/provider.dart';

class SearchedUserPostGridView extends StatelessWidget {
  final id;
  SearchedUserPostGridView(this.id);

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Content>(context, listen: false);
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: providerData.postedImages.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20),
          itemBuilder: (ctx, index) => Container(
            height: 500,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pushNamed(
                  SearchedUserPostScreen.routeName,
                  arguments: [providerData.postedImages[index], id]),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  height: 300,
                  width: 200,
                  child: Image.network(
                    providerData.postedImages[index].imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
