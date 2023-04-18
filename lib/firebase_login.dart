import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

class AuthManage{
  /// 회원가입
  Future<bool> createUser(String email, String pw) async{
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pw,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Logger().w('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Logger().w('The account already exists for that email.');
      }
    } catch (e) {
      Logger().e(e);
      return false;
    }
    // authPersistence(); // 인증 영속
    return true;
  }

  /// 로그인
  Future<bool> signIn(String email, String pw) async{
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: pw
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Logger().w('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Logger().w('Wrong password provided for that user.');
      }
    } catch (e) {
      Logger().e(e);
      return false;
    }
    // authPersistence(); // 인증 영속
    return true;
  }
  /// 로그아웃
  void signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  /// 회원가입, 로그인시 사용자 영속
  void authPersistence() async{
    await FirebaseAuth.instance.setPersistence(Persistence.NONE);
  }
  /// 유저 삭제
  Future<void> deleteUser(String email) async{
    final user = FirebaseAuth.instance.currentUser;
    await user?.delete();
  }

  /// 현재 유저 정보 조회
  User? getUser(){
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
  User? getUserFromSocial(){
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
  Future<void> updateProfileName(String name) async{
    final user = FirebaseAuth.instance.currentUser;
    await user?.updateDisplayName(name);
  }
  /// 유저 url 업데이트
  Future<void> updateProfileUrl(String url) async{
    final user = FirebaseAuth.instance.currentUser;
    await user?.updatePhotoURL(url);
  }
  /// 비밀번호 초기화 메일보내기
  Future<void> sendPasswordResetEmail(String email) async{
    await FirebaseAuth.instance.setLanguageCode("kr");
    await FirebaseAuth.instance.sendPasswordResetEmail(email:email);
  }


}