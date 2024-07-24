import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:saphy/service/secure_storage.dart';
import 'package:saphy/service/social_login.dart';

class KakaoLoginController implements SocialLogin {
  @override
  Future login() async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        writeAccessToke(token.accessToken);
        writeRefreshToke(token.refreshToken);
        print('Kakaotalk Login Success ${token.accessToken}');
        return true;
      } catch (error) {
        print('Kakaotalk Login Failed $error');
        if (error is PlatformException && error.code == 'CANCELED') {
          return false;
        }
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          print('KakaoAccount Login Success ${token.accessToken}');
          return true;
        } catch (error) {
          print('KakaoAccount Login Failed $error');
          return false;
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        print('KakaoAccount Login Success ${token.accessToken}');
        return true;
      } catch (error) {
        print('KakaoAccount Login Failed $error');
        return false;
      }
    }
  }

  @override
  Future logout() async {
    try {
      await UserApi.instance.unlink();
      print('Kakao Logout Success');
      return true;
    } catch (error) {
      print('Kakao Logout Failed $error');
      return false;
    }
  }
}
