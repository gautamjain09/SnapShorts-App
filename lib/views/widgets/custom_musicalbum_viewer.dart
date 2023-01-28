import "package:flutter/material.dart";
import 'package:snapshorts_app/constants.dart';

class CustomMusicAlbumViewer extends StatelessWidget {
  final String profilePhoto;
  const CustomMusicAlbumViewer({
    required this.profilePhoto,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  buttonColor,
                  textColor,
                ],
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Image(
                image: NetworkImage(profilePhoto),
                fit: BoxFit.cover,
              ),
            ),
          )
        ],
      ),
    );
  }
}
