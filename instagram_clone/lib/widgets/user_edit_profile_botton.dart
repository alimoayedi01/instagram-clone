import 'package:flutter/material.dart';
import 'package:instagram_clone/widgets/choose_profile_image.dart';

class EditProfileBotton extends StatelessWidget {
  const EditProfileBotton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(7)),
            child: RaisedButton(
              color: Colors.black,
              onPressed: () {
                Navigator.of(context).pushNamed(ChooseProfileImage.routeName);
              },
              child: Text(
                'Edit Profile',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(7)),
          child: RaisedButton(
            color: Colors.black,
            onPressed: () {},
            child: Icon(
              Icons.expand_more_sharp,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
