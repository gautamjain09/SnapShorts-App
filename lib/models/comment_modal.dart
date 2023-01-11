import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String commentText;
  final datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String commentId;

  Comment({
    required this.username,
    required this.commentText,
    required this.datePublished,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
    required this.commentId,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'commentText': commentText,
        'datePublished': datePublished,
        'likes': likes,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'commentId': commentId,
      };

  static Comment fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Comment(
      username: snapshot['username'],
      commentText: snapshot['commentText'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
      profilePhoto: snapshot['profilePhoto'],
      uid: snapshot['uid'],
      commentId: snapshot['commentId'],
    );
  }
}
