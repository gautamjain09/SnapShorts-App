import "package:flutter/material.dart";
import 'package:snapshorts_app/constants.dart';

class CommentScreen extends StatefulWidget {
  const CommentScreen({Key? key}) : super(key: key);

  @override
  State<CommentScreen> createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  @override
  Widget build(BuildContext context) {
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
                Text(
                  "Comment  Section",
                  style: const TextStyle(
                    fontSize: 26,
                    color: textColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Divider(color: buttonColor),
                Expanded(
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.black,
                          // backgroundImage: NetworkImage(comment.profilePhoto),
                        ),
                        title: Row(
                          children: [
                            Text(
                              "Username  ",
                              style: const TextStyle(
                                fontSize: 18,
                                color: buttonColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                "Comment Description",
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
                              "Date",
                              style: const TextStyle(
                                fontSize: 14,
                                color: textColor,
                              ),
                            ),
                            const SizedBox(
                              width: 9,
                            ),
                            Text(
                              "9 Likes",
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
                  ),
                ),
                const Divider(color: buttonColor),
                ListTile(
                  title: TextFormField(
                    // controller: _commentController,
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
                      // commentController.postComment(_commentController.text),
                    },
                    child: Icon(
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
