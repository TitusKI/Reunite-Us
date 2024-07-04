import 'package:flutter/material.dart';

class FoundPersons extends StatefulWidget {
  const FoundPersons({super.key});

  @override
  State<FoundPersons> createState() => _FoundPersonsState();
}

class _FoundPersonsState extends State<FoundPersons> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("A List of Reunited Individuals"),
    );
  }
}
