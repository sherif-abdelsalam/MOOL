class PaymentModel {
  PaymentModel({
    required this.id,
    required this.cardNumber,
    required this.fullName,
    required this.expiryDate,
    required this.cvv,
    required this.methodType,
  });
  final String id;
  final String fullName;
  final String cardNumber;
  final String expiryDate;
  final String cvv;
  final String methodType;
}
