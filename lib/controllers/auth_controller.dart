import 'dart:io';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snapshorts_app/constants.dart';
import 'package:snapshorts_app/models/user_model.dart' as model;
import 'package:snapshorts_app/views/screens/home_screen.dart';
import 'package:snapshorts_app/views/screens/auth/login_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  // Current User getter
  Rxn<User> _user = Rxn<User>();
  User get user => _user.value!;

  // Profile Photo getter
  Rxn<File> _pickedImage = Rxn<File>();
  File? get profilePhoto => _pickedImage.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rxn<User>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());

    // if anytime user changes then we need to call setInitialScreen
    ever(_user, setInitialScreen);
  }

  setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => const LoginScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  // Image Picker Function
  void imagePicker() async {
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      Get.snackbar(
        "Profile picture updated!",
        "You have succesfully uploaded your profile picture",
      );
    }
    _pickedImage = Rxn<File>(File(pickedImage!.path));
    // we have used Rx to Create stream which keep track if profile photo is updated every time
  }

  // Upload Profile Image to Firebase Storage
  Future<String> uploadProfileImageToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child("profilePics")
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // ------------------------- Register/SignUp Method ---------------------------->

  void registerUser(String username, String email, String password,
      File? profileImage) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          profileImage != null) {
        UserCredential userCredential = await firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: password);

        String downloadUrl = await uploadProfileImageToStorage(profileImage);

        model.User user = model.User(
          username: username,
          email: email,
          uid: firebaseAuth.currentUser!.uid,
          profilePhoto: downloadUrl,
        );

        await firestore
            .collection("users")
            .doc(firebaseAuth.currentUser!.uid)
            .set(user.toJson());
      } else {
        Get.snackbar(
          "Error creating account!",
          "Please enter all the required fields",
        );
      }
    } on FirebaseException catch (e) {
      Get.snackbar(
        "Error Creating account!",
        e.message!,
      );
    }
  }

  // ------------------------------- Login User---------------------------->

  void loginUser(String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        UserCredential userCredential = await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password);
      } else {
        Get.snackbar(
          "Error login account!",
          "Please enter all the fields",
        );
      }
    } on FirebaseException catch (e) {
      Get.snackbar(
        "Error login account!",
        e.message!,
      );
    }
  }

  // ------------------------ SignOut User -------------------------------->

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
