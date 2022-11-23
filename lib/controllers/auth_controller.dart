import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shortvideo/utils/constant.dart';
import 'package:shortvideo/models/user.dart' as model;
import 'package:shortvideo/views/screens/auth/login_screen.dart';
import 'package:shortvideo/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<File?> _pickedImage;
  late Rx<User?> _user;
// getter method for image
  File? get profilePhoto => _pickedImage.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, (callback) => _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

//  pick Image
  pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar(
          "Profile Picture", "Your have successfully selected profile picture");
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }
//  upload image to firebase storage

  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);

    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  // Login user

  void loginUser({required String email, required String password}) async {
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        Get.snackbar("Required *", "Please fill all the fields");
      }
    } catch (e) {
      Get.snackbar("Error while login", e.toString());
    }
  }

//  Register user

  void registerUser(
      String username, String email, String password, File? image) async {
    try {
      if (username.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        //  save user in firebase

        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String downloadUrl = await _uploadToStorage(image);

        // Add user to firebase database

        model.User user = model.User(
            uid: cred.user!.uid,
            name: username,
            email: email,
            profilePhoto: downloadUrl);

        await firestore.collection('user').doc(cred.user!.uid).set(
              user.toJson(),
            );
      } else {
        Get.snackbar("Required *", "Please fill all the fields");
      }
    } catch (e) {
      Get.snackbar("Error while signing", e.toString());
    }
  }
}
