import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/user/user_repository.dart';
import '../../../utils/constants/constants.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/full_screen_loader.dart';
import '../../authentication/models/user_model.dart';
import '../../authentication/screens/login/login_screen.dart';
import '../screens/profile/widgets/re_authenticate_user_login_form.dart';
import 'package:dio/dio.dart' as dio;

class UserController extends GetxController {
  static UserController get instance => Get.find();

  /// Variables
  final profileLoading = false.obs;
  Rx<UserModel> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final imageUploading = false.obs;
  final hidePassword = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  /// Save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      // First update Rx User and then check if user data is already stored. If not store new data
      await fetchUserRecord();

      // If no record already stored
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          // Convert Full Name to First and Last Name
          final nameParts = UserModel.nameParts(
            userCredentials.user!.displayName ?? '',
          );
          final username = UserModel.generateUsername(
            userCredentials.user!.displayName ?? '',
          );

          // Map Data
          final user = UserModel(
            id: userCredentials.user!.uid,
            firstName: nameParts[0],
            lastName: nameParts.length > 1
                ? nameParts.sublist(1).join(' ')
                : '',
            username: username,
            email: userCredentials.user!.email ?? '',
            phoneNumber: userCredentials.user!.phoneNumber ?? '',
            profilePicture: userCredentials.user!.photoURL ?? '',
          );

          // Save user Record
          await userRepository.saveUserRecord(user);
        }
      }
    } catch (e) {
      UHelperFunctions.warningSnackBar(
        title: 'Data not saved',
        message:
            'Something went wrong while saving your information. You can re-save your data in your profile.',
      );
    }
  }

  /// Delete Account Warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: const EdgeInsets.all(USizes.md),
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete account Permanently? This action is not reversible and all of your data will be removed permanently.',
      confirm: ElevatedButton(
        onPressed: () async => deleteUserAccount(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: const BorderSide(color: Colors.red),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: USizes.lg),
          child: Text('Delete'),
        ),
      ),
      cancel: OutlinedButton(
        onPressed: () => Navigator.of(Get.overlayContext!).pop(),
        child: const Text('Cancel'),
      ),
    );
  }

  /// Delete User Account
  void deleteUserAccount() async {
    try {
      UFullScreenLoader.openLoadingDialog('Processing', UImages.docerAnimation);

      /// First Re-Authenticate User
      final auth = AuthenticationRepository.instance;
      final provider = auth.authUser!.providerData
          .map((e) => e.providerId)
          .first;
      if (provider.isNotEmpty) {
        // Re verify Auth Email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          UFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          UFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthLoginForm());
        }
      }
    } catch (e) {
      UFullScreenLoader.stopLoading();
      UHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /// RE_AUTHENTICATE before deleting
  Future<void> reAuthenticateEmailAndPasswordUser() async {
    try {
      // Start Login
      UFullScreenLoader.openLoadingDialog('Processing', UImages.docerAnimation);

      // Check internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      // ReAuthenticate user with email and password
      await AuthenticationRepository.instance
          .reAuthenticateWithEmailAndPassword(
            verifyEmail.text.trim(),
            verifyPassword.text.trim(),
          );
      await AuthenticationRepository.instance.deleteAccount();

      // Stop Loading
      UFullScreenLoader.stopLoading();

      // Redirect
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      UFullScreenLoader.stopLoading();
      UHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    }
  }

  /*uploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 512,
        maxHeight: 512,
      );
      if (image != null) {
        // start loading
        imageUploading.value = true;
        // Upload Image
        final imageUrl = await userRepository.uploadImage(
          'Users/Images/Profile/',
          image,
        );

        // Update user Record
        Map<String, dynamic> json = {'ProfilePicture': imageUrl};
        await userRepository.updateSingleField(json);

        // update Rx User
        user.value.profilePicture = imageUrl;
        user.refresh();

        UHelperFunctions.successSnackBar(
          title: 'Congratulations',
          message: 'Your Profile Image has been updated!',
        );
      }
    } catch (e) {
      UHelperFunctions.errorSnackBar(
        title: 'Oh Snap!',
        message: 'Something went wrong: $e',
      );
    } finally {
      imageUploading.value = false;
    }
  }*/

  Future<void> updateUserProfilePicture() async {
    try{

      imageUploading.value = true;
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery,maxHeight: 512,maxWidth: 512);
      if(image == null){
        return;
      }

      File file = File(image.path);

      if(user.value.publicId.isNotEmpty){
        await userRepository.deleteProfilePicture(user.value.publicId);
      }

      dio.Response response =  await userRepository.uploadImage(file);

      if(response.statusCode == 200){

        final data =  response.data;
        final imageUrl = data['url'];
        final publicId = data['public_id'];

        await userRepository
            .updateSingleField({'profilePicture': imageUrl, 'publicId': publicId});

        user.value.profilePicture = imageUrl;
        user.value.publicId = publicId;

        user.refresh();

        UHelperFunctions.successSnackBar(title: 'Success', message: 'Profile picture updated successfully');

      } else{
        throw 'Failed to upload profile picture. Please try again';
      }
    } catch(e){
      UHelperFunctions.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally{
      imageUploading.value = false;
    }
  }
}
