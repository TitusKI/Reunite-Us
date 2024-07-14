import 'package:afalagi/routes/export.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.SIGN_UP);
            },
            child: const Text("Sign Up ")));
  }
}
