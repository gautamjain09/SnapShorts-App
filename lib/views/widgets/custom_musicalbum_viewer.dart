import "package:flutter/material.dart";

class CustomMusicAlbumViewer extends StatelessWidget {
  final String profilePhoto;
  const CustomMusicAlbumViewer({
    required this.profilePhoto,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 55,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Colors.purple,
                  Colors.white70,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
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
