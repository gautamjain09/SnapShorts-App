import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:snapshorts_app/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  Rx<String> _uid = "".obs;

  updateUserId(String uid) async {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    QuerySnapshot myVideos = await firestore
        .collection("videos")
        .where("uid", isEqualTo: _uid.value)
        .get();

    List<String> thumbnailUrls = [];
    int len = myVideos.docs.length;
    for (int i = 0; i < len; i++) {
      thumbnailUrls.add((myVideos.docs[i].data()! as dynamic)['thumbnailUrl']);
    }

    DocumentSnapshot userDoc =
        await firestore.collection("users").doc(_uid.value).get();
    final userData = userDoc.data()! as dynamic;
    String username = userData['username'];
    String profilePhoto = userData['profilePhoto'];

    int likes = 0;
    for (int i = 0; i < len; i++) {
      likes += (myVideos.docs[i]['likes']! as List).length;
    }

    _user.value = {
      'username': username,
      'profilePhoto': profilePhoto,
      'likes': likes.toString(),
      'thumbnailUrls': thumbnailUrls,
    };
  }
}
