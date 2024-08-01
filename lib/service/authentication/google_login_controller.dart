import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:saphy/service/authentication/secure_storage.dart';
import 'package:saphy/service/social_login.dart';
import 'package:saphy/utils/log.dart';

class GoogleLoginController implements SocialLogin {
  static final _googleSignIn = GoogleSignIn();

  @override
  Future login() async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      final googleKey = await user?.authentication;
      final accessToken = googleKey?.accessToken;
      final refreshToken = googleKey?.idToken;
      writeAccessToke(accessToken);
      writeRefreshToke(refreshToken);
      logger.i('Google Login Success $user');
      return user;
    } catch (error) {
      print('Google Login Failed $error');
    }
    return false;
  }

  @override
  Future logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }
}
