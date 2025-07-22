import 'package:flutter/material.dart';
import 'package:flutter_application_11/model/user_model.dart';
import 'package:flutter_application_11/services/firestore_service.dart';
import 'package:go_router/go_router.dart';

class CustomerListScreen extends StatefulWidget {
  const CustomerListScreen({super.key});


  
  @override
  State<CustomerListScreen> createState() => _CustomerListScreenState();
}

class _CustomerListScreenState extends State<CustomerListScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customer List'),
      ),
      body: StreamBuilder<List<Customer>>(
        stream: FirestoreService().getCustomers(), 
        builder: (context,snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final customers = snapshot.data!;
          return ListView.builder(
            itemCount: customers.length,
            itemBuilder: (BuildContext context, int index) {
              final customer = customers[index];
              return ListTile(
               title: Text(customer.customerName),
               subtitle: Text(customer.customerEmail),
               onTap: () => context.go('/detail/${customer.customerID}'),
               trailing: Row (
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () => context.go('/edit/${customer.customerID}'), 
                      icon: Icon(Icons.edit)
                    ),
                    IconButton(
                      onPressed: () => FirestoreService().deleteCustomer(customer.customerID), 
                      icon: Icon(Icons.delete),
                    )
                  ],
               ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/input'),
        child: const Icon(Icons.add),
      ),  
    );
  }
}