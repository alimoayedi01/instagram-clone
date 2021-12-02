import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
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
              Text(''),
            ],
          ),
        ),
        Positioned(
          right: 2,
          top: 45,
          child: Container(
              padding: EdgeInsets.all(2.0),
              // color: Theme.of(context).accentColor,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.blue),
              constraints: BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: Icon(
                Icons.add_circle,
                color: Colors.white,
              )),
        )
      ],
    );
  }
}
