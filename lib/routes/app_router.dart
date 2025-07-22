import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../screens/input_screen.dart';
import '../screens/view_list_screen.dart';
import '../screens/view_detail_screen.dart';
import '../screens/edit_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context,state) => CustomerListScreen(),
    ),
    GoRoute(
      path: '/input',
      builder: (_,__) => const InputScreen(),
    ),
   GoRoute(
      path: '/detail/:customerID',
      builder: (context,state) => ViewDetailScreen(customerID: state.pathParameters['customerID']!),
    ),
    GoRoute(
      path: '/edit/:customerID',
      builder: (context,state) => EditScreen(customerID: state.pathParameters['customerID']!),
    ),
  ]
  );
