import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:snapshorts_app/constants.dart';
import 'package:snapshorts_app/controllers/profile_controller.dart';
import 'package:snapshorts_app/views/screens/search_screen.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;
  const ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profileController.updateUserId(widget.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (profileController.user.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          leading: InkWell(
            onTap: (() {
              Get.to(
                () => SearchScreen(),
              );
            }),
            child: const Icon(
              Icons.person_add_alt_1_outlined,
              color: textColor,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.all(5.0),
              child: Icon(Icons.more_horiz),
            ),
          ],
          centerTitle: false,
          title: Text(
            profileController.user['username'],
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: profileController.user['profilePhoto'],
                              height: 100,
                              width: 100,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.error,
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Text(
                            profileController.user['likes'],
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                          ),
                          const Text(
                            'Likes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: 140,
                        height: 45,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              authController.signOut();
                            },
                            child: const Text(
                              'Sign Out',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1,
                          crossAxisSpacing: 5,
                          mainAxisSpacing: 5,
                        ),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            profileController.user['thumbnailUrls'].length,
                        itemBuilder: ((context, index) {
                          String thumbnail =
                              profileController.user['thumbnailUrls'][index];
                          return CachedNetworkImage(
                            imageUrl: thumbnail,
                            fit: BoxFit.cover,
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
