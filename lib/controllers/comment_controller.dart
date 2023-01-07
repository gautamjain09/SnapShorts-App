import 'package:get/get.dart';
import 'package:snapshorts_app/models/comment_modal.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _commentList = Rx<List<Comment>>([]);
}
