import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:provider/provider.dart';

class DirectScreenAppBarr extends StatelessWidget
    implements PreferredSizeWidget {
  final id;
  DirectScreenAppBarr(this.id);

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Content>(context, listen: false);
    return FutureBuilder(
      future: providerData.fetchSearchedUserUserName(id),
      builder: (ctx, snapshot) => snapshot.hasData
          ? AppBar(
              backgroundColor: Colors.black,
              // leading: Icon(Icons.lock_outline),
              title: Text(
                snapshot.data as String,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize {
    return new Size.fromHeight(50.0);
    throw UnimplementedError();
  }
}
