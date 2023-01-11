import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:snapshorts_app/constants.dart';
import 'package:snapshorts_app/models/comment_modal.dart';

class CommentController extends GetxController {
  //private member
  final Rx<List<Comment>> _commentsList = Rx<List<Comment>>([]);

  // getter
  List<Comment> get commentsList => _commentsList.value;

  // videoId in which comment is added
  String _videoId = "";
  updateVideoId(String videoId) {
    _videoId = videoId;
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userData = await firestore
            .collection("users")
            .doc(authController.user.uid)
            .get();

        QuerySnapshot allVideos = await firestore
            .collection("videos")
            .doc(_videoId)
            .collection("comments")
            .get();

        int len = allVideos.docs.length;

        Comment comment = Comment(
          username: (userData.data() as dynamic)['username'],
          commentText: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: (userData.data() as dynamic)['profilePhoto'],
          uid: (userData.data() as dynamic)['uid'],
          commentId: "Comment $len",
        );

        // Uploading comment to firestore
        await firestore
            .collection("videos")
            .doc(_videoId)
            .collection("comments")
            .doc("Comment $len")
            .set(comment.toJson());

        // Updating commentCount in firestore videoId
        DocumentSnapshot videoSnap =
            await firestore.collection("videos").doc(_videoId).get();

        await firestore.collection("videos").doc(_videoId).update({
          'commentCount': (videoSnap.data() as dynamic)['commentCount'] + 1,
        });
      }
    } on FirebaseException catch (e) {
      Get.snackbar(
        "Error While Commenting",
        e.toString(),
      );
    }
  }

  getComments() async {
    _commentsList.bindStream(
      firestore
          .collection("videos")
          .doc(_videoId)
          .collection("comments")
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<Comment> allComments = [];
          for (DocumentSnapshot child in query.docs) {
            allComments.add(Comment.fromSnap(child));
          }
          return allComments;
        },
      ),
    );
  }
}
