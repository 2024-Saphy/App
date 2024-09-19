class MemberInfo {
  String? nickname;
  String? profileImgUrl;
  String? purchasePendingCount;
  String? purchaseInProgressCount;
  String? purchaseCompletedCount;
  String? deliveryStartedCount;
  String? deliveryGoingCount;
  String? deliveryDeliveredCount;
  String? salesPendingCount;
  String? salesInProgressCount;
  String? salesCompletedCount;

  MemberInfo({
    this.nickname,
    this.profileImgUrl,
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
    profileImgUrl = json['profileImgUrl'];
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
    data['profileImgUrl'] = profileImgUrl;
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
