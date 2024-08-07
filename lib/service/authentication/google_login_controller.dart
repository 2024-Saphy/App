import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saphy/service/authentication/secure_storage.dart';
import 'package:saphy/service/social_login.dart';
import 'package:saphy/utils/log.dart';

class GoogleLoginController implements SocialLogin {
  static final _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  @override
  Future<GoogleSignInAccount?> login() async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      final googleKey = await user?.authentication;
      final accessToken = googleKey?.accessToken;
      final refreshToken = googleKey?.idToken;
      await writeAccessToke(accessToken);
      await writeRefreshToke(refreshToken);
      logger.i('Google Login Success $user');

      final cred = GoogleAuthProvider.credential(
          idToken: refreshToken, accessToken: accessToken);

      return user;
    } catch (error) {
      logger.i('Google Login Failed $error');
    }
    return null;
  }

  @override
  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
