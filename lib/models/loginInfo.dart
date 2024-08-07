class LoginInfo {
  final String accessToken;
  final String refreshToken;
  final String? email;
  final String socialType;

  LoginInfo(this.accessToken, this.refreshToken, this.email, this.socialType);

  LoginInfo.fromJson(Map<dynamic, dynamic> json)
      : accessToken = json['accessToken'],
        refreshToken = json['refreshToken'],
        email = json['email'],
        socialType = json['socialType'];

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'email': email,
        'socialType': socialType,
      };
}
