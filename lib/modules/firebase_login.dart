import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:plancation/modules/another.dart';
import 'package:plancation/modules/firebase_firestore.dart';
import 'package:plancation/pages/home.dart';

class AuthManage {
  /// 회원가입
  Future<bool> createUser(String email, String pw, String name, context) async {
    try {
      loadingSnackbar(context, "회원가입 중입니다!");
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pw,
      );
      await updateProfileName(name);
      await StoreManage().createUser(credential.user!.uid, name, context);
      dismissSnackBar(context);
      Navigator.push(
          context, CupertinoPageRoute(builder: (context) => const HomePage()));
    } on FirebaseAuthException catch (e) {
      Logger().e(e.message);
      if (e.message!.contains('auth/weak-password')) {
        errorSnackBar(context, "더 강력한 비밀번호를 입력해주세요!");
      } else if (e.message!.contains('auth/email-already-in-use')) {
        errorSnackBar(context, "이미 가입되어 있는 이메일입니다!");
      } else {
        errorSnackBar(context, "알 수 없는 오류입니다! 오류 코드: ${e.message}");
      }
    } catch (e) {
      Logger().e(e);
      return false;
    }
    // authPersistence(); // 인증 영속
    return true;
  }

  /// 로그인
  Future<bool> signIn(String email, String pw, context) async {
    try {
      loadingSnackbar(context, "로그인 중입니다!");
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: pw);
      dismissSnackBar(context);
      Navigator.pushAndRemoveUntil(
          context,
          CupertinoPageRoute(builder: (context) => const HomePage()),
          (_) => false);
    } on FirebaseAuthException catch (e) {
      dismissSnackBar(context);
      Logger().e(e.message);
      if (e.message!.contains('auth/user-not-found')) {
        errorSnackBar(context, "가입되어 있는 정보가 없습니다!");
      } else if (e.message!.contains('auth/wrong-password')) {
        errorSnackBar(context, "비밀번호가 일치하지 않습니다!");
      } else if (e.message!.contains('auth/invalid-email')) {
        errorSnackBar(context, "이메일 형식이 맞지 않습니다!");
      } else {
        errorSnackBar(context, "알 수 없는 오류입니다! 오류 코드: ${e.message}");
      }
    } catch (e) {
      Logger().e(e);
      return false;
    }
    // authPersistence(); // 인증 영속
    return true;
  }

  /// 로그아웃
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  /// 회원가입, 로그인시 사용자 영속
  void authPersistence() async {
    await FirebaseAuth.instance.setPersistence(Persistence.NONE);
  }

  /// 유저 삭제
  Future<void> deleteUser(String email) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.delete();
  }

  /// 현재 유저 정보 조회
  User? getUser() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Name, email address, and profile photo URL
      final name = user.displayName;
      final email = user.email;
      final photoUrl = user.photoURL;

      // Check if user's email is verified
      final emailVerified = user.emailVerified;

      // The user's ID, unique to the Firebase project. Do NOT use this value to
      // authenticate with your backend server, if you have one. Use
      // User.getIdToken() instead.
      final uid = user.uid;
    }
    return user;
  }

  /// 공급자로부터 유저 정보 조회
  User? getUserFromSocial() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      for (final providerProfile in user.providerData) {
        // ID of the provider (google.com, apple.cpm, etc.)
        final provider = providerProfile.providerId;

        // UID specific to the provider
        final uid = providerProfile.uid;

        // Name, email address, and profile photo URL
        final name = providerProfile.displayName;
        final emailAddress = providerProfile.email;
        final profilePhoto = providerProfile.photoURL;
      }
    }
    return user;
  }

  /// 유저 이름 업데이트
  Future<void> updateProfileName(String name) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updateDisplayName(name);
  }

  /// 유저 url 업데이트
  Future<void> updateProfileUrl(String url) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updatePhotoURL(url);
  }

  /// 유저 Email 업데이트
  Future<void> updateProfileEmail(String email) async {
    final user = FirebaseAuth.instance.currentUser;
    await user?.updateEmail(email);
  }

  /// 비밀번호 초기화 메일보내기
  Future<void> sendPasswordResetEmail(
      String email, BuildContext context) async {
    try {
      loadingSnackbar(context, "이메일 전송 중입니다!");
      await FirebaseAuth.instance.setLanguageCode("kr");
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      dismissSnackBar(context);
      Logger().e(e.message);
      if (e.message!.contains('auth/user-not-found')) {
        errorSnackBar(context, "가입되어 있는 정보가 없습니다!");
      } else if (e.message!.contains('auth/invalid-email')) {
        errorSnackBar(context, "이메일 형식이 맞지 않습니다!");
      } else {
        errorSnackBar(context, "알 수 없는 오류입니다! 오류 코드: ${e.message}");
      }
    }
  } //원재야 헬프!!!!😊

  /// 구글 로그인 구현
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
