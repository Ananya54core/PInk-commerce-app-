
import 'package:application/features/authentication/screen/onboarding/login/login.dart';
import 'package:application/features/authentication/screen/onboarding/onboarding.dart';
import 'package:application/features/authentication/screen/onboarding/signup/verifyemail.dart';
import 'package:application/lib/firebase_authentication_implement/firebase_auth_services.dart';
import 'package:application/navigationmenu.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

import '../../../../utils/exception/TFirebaseauthexception.dart';
import '../../../../utils/exception/TPlatform_exception.dart';
import '../../../../utils/exception/TfirebaseException.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../user_repositor/user_repository.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variables
  final devicestorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  User? get authUser => _auth.currentUser;

  // Called from main dart for app launch
  @override
  void onReady() {
    // Remove splash screen
    FlutterNativeSplash.remove();
    // Redirect to appropriate screen
    screenRedirect();
  }

  // Function to show relevant screen
  void screenRedirect() async {
    final user = _auth.currentUser;

    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const Navigationmenu());
      } else {
        Get.offAll(() => VerifyEmail(email: user.email));
      }
    } else {
      // Splash screen for one time
      bool? isFirstTime = await devicestorage.read('isFirstTime');
      if (isFirstTime == null) {
        await devicestorage.write('isFirstTime', true);
        isFirstTime = true;
      }

      if (isFirstTime) {
        Get.offAll(() => OnBoardingScreen());
      } else {
        Get.offAll(() => LoginScreen());
      }
    }
  }

  // Login - email authentication
  Future<UserCredential> loginWithEmailPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code); // Use your custom exception class here
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code); // Use your custom exception class here
    } on FormatException catch (_) {
      throw FormatException(); // Custom message for FormatException
    } on PlatformException catch (e) {
      throw TPlatformException(e.code); // Use your custom exception class here
    } catch (e) {
      throw Exception("Something went wrong, please try again later");
    }
  }

  // Email Authentication for register
  Future<UserCredential> registerWithEmailPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code, message: e.message);
    } on FormatException catch (_) {
      throw const FormatException("Invalid format");
    } on Exception catch (e) {
      if (e is PlatformException) {
        throw PlatformException(code: e.code, message: e.message);
      } else {
        throw Exception("Something went wrong, please try again later");
      }
    }
  }

  // Email verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on Exception {
      throw Exception("Something went wrong, please try again later");
    }
  }

  // Forget password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on Exception {
      throw Exception("Something went wrong, please try again later");
    }
  }

  // Google sign-in
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();
      if (userAccount == null) {
        // User canceled the sign-in
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await userAccount.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code); // Use your custom exception class here
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code); // Use your custom exception class here
    } on FormatException catch (_) {
      throw FormatException(); // Custom message for FormatException
    } on PlatformException catch (e) {
      throw TPlatformException(e.code); // Use your custom exception class here
    } catch (e) {
      if (kDebugMode) print("Something went wrong: $e");
      return null; // Return null if an unknown error occurs
    }
  }

  // Logout user valid for any authentication
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => LoginScreen());
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } on FormatException {
      throw FormatException("Invalid format");
    } catch (e) {
      throw Exception("Something went wrong, please try again later");
    }
  }

  Future<void> reAuthenticateWithEmailAndPassword(String email, String password) async {
    try {
      AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw "Something went wrong, please try again later!";
    }
  }

  Future<void> deleteAccount() async {
    try {
      await UserRepository.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FormatException {
      throw const FormatException('Invalid format.');
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again.';
    }
  }
}

