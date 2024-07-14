import 'package:afalagi/routes/names.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:flutter/material.dart';

class ReportMissing extends StatefulWidget {
  const ReportMissing({super.key});

  @override
  State<ReportMissing> createState() => _ReportMissingState();
}

class _ReportMissingState extends State<ReportMissing> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              height: height * 0.2,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.cardColor),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.no_luggage_outlined,
                    size: 35,
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Center(
                    child: reusableText("No Posts"),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "You don't have any previous posts.",
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              "If you have a missing person, post now!",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.ADD_REPORT);
              },
              icon: const Icon(Icons.add),
              label: const Text("Post Missing Person"),
              style: ElevatedButton.styleFrom(
                foregroundColor: AppColors.primaryBackground,
                backgroundColor: AppColors.accentColor, // Text color
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
