import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user_model.dart';

class FirestoreService {
  final customersRef = FirebaseFirestore.instance.collection('customers');

  Future<void> addCustomer(Customer customer) async {
    await customersRef.doc(customer.customerID).set(customer.toMap());
  }

  Future<void> updateCustomer(Customer customer) async {
    await customersRef.doc(customer.customerID).update(customer.toMap());
  } 

  Future<void> deleteCustomer(String customerID) async {
    await customersRef.doc(customerID).delete();
  }

  Stream<List<Customer>> getCustomers() {
    return customersRef.snapshots().map((snapshop) 
    => snapshop.docs.map((doc) 
    => Customer.fromMap(doc.data() as Map<String,dynamic>, doc.id))
      .toList());
  }

  Future<Customer> getCustomer(String customerID) async {
    final doc = await customersRef.doc(customerID).get();
    return Customer.fromMap(doc.data() as Map<String,dynamic>, doc.id);
  }
}