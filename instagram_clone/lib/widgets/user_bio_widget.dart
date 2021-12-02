import 'package:flutter/material.dart';
import 'package:instagram_clone/providers/contents.dart';
import 'package:provider/provider.dart';

class BioWidget extends StatelessWidget {
  const BioWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Content>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: Colors.black,
          height: 100,
          width: 200,
          child: SingleChildScrollView(
            child: Card(
              color: Colors.black,
              child: FutureBuilder(
                future: providerData.fetchBio(),
                builder: (ctx, snapshot) => snapshot.hasData
                    ? Text(
                        snapshot.data as String,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      )
                    : Text(''),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
