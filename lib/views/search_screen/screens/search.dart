import 'package:flutter/material.dart';

class SearchMissing extends StatefulWidget {
  const SearchMissing({super.key});

  @override
  State<SearchMissing> createState() => _SearchMissingState();
}

class _SearchMissingState extends State<SearchMissing> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Search For Missing Persons"),
    );
  }
}
