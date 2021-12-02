import 'dart:io';

import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:image_picker/image_picker.dart';

import 'package:instagram_clone/model/post.dart';
import 'package:instagram_clone/model/user.dart';

class Content with ChangeNotifier {
  List<Post> postedImages = [];
  List<String> result = [];
  List<String> allUsersUserNames = [];
  List<Users> allUserObjects = [];
  List<Post> aUsersPost = [];
  List<String> userFollowingId = [];
  List<Users> usersFollowers = [];
  List<String> userFollowersId = [];
  List<Map<String, String>> userFollowingsStoriesImageUrl = [];

  static List<Users> usersFollowings = [];
  static List<Post> userFollowingsPosts = [];
  static int numberOfPostsToShow = 0;

  var profileImage;
  var profileImage1;
  var image;
  var storyImage;
  var image1;
  var ids;
  var imageUrl;

  static String userBio = '';
  bool hasProfileImage = false;

// post...

  Future<void> pickPostImage(ImageSource source) async {
    image = await ImagePicker.pickImage(source: source, imageQuality: 10);
    notifyListeners();
  }

  File pickedPostImage() {
    image1 = image;
    return image1;
  }

  Future<void> addPost(BuildContext context, var userId, String caption) async {
    // image = await ImagePicker.pickImage(source: source, imageQuality: 10);

    final url = FirebaseStorage.instance
        .ref()
        .child('user-posts')
        .child(userId)
        .child(image.path + 'jpg');

    await url.putFile(image);
    var downlink = await url.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user-posts')
        .add({
      'imageUrl': downlink,
      "name": image.path,
      'caption': caption,
      'numOfLikes': 0,
      'likedBy': []
    });

    Navigator.of(context).pop();

    notifyListeners();
  }

  Future<int> fetchPosts() async {
    postedImages = [];
    FirebaseAuth.instance.authStateChanges();

    var userId = FirebaseAuth.instance.currentUser!.uid;

    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('user-posts')
        .get();
    final url1 = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user-posts')
        .get();
    final List<DocumentSnapshot> documents = url1.docs;
    for (int i = 0; i < url.docs.length; i++) {
      postedImages.add(
        Post(
            imageUrl: url.docs[i].data()['imageUrl'],
            caption: url.docs[i].data()['caption'],
            name: documents[i].id),
      );
    }

    ids = postedImages.map((e) => e.imageUrl).toSet();
    postedImages.retainWhere((x) => ids.remove(x.imageUrl));

    notifyListeners();

    return postedImages.length;
  }

// story...

  Future<void> pickStoryImage(ImageSource source, BuildContext context) async {
    storyImage = await ImagePicker.pickImage(source: source, imageQuality: 10);
    await addStory(context, FirebaseAuth.instance.currentUser!.uid);
    notifyListeners();
  }

  Future<void> addStory(BuildContext context, var userId) async {
    final url = FirebaseStorage.instance
        .ref()
        .child('user-stories')
        .child(userId)
        .child(storyImage.path + 'jpg');

    await url.putFile(storyImage);
    var downlink = await url.getDownloadURL();

    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user-stories')
        .add({
      'imageUrl': downlink,
      "name": storyImage.path,
    });
  }

  Future<String> fetchUserStoryUrl() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;

    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('user-stories')
        .get();
    return url.docs[0].data()['imageUrl'];
  }

  Future<List<Map<String, String>>> showUsersFollowingStories() async {
    userFollowingsStoriesImageUrl = [];
    for (int i = 0; i < usersFollowings.length; i++) {
      final url = await FirebaseFirestore.instance
          .collection('users')
          .doc(usersFollowings[i].id)
          .collection('user-stories')
          .get();

      final url1 = await FirebaseFirestore.instance
          .collection('users')
          .doc(usersFollowings[i].id)
          .get();
      final userName = url1.data()!['username'];

      if (url.docs.length != 0) {
        userFollowingsStoriesImageUrl.add(
            {'imageUrl': url.docs[0].data()['imageUrl'], 'userName': userName});
      }
    }

    return userFollowingsStoriesImageUrl;
  }

  Future<void> deleteStory() async {
    final url = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user-stories');
    var snapshot = await url.get();
    for (var doc in snapshot.docs) {
      await doc.reference.delete();
    }
    notifyListeners();
  }
// profile pic...

  Future<void> pickProfileImage(ImageSource source) async {
    profileImage =
        await ImagePicker.pickImage(source: source, imageQuality: 10);

    await fetchUserImageProfileUrl();
    hasProfileImage = true;
    notifyListeners();
  }

  File pickedProfileImage() {
    profileImage1 = profileImage;
    return profileImage1;
  }

  Future<String> fetchUserImageProfileUrl() async {
    FirebaseAuth.instance.authStateChanges();
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('user-profile-image')
        .get();
    imageUrl = url.docs[0].data()['imageUrl'];
    return imageUrl;
  }

  Future<void> setBio(String bio) async {
    userBio = bio;
    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'userBio': userBio});
  }

  Future<String> fetchBio() async {
    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    final myBio = url.data()!['userBio'];
    return myBio;
  }

// all user data...

  Future<int> allUsers() async {
    //allUsersUserNames = [];
    final url = await FirebaseFirestore.instance.collection('users').get();
    for (int i = 0; i < url.docs.length; i++) {
      allUsersUserNames.add(url.docs[i].data()['username']);
    }

    return allUsersUserNames.length;
  }

  Future<int> fetchAllUserObjects() async {
    print(1);
    final url = await FirebaseFirestore.instance.collection('users').get();
    print(2);
    allUserObjects = [];

    final List<DocumentSnapshot> documents = url.docs;

    aUsersPost = [];

    for (int j = 0; j < documents.length; j++) {
      aUsersPost = [];
      final url1 = await FirebaseFirestore.instance
          .collection('users')
          .doc(documents[j].id)
          .collection('user-posts')
          .get();

      final List<DocumentSnapshot> documents1 = url1.docs;
      for (int i = 0; i < url1.docs.length; i++) {
        aUsersPost.add(Post(
            imageUrl: url1.docs[i].data()['imageUrl'],
            caption: url1.docs[i].data()['caption'],
            postsOwnerid: documents[j].id,
            name: documents1[i].id));
      }
      allUserObjects.add(Users(
          username: url.docs[j].data()['username'],
          id: documents[j].id,
          userPosts: aUsersPost));
    }

    return allUserObjects.length;
  }

  Future<String> fetchUserName() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    final url =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    final userName = url.data()!['username'];

    return userName;
  }

// folower && following

  Future<void> addFollowing(String id) async {
    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('user-followings')
        .add({"id": id});

    userFollowingId.add(id);
    for (int i = 0; i < allUserObjects.length; i++) {
      if (id == allUserObjects[i].id) {
        usersFollowings.add(allUserObjects[i]);
      }
    }
    final url1 = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('user-followers')
        .add({"id": FirebaseAuth.instance.currentUser!.uid});
  }

  Future<int> fetchUserFollowings() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    numberOfPostsToShow = 0;
    usersFollowings = [];
    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('user-followings')
        .get();

    usersFollowings = [];

    if (url.size == 0) {
      return 0;
    } else {
      for (int i = 0; i < allUserObjects.length; i++) {
        for (int j = 0; j < url.size; j++) {
          if (allUserObjects[i].id == url.docs[j].data()['id']) {
            usersFollowings.add(allUserObjects[i]);
          }
        }
      }
      numberOfPostsToShow = 0;
      for (int i = 0; i < usersFollowings.length; i++) {
        numberOfPostsToShow += usersFollowings[i].userPosts.length;
      }
      userFollowingsPosts = [];
      for (int i = 0; i < usersFollowings.length; i++) {
        for (int j = 0; j < usersFollowings[i].userPosts.length; j++) {
          userFollowingsPosts.add(usersFollowings[i].userPosts[j]);
        }
      }
      userFollowersId = [];
      for (int i = 0; i < usersFollowings.length; i++) {
        userFollowersId.add(usersFollowings[i].id);
      }
      return usersFollowings.length;
    }
  }

  Future<int> fetchUserFollowers() async {
    var userId = FirebaseAuth.instance.currentUser!.uid;
    usersFollowers = [];
    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('user-followers')
        .get();

    usersFollowers = [];
    if (url.size == 0) {
      return 0;
    } else {
      for (int i = 0; i < allUserObjects.length; i++) {
        for (int j = 0; j < url.size; j++) {
          if (allUserObjects[i].id == url.docs[j].data()['id']) {
            usersFollowers.add(allUserObjects[i]);
          }
        }
      }

      return usersFollowers.length;
    }
  }

// searched user...

  Future<String> fetchSearchedUserUserName(String id) async {
    final url =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    final userName = url.data()!['username'];

    return userName;
  }

  Future<int> fetchSearchedUserPosts(String userId) async {
    postedImages = [];
    FirebaseAuth.instance.authStateChanges();

    final url = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('user-posts')
        .get();
    final List<DocumentSnapshot> documents1 = url.docs;
    for (int i = 0; i < url.docs.length; i++) {
      postedImages.add(Post(
          imageUrl: url.docs[i].data()['imageUrl'],
          caption: url.docs[i].data()['caption'],
          postsOwnerid: userId,
          name: documents1[i].id));
    }

    final url1 = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('user-followings')
        .get();

    ids = postedImages.map((e) => e.imageUrl).toSet();
    postedImages.retainWhere((x) => ids.remove(x.imageUrl));
    notifyListeners();

    return url1.size;
  }

  Future<String> fetchSearchedUserBio(String id) async {
    final url =
        await FirebaseFirestore.instance.collection('users').doc(id).get();
    final myBio = url.data()!['userBio'];
    return myBio;
  }

  //geters...

  get items {
    return postedImages;
  }
}
