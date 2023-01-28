import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:snapshorts_app/constants.dart';
import 'package:snapshorts_app/controllers/fetch_videos_controller.dart';
import 'package:snapshorts_app/views/screens/comment_screen.dart';
import 'package:snapshorts_app/views/screens/profile_screen.dart';
import 'package:snapshorts_app/views/widgets/custom_circle_animation.dart';
import 'package:snapshorts_app/views/widgets/custom_musicAlbum_viewer.dart';
import 'package:snapshorts_app/views/widgets/custom_profile_viewer.dart';
import 'package:snapshorts_app/views/widgets/custom_video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final FetchVideosController fetchVideoController = Get.put(
    FetchVideosController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          return PageView.builder(
            // reverse: true,
            itemCount: fetchVideoController.videosList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = fetchVideoController.videosList[index];
              return Stack(
                children: [
                  CustomVideoPlayer(videoUrl: data.videoUrl),
                  Column(
                    children: [
                      const SizedBox(
                        height: 120,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      data.username,
                                      style: const TextStyle(
                                        fontSize: 19,
                                        color: Colors.white70,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      data.caption,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white70,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.music_note,
                                          size: 15,
                                          color: Colors.white70,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          data.songName,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.white70,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: 80,
                              margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 3,
                                left: 10,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                        MaterialPageRoute(builder: (context) {
                                          return ProfileScreen(
                                            uid: data.uid,
                                          );
                                        }),
                                      );
                                    },
                                    child: CustomProfileViewer(
                                      profilePhoto: data.profilePhoto,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          fetchVideoController
                                              .likeVideo(data.videoId);
                                        },
                                        child: Icon(
                                          Icons.favorite,
                                          size: 34,
                                          color: data.likes.contains(
                                            authController.user.uid,
                                          )
                                              ? Colors.red
                                              : Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        data.likes.length.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: textColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => CommentScreen(
                                              videoId: data.videoId,
                                            ),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.comment,
                                          size: 32,
                                          color: Colors.white70,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        data.commentCount.toString(),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: textColor,
                                        ),
                                      )
                                    ],
                                  ),
                                  // Column(
                                  //   children: [
                                  //     InkWell(
                                  //       onTap: () {},
                                  //       child: const Icon(
                                  //         Icons.reply,
                                  //         size: 36,
                                  //         color: Colors.white70,
                                  //       ),
                                  //     ),
                                  //     const SizedBox(height: 4),
                                  //     Text(
                                  //       data.shareCount.toString(),
                                  //       style: const TextStyle(
                                  //         fontSize: 18,
                                  //         color: Colors.white70,
                                  //       ),
                                  //     )
                                  //   ],
                                  // ),
                                  CustomCircleAnimation(
                                    child: CustomMusicAlbumViewer(
                                      profilePhoto: data.profilePhoto,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
