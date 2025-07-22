import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_application_11/model/user_model.dart';
import 'package:flutter_application_11/services/firestore_service.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();

  String name = '', email='',phone='',password='';
  bool _obscurepassword = true;
  final _uuid = const Uuid();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screen for inputing customers',
        style: TextStyle(fontSize: 30),),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "example@gmail.com",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  onSaved: (value) => email = value ?? "",
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter your email';
                    }
                    if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                      return "Email is invalid";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  onSaved: (value)=>name= value ?? "",
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Please input your full name";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone),
                  ),
                  onSaved: (value) => phone = value ?? "",
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please enter your phone number';
                    }
                    if(!RegExp(r"^[0-9]{1,}$").hasMatch(value)){
                      return "Phone number is invalid";
                    }
                    if(value.length<9 && value.length>10){
                      return "The length of phone number is not true";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20,),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      onPressed: (){
                        setState(() {
                          _obscurepassword = !_obscurepassword;
                        });
                      }, 
                      icon: Icon(
                        _obscurepassword
                          ?Icons.visibility
                          :Icons.visibility_off,
                      )),
                  ),
                  obscureText: _obscurepassword,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return "Please enter your password";
                    }
                    if(value.length<6) {
                      return 'Email is at least six characters';
                    }
                    return null;
                  },
                  onSaved: (value) => password = value ?? "",
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        _formKey.currentState!.save();
                        final newcustomer = Customer(customerID: _uuid.v4(), 
                            customerName: name, 
                            customerEmail: email, 
                            customerPhone: phone, 
                            customerPassword: password);
                        await FirestoreService().addCustomer(newcustomer);
                        if (!mounted) return;
                         Navigator.pop(context);
                         ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Customer information saved!')),);
                            name = ''; 
                            email = '';
                            phone='';
                            password='';

                      },
                      child: Text('Submit')),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: (){
                        _formKey.currentState!.reset();
                        setState(() {
                          name = ''; 
                          email = '';
                          phone='';
                          password='';

                        });
                      },
                      child: Text('Reset')),
                  ],
                )
              ],
            ),
            ),
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