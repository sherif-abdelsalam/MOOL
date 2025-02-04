class PaymentModel {
  PaymentModel({
    required this.userId, // Add userId field
    required this.cardNumber,
    required this.fullName,
    required this.expiryDate,
    required this.cvv,
    required this.methodType,
  });

  final String userId; // Declare userId
  final String fullName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String methodType;

  // Convert a PaymentModel object to a Map
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fullName': fullName,
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
      'methodType': methodType,
    };
  }

  // Create a PaymentModel object from a Map
  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      userId: map['userId'],
      fullName: map['fullName'],
      cardNumber: map['cardNumber'],
      expiryDate: map['expiryDate'],
      cvv: map['cvv'],
      methodType: map['methodType'],
    );
  }
}
