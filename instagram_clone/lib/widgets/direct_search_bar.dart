import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:provider/provider.dart';

class DirectSearchBar extends StatelessWidget {
  DirectSearchBar({Key? key}) : super(key: key);

  final TextEditingController serachController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Content>(context);
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).padding.top + 3, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[700], borderRadius: BorderRadius.circular(30)),
        child: TextField(
          style: TextStyle(color: Colors.white),
          controller: serachController,
          onSubmitted: (_) {},
          decoration: InputDecoration(
            hintStyle: TextStyle(color: Colors.white70),
            contentPadding: EdgeInsets.symmetric(vertical: 15),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: 'Search',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide(width: 1, color: Colors.black)),
          ),
        ),
      ),
    );
  }
}
