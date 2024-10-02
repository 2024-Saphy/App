class AccountInfo {
  String? loginId;
  String? name;
  String? nickName;
  String? phoneNumber;
  String? email;
  String? socialType;

  AccountInfo({
    this.loginId,
    this.name,
    this.nickName,
    this.phoneNumber,
    this.email,
    this.socialType,
  });

  AccountInfo.fromJson(Map<String, dynamic> json) {
    loginId = json['loginId'];
    name = json['name'];
    nickName = json['nickName'];
    phoneNumber = json['phoneNumber'];
    email = json['email'];
    socialType = json['socialType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['loginId'] = loginId;
    data['name'] = name;
    data['nickName'] = nickName;
    data['phoneNumber'] = phoneNumber;
    data['email'] = email;
    data['socialType'] = socialType;
    return data;
  }
}
