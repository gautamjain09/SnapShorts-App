import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:snapshorts_app/constants.dart';
import 'package:snapshorts_app/models/video_model.dart';

class FetchVideosController extends GetxController {
  var uid = authController.user.uid;

  final Rx<List<Video>> _videosList = Rx<List<Video>>([]);
  List<Video> get videosList => _videosList.value;

  @override
  void onInit() {
    super.onInit();
    _videosList.bindStream(
      firestore.collection("videos").snapshots().map(
        (QuerySnapshot query) {
          List<Video> allVideos = [];
          for (DocumentSnapshot child in query.docs) {
            allVideos.add(Video.fromSnap(child));
          }
          return allVideos;
        },
      ),
    );
  }

  likeVideo(String videoiId) async {
    DocumentSnapshot isLiked =
        await firestore.collection("videos").doc(videoiId).get();

    // if Liked already remove uid from likes array, else add uid to 'Likes' array
    if ((isLiked.data()! as dynamic)['likes'].contains(uid)) {
      await firestore.collection('videos').doc(videoiId).update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firestore.collection('videos').doc(videoiId).update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
