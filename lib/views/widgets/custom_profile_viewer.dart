import "package:flutter/material.dart";

class CustomProfileViewer extends StatelessWidget {
  final String profilePhoto;
  CustomProfileViewer({
    required this.profilePhoto,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 55,
      height: 55,
      child: Stack(
        children: [
          Positioned(
            left: 3,
            child: Container(
              width: 50,
              height: 50,
              padding: const EdgeInsets.all(1.5),
              decoration: BoxDecoration(
                color: Colors.white70,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image(
                  image: NetworkImage(profilePhoto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
