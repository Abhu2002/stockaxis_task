class PricingPlan {
  final String pCode;
  final String pDescription;
  final int pAmount;
  final String pDuration;
  final String pkgName;
  final int comboOffer;
  final String alertMsg;
  final String couponCode;
  final int srNo;
  final String pTotalAmount;

  PricingPlan({
    required this.pCode,
    required this.pDescription,
    required this.pAmount,
    required this.pDuration,
    required this.pkgName,
    required this.comboOffer,
    required this.alertMsg,
    required this.couponCode,
    required this.srNo,
    required this.pTotalAmount,
  });

  factory PricingPlan.fromJson(Map<String, dynamic> json) {
    return PricingPlan(
      pCode: json['PCode'] ?? '',
      pDescription: json['PDescription'] ?? '',
      pAmount: int.tryParse(json['PAmount'].toString()) ?? 0,
      pDuration: json['PDuration'] ?? '',
      pkgName: json['PKGName'] ?? '',
      comboOffer: int.tryParse(json['ComboOffer'].toString()) ?? 0,
      alertMsg: json['AlertMsg'] ?? '',
      couponCode: json['CouponCode'] ?? '',
      srNo: json['SrNo'] ?? 0,
      pTotalAmount: json['PTotaAmount'] ?? '',
    );
  }
}
