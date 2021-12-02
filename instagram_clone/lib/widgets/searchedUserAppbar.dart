import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:provider/provider.dart';

class SearchedUserAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final id;
  SearchedUserAppBar(this.id);

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
