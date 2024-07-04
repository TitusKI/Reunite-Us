import 'package:flutter/material.dart';

class ReportMissing extends StatefulWidget {
  const ReportMissing({super.key});

  @override
  State<ReportMissing> createState() => _ReportMissingState();
}

class _ReportMissingState extends State<ReportMissing> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Report Missing Persons"),
    );
  }
}
