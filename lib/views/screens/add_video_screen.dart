import 'dart:io';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapshorts_app/constants.dart';
import 'package:snapshorts_app/views/screens/confirm_screen.dart';

class AddVideoScreen extends StatefulWidget {
  const AddVideoScreen({Key? key}) : super(key: key);

  @override
  State<AddVideoScreen> createState() => _AddVideoScreenState();
}

class _AddVideoScreenState extends State<AddVideoScreen> {
  videoPicker(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ConfirmScreen(
            videoFile: File(video.path),
            videoPath: video.path,
          ),
        ),
      );
    }
  }

  showOptionDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        children: [
          SimpleDialogOption(
            onPressed: () {
              videoPicker(ImageSource.gallery, context);
            },
            child: Row(
              children: const [
                Icon(
                  Icons.image,
                  color: Colors.white70,
                  size: 24,
                ),
                SizedBox(width: 10),
                Text(
                  "Gallery",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              videoPicker(ImageSource.camera, context);
            },
            child: Row(
              children: const [
                Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white70,
                  size: 24,
                ),
                SizedBox(width: 10),
                Text(
                  "Camera",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              Get.back();
            },
            child: Row(
              children: const [
                SizedBox(width: 175),
                Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            showOptionDialog(context);
          },
          child: Container(
            height: 45,
            width: 200,
            decoration: const BoxDecoration(
              color: buttonColor,
            ),
            child: const Center(
              child: Text(
                "Add Video",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
