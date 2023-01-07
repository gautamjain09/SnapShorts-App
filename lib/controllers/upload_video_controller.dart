import 'package:get/get.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:snapshorts_app/constants.dart';
import 'package:snapshorts_app/models/video_model.dart';
import 'package:snapshorts_app/views/screens/add_video_screen.dart';
import 'package:video_compress/video_compress.dart';

class UploadVideoController extends GetxController {
  String uid = firebaseAuth.currentUser!.uid;

  // ------------------------ Compress Video ------------------------------>
  _compressVideo(String videoPath) async {
    MediaInfo? compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
      deleteOrigin: false,
    );
    return compressedVideo!.file;
  }

  // ------------------------ uploadVideo to Storage ----------------------->
  _uploadVideoToStorage(String videoId, String videoPath) async {
    Reference storageReference =
        firebaseStorage.ref().child("videos").child(videoId);

    UploadTask uploadtask = storageReference.putFile(
      await _compressVideo(videoPath),
    );
    TaskSnapshot taskSnapshot = await uploadtask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // -------------------------- generate Thumbnail -------------------------->
  _getThumbnail(String videoPath) async {
    final thumbnailFile = await VideoCompress.getFileThumbnail(
      videoPath,
      quality: 70, // default(100)
      position: -1, // default(-1)
    );
    return thumbnailFile;
  }

  // ------------------------ uploadThumbnail to Storage ---------------------->
  _uploadThumbnailToStorage(String videoId, String videoPath) async {
    Reference storageReference =
        firebaseStorage.ref().child("Thumbnail").child(videoId);

    UploadTask uploadtask = storageReference.putFile(
      await _getThumbnail(videoPath),
    );
    TaskSnapshot taskSnapshot = await uploadtask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // ------------------------ uploadVideo to Firestore ------------------------------->
  uploadVideo(String songName, String caption, String videoPath) async {
    try {
      // Creating Unique ID for each Video
      QuerySnapshot allVideos = await firestore.collection("videos").get();
      int len = allVideos.docs.length;

      String videoUrl = await _uploadVideoToStorage(
        "Video $len",
        videoPath,
      );
      String thumbnailUrl = await _uploadThumbnailToStorage(
        "Video $len",
        videoPath,
      );

      DocumentSnapshot userDocs =
          await firestore.collection("users").doc(uid).get();

      Video video = Video(
        username: (userDocs.data()! as Map<String, dynamic>)["username"],
        uid: uid,
        videoId: "Video $len",
        likes: [],
        commentCount: 0,
        shareCount: 0,
        songName: songName,
        caption: caption,
        videoUrl: videoUrl,
        thumbnailUrl: thumbnailUrl,
        profilePhoto:
            (userDocs.data()! as Map<String, dynamic>)["profilePhoto"],
      );

      await firestore
          .collection("videos")
          .doc("Video $len")
          .set(video.toJson());

      Get.snackbar(
        "Uploaded",
        "Video Uploaded Successfully",
      );

      Get.to(
        // Navigator to Video Screen
        const AddVideoScreen(),
      );
    } on FirebaseException catch (e) {
      Get.snackbar(
        "Error Uploading Video",
        e.message!,
      );
    }
  }
}
