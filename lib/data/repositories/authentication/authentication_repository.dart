import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:grocery_app/data/repositories/banner/banner_repository.dart';
import 'package:grocery_app/data/repositories/brand/brand_repository.dart';
import 'package:grocery_app/data/repositories/categories/category_repository.dart';
import 'package:grocery_app/data/repositories/product_repository.dart';
import 'package:grocery_app/dummy_data.dart';
import 'package:grocery_app/features/personalization/controllers/user_controller.dart';
import '../../../features/authentication/screens/forgot_password/verify_email.dart';
import '../../../features/authentication/screens/login/login_screen.dart';
import '../../../features/authentication/screens/onboarding/onboarding_screen.dart';
import '../../../navigation_menu.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exception.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/local_storage/storage_utility.dart';
import '../../user/user_repository.dart';

class AuthenticationRepository extends GetxController{
  static AuthenticationRepository get instance => Get.find();

  /// Variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;


  /// Called from main.dart on app launch
  /*@override
  void onReady() {
    // Remove the splash screen
    FlutterNativeSplash.remove();
    // Redirect to the appropriate screen
    screenRedirect();
    Get.put(CategoryRepository()).uploadDummyCategories(UDummyData.categories);
    Get.put(CategoryRepository()).uploadDummyBrandCategory(UDummyData.brandCategory);
    Get.put(CategoryRepository()).uploadDummyProductCategory(UDummyData.productCategory);
    Get.put(BannerRepository()).uploadBanners(UDummyData.banner);
    Get.put(BrandRepository()).uploadBrands(UDummyData.brands);
    Get.put(ProductRepository()).uploadDummyProducts(UDummyData.products);
  }*/

  @override
  Future<void> onReady() async {
    super.onReady();
    FlutterNativeSplash.remove();

    await screenRedirect();

    Future.microtask(() async {
      try {
        //final categoryRepo = Get.put(CategoryRepository(), permanent: true);
        //final bannerRepo   = Get.put(BannerRepository(), permanent: true);
        final brandRepo    = Get.put(BrandRepository(), permanent: true);
        //final productRepo  = Get.put(ProductRepository(), permanent: true);

        //await categoryRepo.uploadDummyCategories(UDummyData.categories);
        //await categoryRepo.uploadDummyBrandCategory(UDummyData.brandCategory);
        //await categoryRepo.uploadDummyProductCategory(UDummyData.productCategory);
        //await bannerRepo.uploadBanners(UDummyData.banner);
        await brandRepo.uploadBrands(UDummyData.brands);
        //await productRepo.uploadDummyProducts(UDummyData.products);

        print("🔥 ALL UPLOADED");
      } catch (e) {
        print("ERROR: $e");
      }
    });
  }





  /// Function to show relevant screen
  Future<void> screenRedirect() async{
    final user = _auth.currentUser;
    if(user != null){
      // if user is logged in
      if(user.emailVerified){

        // Initialize user specific storage
        await ULocalStorage.init(user.uid);

        // if user email is verified , navigate to navigation menu
        Get.offAll(() => const NavigationMenu());

        await GetStorage.init(user.uid);

      }else{
        // if user's email is not verified, navigate to the verify email screen
        Get.offAll(() => VerifyEmailScreen(email: user.email!,));
      }
    }else{
      // Local Storage
      deviceStorage.writeIfNull('IsFistTime', true);

      deviceStorage.read('IsFirstTime') != true ? Get.offAll(() => const LoginScreen()) : Get.offAll(() => const OnboardingScreen());
    }


  }


  /*---------- Email & Password Sign-in --------------------------------*/

  /// [Email Authentication] - Sign In
  Future<UserCredential> loginWithEmailAndPassword(String email, String password) async{
    try{
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// [EmailAuthentication] - REGISTER
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async{
    try{
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// [ReAuthenticate] - ReAuthenticate User
  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async{
    try{
      // Create a credential
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);

      // ReAuthenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);

    }on UFirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Email Verification] - Mail Verification
  Future<void> sendEmailVerification() async{
    try{
      await _auth.currentUser!.sendEmailVerification();
    } on UFirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  /// [Email Verification] - Forget Password
  Future<void> sendPasswordResetEmail(String email) async{
    try{
      await _auth.sendPasswordResetEmail(email: email);
    } on UFirebaseException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> logout() async{
    try{
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      Get.offAll(() => LoginScreen());
    } on UFirebaseException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }


  /*---------- Federated identity & social Sign-in --------------------------------*/

  /// [GoogleAuthentication] - GOOGLE
  Future<UserCredential?> signInWithGoogle() async{
    try{
      // Trigger the authentication flow
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      // Obtain the authentication details from the request
      final GoogleSignInAuthentication? googleAuth = await userAccount?.authentication;

      // Create a credential
      final  OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken);

      // Once the signed in, return the user credential
      return await _auth.signInWithCredential(credential);


    } on UFirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      if(kDebugMode) print('Something went wrong: $e');
      return null;
    }
  }

  /// DELETE USER - Remove user Auth and  Firestore Account
  Future<void> deleteAccount() async{
    try{
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      if(UserController.instance.user.value.publicId.isNotEmpty){
        UserRepository.instance.deleteProfilePicture(UserController.instance.user.value.publicId);
      }
      await _auth.currentUser?.delete();
    }on UFirebaseAuthException catch(e){
      throw UFirebaseAuthException(e.code).message;
    } on FirebaseException catch(e){
      throw UFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const UFormatException();
    } on PlatformException catch(e){
      throw UPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }
}