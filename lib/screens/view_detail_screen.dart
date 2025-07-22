import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/user_model.dart';
import '../services/firestore_service.dart';

class ViewDetailScreen extends StatelessWidget {
  final String customerID;
  
  const ViewDetailScreen({super.key, required this.customerID});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Customer>(
      future: FirestoreService().getCustomer(customerID),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final customer = snapshot.data!;
        return Scaffold(
          appBar: AppBar(
            title: Text('Detail Customer'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Full name: ${customer.customerName}'),
                Text('Email: ${customer.customerEmail}'),
                Text('Phone number: ${customer.customerPhone}'),
                Text('Password: ${customer.customerPassword}'),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => context.go('/'),
            child: const Icon(Icons.watch),
          ),
        );
      },
    );
  }
}