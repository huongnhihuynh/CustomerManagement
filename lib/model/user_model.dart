class Customer {
  final String customerID;
  final String customerName;
  final String customerEmail;
  final String customerPhone;
  final String customerPassword;

  Customer({required this.customerID,
          required this.customerName,
          required this.customerEmail,
          required this.customerPhone,
          required this.customerPassword,});

  factory Customer.fromMap(Map<String,dynamic> map,String docCustomerID) {
    return Customer(
      customerID: docCustomerID,
      customerName: map['customerName'],
      customerEmail: map['customerEmail'],
      customerPhone: map['customerPhone'],
      customerPassword: map['customerPassword'],
    );
  }

  Map<String,dynamic> toMap() {
    return {
      'customerName':customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'customerPassword': customerPassword
    };
  }

}