import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String email;
  String uid;
  String profilePhoto;

  User({
    required this.username,
    required this.email,
    required this.uid,
    required this.profilePhoto,
  });

  // set properties
  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "uid": uid,
        "profilePhoto": profilePhoto,
      };

  // get properties
  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot["username"],
      email: snapshot["email"],
      uid: snapshot["uid"],
      profilePhoto: snapshot["profilePhoto"],
    );
  }
}
