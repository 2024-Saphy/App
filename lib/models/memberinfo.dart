class MemberInfo {
  String? nickname;
  ProfileImage? profileImage;
  int? purchasePendingCount;
  int? purchaseInProgressCount;
  int? purchaseCompletedCount;
  int? deliveryStartedCount;
  int? deliveryGoingCount;
  int? deliveryDeliveredCount;
  int? salesPendingCount;
  int? salesInProgressCount;
  int? salesCompletedCount;

  MemberInfo({
    this.nickname,
    this.profileImage,
    this.purchasePendingCount,
    this.purchaseInProgressCount,
    this.purchaseCompletedCount,
    this.deliveryStartedCount,
    this.deliveryGoingCount,
    this.deliveryDeliveredCount,
    this.salesPendingCount,
    this.salesInProgressCount,
    this.salesCompletedCount,
  });

  MemberInfo.fromJson(Map<String, dynamic> json) {
    nickname = json['nickname'];
    profileImage = json['profileImage'] != null
        ? ProfileImage.fromJson(json['profileImage'])
        : null;
    purchasePendingCount = json['purchasePendingCount'];
    purchaseInProgressCount = json['purchaseInProgressCount'];
    purchaseCompletedCount = json['purchaseCompletedCount'];
    deliveryStartedCount = json['deliveryStartedCount'];
    deliveryGoingCount = json['deliveryGoingCount'];
    deliveryDeliveredCount = json['deliveryDeliveredCount'];
    salesPendingCount = json['salesPendingCount'];
    salesInProgressCount = json['salesInProgressCount'];
    salesCompletedCount = json['salesCompletedCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['nickname'] = nickname;
    if (profileImage != null) {
      data['profileImage'] = profileImage!.toJson();
    }
    data['purchasePendingCount'] = purchasePendingCount;
    data['purchaseInProgressCount'] = purchaseInProgressCount;
    data['purchaseCompletedCount'] = purchaseCompletedCount;
    data['deliveryStartedCount'] = deliveryStartedCount;
    data['deliveryGoingCount'] = deliveryGoingCount;
    data['deliveryDeliveredCount'] = deliveryDeliveredCount;
    data['salesPendingCount'] = salesPendingCount;
    data['salesInProgressCount'] = salesInProgressCount;
    data['salesCompletedCount'] = salesCompletedCount;
    return data;
  }
}

class ProfileImage {
  String? name;
  String? url;

  ProfileImage({this.name, this.url});

  ProfileImage.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}