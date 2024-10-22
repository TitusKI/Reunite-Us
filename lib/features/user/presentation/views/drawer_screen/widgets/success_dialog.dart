import 'package:afalagi/config/theme/colors.dart';
import 'package:flutter/material.dart';

class UpdateSuccessDialog extends StatelessWidget {
  const UpdateSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.person_rounded,
              size: 80,
              color: AppColors.accentColor,
            ),
            SizedBox(height: 20),
            Text(
              'Profile Updated Successfully',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.accentColor,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
