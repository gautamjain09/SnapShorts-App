import 'dart:io';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapshorts_app/constants.dart';
import 'package:snapshorts_app/views/screens/confirm_screen.dart';

class UploadVideoScreen extends StatefulWidget {
  const UploadVideoScreen({Key? key}) : super(key: key);

  @override
  State<UploadVideoScreen> createState() => _UploadVideoScreenState();
}

class _UploadVideoScreenState extends State<UploadVideoScreen> {
  videoPicker(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      Get.offAll(
        () => ConfirmScreen(
          videoFile: File(video.path),
          videoPath: video.path,
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
      appBar: AppBar(
        title: const Text(
          "Add Video",
          style: TextStyle(
            fontSize: 18,
            color: textColor,
          ),
        ),
        centerTitle: true,
        backgroundColor: buttonColor,
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            showOptionDialog(context);
          },
          child: Container(
            height: 40,
            width: 150,
            decoration: const BoxDecoration(
              color: buttonColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Icon(
                  Icons.file_upload_outlined,
                  color: textColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
