import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({Key? key}) : super(key: key);
  static const routeName = 'createPostScreen';
  var chosenImage;
  TextEditingController caption = TextEditingController();
  void choseInput(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(
              height: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {
                            chosenImage =
                                // Provider.of<Content>(context, listen: false)
                                //     .addPost(
                                //         context,
                                //         FirebaseAuth.instance.currentUser!.uid,
                                //         ImageSource.gallery);
                                Provider.of<Content>(context, listen: false)
                                    .pickPostImage(ImageSource.gallery);
                            chosenImage =
                                Provider.of<Content>(context, listen: false)
                                    .pickedPostImage();
                          },
                          icon: Icon(Icons.add_box_outlined),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Gallery',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListTile(
                        leading: IconButton(
                          onPressed: () {
                            chosenImage =
                                //     Provider.of<Content>(context, listen: false)
                                //         .addPost(
                                //   context,
                                //   FirebaseAuth.instance.currentUser!.uid,
                                //   ImageSource.camera,
                                // );
                                Provider.of<Content>(context, listen: false)
                                    .pickPostImage(ImageSource.camera);
                            chosenImage =
                                Provider.of<Content>(context, listen: false)
                                    .pickedPostImage();
                          },
                          icon: Icon(Icons.add_circle_rounded),
                          color: Colors.white,
                        ),
                        title: Text(
                          'Camera',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        backgroundColor: Colors.black12);
  }

  @override
  Widget build(BuildContext context) {
    chosenImage = Provider.of<Content>(context, listen: true).pickedPostImage();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Create Content',
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () => choseInput(context), icon: Icon(Icons.image)),
          IconButton(
              onPressed: () {
                Provider.of<Content>(context, listen: false).addPost(
                  context,
                  FirebaseAuth.instance.currentUser!.uid,
                  caption.text,
                );
              },
              icon: Icon(
                Icons.done,
                color: Colors.blue,
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(20),
                    height: 50,
                    width: 50,
                    child: chosenImage == null
                        ? CircularProgressIndicator()
                        : Image.file(
                            chosenImage,
                            fit: BoxFit.cover,
                          ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                      child: TextField(
                    controller: caption,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        labelText: 'Caption...',
                        labelStyle: TextStyle(color: Colors.white),
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        // hintText: 'Caption',
                        fillColor: Colors.white),
                  ))
                ],
              ),
              Divider(
                thickness: .4,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                child: Text(
                  'Tag People',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Divider(
                thickness: .4,
                color: Colors.grey,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
                child: Text(
                  'Add Location',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
              Divider(
                thickness: .4,
                color: Colors.grey,
              ),
              // Center(
              //   child: RaisedButton(
              //       onPressed: Navigator.of(context).pop,
              //       color: Colors.white60,
              //       child: Text(
              //         'Post',
              //         style: TextStyle(
              //             color: Colors.black,
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20),
              //       )),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
