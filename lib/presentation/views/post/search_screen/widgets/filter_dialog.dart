import 'package:afalagi/presentation/bloc/post/report_form/report_form_bloc.dart';
import 'package:afalagi/presentation/bloc/post/report_form/report_form_state.dart';
import 'package:afalagi/config/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterDialog extends StatelessWidget {
  final List<String> hairColor = ["Black", "White", "Brown", "Blonde", "Grey"];
  final List<String> skinColor = ["Black", "Brown", "White", "Light Skin"];
  FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filters',
                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  color: AppColors.accentColor,
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            TextField(
              decoration: InputDecoration(
                hintText: 'search filters',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            BlocBuilder<ReportFormBloc, ReportFormState>(
              builder: (context, state) {
                // final selectedHairColor = state.hairColor;
                return GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.5.w,
                  mainAxisSpacing: 15.h,
                  shrinkWrap: true,
                  childAspectRatio: 3.dg,
                  children: [
                    // SizedBox(
                    //   child: dropDownField(
                    //       selected: selectedHairColor as String,
                    //       dropDown: HairColor.values,
                    //       context: context,
                    //       hintText: "hair color",
                    //       keyName: "hairColor"),
                    // ),
                    _buildDropdown('Gender'),
                    _buildDropdown('Age'),
                    _buildDropdown('Location'),
                    _buildDropdown('Date'),
                    _buildDropdown('Education Level'),
                    _buildDropdown('Disability'),
                    _buildDropdown('Hair color'),
                    _buildDropdown("Skin Color"),

                    _buildDropdown('Eye Color'),
                    _buildDropdown('height range'),
                  ],
                );
              },
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Reset logic here
                  },
                  style: OutlinedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
                  ),
                  child: const Text(
                    'Reset',
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Apply filter logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentColor,
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
                  ),
                  child: const Text(
                    'Apply filter',
                    style: TextStyle(color: AppColors.primaryBackground),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown(String hint) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: AppColors.secondaryColor),
        contentPadding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      items: ['Option 1', 'Option 2', 'Option 3'].map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            // style: const TextStyle(color: AppColors.secondaryColor),
          ),
        );
      }).toList(),
      onChanged: (value) {},
    );
  }
}
