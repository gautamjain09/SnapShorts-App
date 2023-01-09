import 'package:get/get.dart';
import 'package:snapshorts_app/models/comment_modal.dart';

class CommentController extends GetxController {
  //private member
  final Rx<List<Comment>> _commentsList = Rx<List<Comment>>([]);

  // getter
  List<Comment> get commentsList => _commentsList.value;

  updateVideoData() {}

  postComment(String commentText) async {}

  getComments() async {}
}
