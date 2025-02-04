class ShippingAddress {
  String? userId;
  String? country;
  String? fullName;
  String? code;
  String? phoneNumber;
  String? streetName;
  String? buildingNameOrNumber;
  String? cityOrArea;
  String? nearestLandmark;

  ShippingAddress({
    this.userId,
    this.country,
    this.fullName,
    this.code,
    this.phoneNumber,
    this.streetName,
    this.buildingNameOrNumber,
    this.cityOrArea,
    this.nearestLandmark,
  });

  Map<String, dynamic> toMap() {
    return {
      "userId" : userId,
      "country": country,
      "fullName": fullName,
      "code": code,
      "phoneNumber": phoneNumber,
      "streetName": streetName,
      "buildingNameOrNumber": buildingNameOrNumber,
      "cityOrArea": cityOrArea,
      "nearestLandmark": nearestLandmark,
    };
  }

  factory ShippingAddress.fromMap(Map<String, dynamic> map) {
    return ShippingAddress(
      userId: map['userId'],
      country: map["country"],
      fullName: map["fullName"],
      code: map["code"],
      phoneNumber: map["phoneNumber"],
      streetName: map["streetName"],
      buildingNameOrNumber: map["buildingNameOrNumber"],
      cityOrArea: map["cityOrArea"],
      nearestLandmark: map["nearestLandmark"],
    );
  }
}
