import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:snapshorts_app/constants.dart';
import 'package:snapshorts_app/models/user_model.dart';

class SearchController extends GetxController {
  final Rx<List<User>> _searchedUsers = Rx<List<User>>([]);
  List<User> get searchedUsers => _searchedUsers.value;

  searchUser(String text) async {
    _searchedUsers.bindStream(
      firestore
          .collection("users")
          .where('username', isGreaterThanOrEqualTo: text)
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<User> allUsers = [];
          for (DocumentSnapshot child in query.docs) {
            allUsers.add(User.fromSnap(child));
          }
          return allUsers;
        },
      ),
    );
  }
}
