import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:instagram_clone/screens/home_screen.dart';
import 'package:instagram_clone/widgets/bottom_navigation_bar.dart';
import 'package:provider/provider.dart';

class ChooseProfileImage extends StatefulWidget {
  const ChooseProfileImage({Key? key}) : super(key: key);
  static const routeName = 'choseImage';

  @override
  _ChooseProfileImageState createState() => _ChooseProfileImageState();
}

class _ChooseProfileImageState extends State<ChooseProfileImage> {
  var downlink;

  var chosenImage;
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
                          onPressed: () async {
                            chosenImage = await ImagePicker.pickImage(
                                source: ImageSource.gallery, imageQuality: 10);
                            // Future.delayed(Duration(seconds: 3));
                            var url = FirebaseStorage.instance
                                .ref()
                                .child('user-profile-pic')
                                .child(
                                  FirebaseAuth.instance.currentUser!.uid,
                                )
                                .child(chosenImage.path + 'jpg');
                            // Future.delayed(Duration(seconds: 3));
                            await url.putFile(chosenImage);
                            downlink = await url.getDownloadURL();
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('user-profile-image')
                                .add({
                              'imageUrl': downlink,
                            });

                            setState(() {});
                            // Provider.of<Content>(context, listen: false)
                            //     .addPost(
                            //         context,
                            //         FirebaseAuth.instance.currentUser!.uid,
                            //         ImageSource.gallery);
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
                          onPressed: () async {
                            chosenImage = await ImagePicker.pickImage(
                                source: ImageSource.camera, imageQuality: 10);

                            final url = FirebaseStorage.instance
                                .ref()
                                .child('user-profile-pic')
                                .child(
                                  FirebaseAuth.instance.currentUser!.uid,
                                )
                                .child(chosenImage.path + 'jpg');

                            await url.putFile(chosenImage);

                            downlink = await url.getDownloadURL();
                            print('go');
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.uid)
                                .collection('user-profile-image')
                                .add({
                              'imageUrl': downlink,
                            });
                            print('done');
                            setState(() {});

                            //     Provider.of<Content>(context, listen: false)
                            //         .addPost(
                            //   context,
                            //   FirebaseAuth.instance.currentUser!.uid,
                            //   ImageSource.camera,
                            // );
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

  TextEditingController bioController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Content>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(bioController.text);
          providerData.setBio(bioController.text);
          Navigator.of(context)
              .popAndPushNamed(MyBottomNavigationBar.routeName);
        },
        child: Icon(
          Icons.done,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Card(
          margin: EdgeInsets.all(15),
          color: Colors.black54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                // borderRadius: BorderRadius.circular(50)),
                child: downlink == null
                    ? CircleAvatar(
                        radius: 45,
                      )
                    : Image.network(
                        downlink,
                        fit: BoxFit.cover,
                      ),
              ),
              SizedBox(
                height: 5,
              ),
              // ignore: deprecated_member_use
              FlatButton(
                onPressed: () {
                  choseInput(context);
                },
                child: Text(
                  'Choose your profile picture',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              downlink != null
                  ? FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(MyBottomNavigationBar.routeName);
                      },
                      child: Text(
                        'Continue',
                        style: TextStyle(color: Colors.white),
                      ))
                  : CircularProgressIndicator(),
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.grey[700],
                child: TextField(
                  controller: bioController,
                  //  decoration: InputDecoration(),
                  // onSubmitted: (value) =>
                  //     providerData.setBio(value),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
