import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:snapshorts_app/constants.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:snapshorts_app/controllers/comment_controller.dart';

class CommentScreen extends StatelessWidget {
  final String videoId;
  CommentScreen({
    Key? key,
    required this.videoId,
  }) : super(key: key);

  TextEditingController textController = TextEditingController();
  CommentController commentController = Get.put(CommentController());

  @override
  Widget build(BuildContext context) {
    commentController.updateVideoId(videoId);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text(
                  "Comment  Section",
                  style: TextStyle(
                    fontSize: 26,
                    color: textColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const Divider(color: buttonColor),
                Expanded(
                  child: Obx(
                    () {
                      return ListView.builder(
                        itemCount: commentController.commentsList.length,
                        itemBuilder: ((context, index) {
                          final commentData =
                              commentController.commentsList[index];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.black,
                              backgroundImage: NetworkImage(
                                commentData.profilePhoto,
                              ),
                            ),
                            title: Row(
                              children: [
                                Text(
                                  commentData.username,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: buttonColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Text(
                                    commentData.commentText,
                                    maxLines: 5,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: textColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            subtitle: Row(
                              children: [
                                Text(
                                  timeago.format(commentData.datePublished),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: textColor,
                                  ),
                                ),
                                const SizedBox(
                                  width: 9,
                                ),
                                Text(
                                  "Likes Functionality",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: textColor,
                                  ),
                                )
                              ],
                            ),
                            trailing: InkWell(
                              onTap: () {
                                // commentController.likeComment(comment.id);
                              },
                              child: Icon(
                                Icons.favorite,
                                size: 20,
                                // color: comment.likes.contains(authController.user.uid)
                                //     ? Colors.red
                                //     : Colors.white,
                              ),
                            ),
                          );
                        }),
                      );
                    },
                  ),
                ),
                const Divider(color: buttonColor),
                ListTile(
                  title: TextFormField(
                    controller: textController,
                    style: const TextStyle(
                      fontSize: 18,
                      color: textColor,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Comment Here',
                      labelStyle: TextStyle(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: buttonColor,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: buttonColor,
                        ),
                      ),
                    ),
                  ),
                  trailing: TextButton(
                    onPressed: () {
                      commentController.postComment(textController.text);
                    },
                    child: const Icon(
                      Icons.send_sharp,
                      size: 26,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
