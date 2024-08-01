import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:saphy/service/authentication/google_login_controller.dart';
import 'package:saphy/service/authentication/kakao_login_controller.dart';
import 'package:saphy/service/social_login.dart';

class MainViewModel {
  final SocialLogin _socialLogin;
  bool isLogined = false; //처음에 로그인 안 되어 있음
  User? user; //카카오톡에서 사용자 정보를 저장하는 객체 User를 nullable 변수로 선언
  GoogleSignInAccount?
      googleUser; //구글에서 사용자 정보를 저장하는 객체 GoogleSignInAccount를 nullable 변수로 선언

  MainViewModel(this._socialLogin);

  Future login() async {
    if (_socialLogin.runtimeType == KakaoLoginController) {
      isLogined = await _socialLogin.login(); //로그인되어 있는지 확인
      user = await UserApi.instance.me(); //사용자 정보 받아오기
      return user;
    } else if (_socialLogin.runtimeType == GoogleLoginController) {
      googleUser = await _socialLogin.login();
      return googleUser;
    }
  }

  Future logout() async {
    await _socialLogin.logout(); //로그아웃 실행
    isLogined = false; //로그인되어 있는지를 저장하는 변수 false값 저장
    user = null; //user 객체 null
  }
}
