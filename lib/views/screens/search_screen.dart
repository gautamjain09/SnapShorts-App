import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:snapshorts_app/constants.dart';
import 'package:snapshorts_app/controllers/search_controller.dart';
import 'package:snapshorts_app/views/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  final SearchController searchController = Get.put(
    SearchController(),
  );

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            backgroundColor: backgroundColor,
            title: Column(
              children: [
                SizedBox(
                  height: 55,
                  child: TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, size: 22),
                      filled: false,
                      hintText: 'Search',
                      hintStyle: const TextStyle(
                        fontSize: 16.5,
                        color: textColor,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: borderColor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          color: borderColor,
                        ),
                      ),
                    ),
                    onFieldSubmitted: (value) =>
                        searchController.searchUser(value),
                  ),
                ),
              ],
            ),
          ),
          body: searchController.searchedUsers.isEmpty
              ? const Center(
                  child: Text(
                    'Search for users!',
                    style: TextStyle(
                      fontSize: 24,
                      color: textColor,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: searchController.searchedUsers.length,
                  itemBuilder: (context, index) {
                    final userData = searchController.searchedUsers[index];
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return ProfileScreen(uid: userData.uid);
                          }),
                        );
                      },
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            userData.profilePhoto,
                          ),
                        ),
                        title: Text(
                          userData.username,
                          style: const TextStyle(
                            fontSize: 18,
                            color: textColor,
                          ),
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}
