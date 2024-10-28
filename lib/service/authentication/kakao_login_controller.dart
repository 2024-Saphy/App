import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:saphy/models/loginInfo.dart';
import 'package:saphy/service/authentication/secure_storage.dart';
import 'package:saphy/service/social_login.dart';
import 'package:saphy/utils/log.dart';

class KakaoLoginController implements SocialLogin {
  @override
  Future login() async {
    if (await isKakaoTalkInstalled()) {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        await writeAccessToke(token.accessToken);
        await writeRefreshToke(token.refreshToken);
        logger.i('Kakaotalk Login Success ${token.accessToken}');
        return true;
      } catch (error) {
        logger.i('Kakaotalk Login Failed $error');
        if (error is PlatformException && error.code == 'CANCELED') {
          return false;
        }
        try {
          OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
          await writeAccessToke(token.accessToken);
          await writeRefreshToke(token.refreshToken);
          logger.i('KakaoAccount Login Success ${token.accessToken}');
          return true;
        } catch (error) {
          logger.i('KakaoAccount Login Failed $error');
          return false;
        }
      }
    } else {
      try {
        OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
        logger.i('KakaoAccount Login Success ${token.accessToken}');
        await writeAccessToke(token.accessToken);
        await writeRefreshToke(token.refreshToken);
        return true;
      } catch (error) {
        logger.i('KakaoAccount Login Failed $error');
        return false;
      }
    }
  }

  @override
  Future logout() async {
    try {
      await UserApi.instance.unlink();
      logger.i('Kakao Logout Success');
      return true;
    } catch (error) {
      logger.i('Kakao Logout Failed $error');
      return false;
    }
  }
}
