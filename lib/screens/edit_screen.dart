import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/user_model.dart';
import '../services/firestore_service.dart';

class EditScreen extends StatefulWidget {
  final String customerID;
  const EditScreen({super.key,required this.customerID});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final _formKey = GlobalKey<FormState>();
  
  String name = '',email='',phone='',password='';

  @override
  void initState() {
    super.initState();
    FirestoreService().getCustomer(widget.customerID).then((customer) {
      setState(() {
        name = customer.customerName;
        email= customer.customerEmail;
        phone = customer.customerPhone;
        password = customer.customerPassword;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Customer Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              
              TextFormField(
                initialValue: email,
                decoration: const InputDecoration(labelText: 'Email'),
                onSaved: (value) => email = value!,
              ),
              TextFormField(
                initialValue: name,
                decoration: const InputDecoration(labelText: 'Full Name'),
                onSaved: (value) => name = value!,
              ),
              TextFormField(
                initialValue: phone,
                decoration: const InputDecoration(labelText: 'Phone number'),
                onSaved: (value) => phone = value!,
              ),
              TextFormField(
                initialValue: password,
                decoration: const InputDecoration(labelText: 'Password'),
                onSaved: (value) => password = value!,
                obscureText: true,
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState!.save();
                  final updateCustomer = Customer(
                    customerID: widget.customerID, 
                    customerName: name, 
                    customerEmail: email, 
                    customerPhone: phone, 
                    customerPassword: password);
                  FirestoreService().updateCustomer(updateCustomer).then((_){
                    Navigator.pop(context);
                  });
                },
                child: Text('Update Customer Details')
                ),
            ],
          )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/'),
        child: const Icon(Icons.watch),
      ),
    );
  }
}