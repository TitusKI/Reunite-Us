import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/core/util/data_util.dart';
import 'package:afalagi/features/post/domain/entities/missing_person_entity.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MissingPersonDetail extends StatefulWidget {
  final MissingPersonEntity? missingPerson;

  const MissingPersonDetail({super.key, this.missingPerson});

  @override
  State<MissingPersonDetail> createState() => _MissingPersonDetailState();
}

class _MissingPersonDetailState extends State<MissingPersonDetail> {
  late MissingPersonEntity? missingPerson;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args =
        ModalRoute.of(context)?.settings.arguments as MissingPersonEntity?;
    setState(() {
      missingPerson = args;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("Missing Person Details"),
      body: missingPerson == null
          ? Center(
              child: Text(
                'Profile not available',
                style: TextStyle(
                  fontSize: 20.sp,
                  color: AppColors.secondaryColor,
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Profile Image Section
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: CircleAvatar(
                      radius: 60.r,
                      backgroundImage: NetworkImage(
                          '${AppConstant.UPLOAD_BASE_URL}/post/${missingPerson!.postImages[0]}'),
                    ),
                  ),
                  Text(
                    "${missingPerson!.firstName} ${missingPerson!.middleName} ${missingPerson!.lastName}",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // Details Section
                  _buildSectionHeader('Details'),
                  _buildDetailRow(Icons.cake, 'Age',
                      calculateAge(missingPerson!.dateOfBirth!).toString()),
                  _buildDetailRow(Icons.location_on, 'Last Known Location',
                      missingPerson!.lastSeenLocation),
                  _buildDetailRow(Icons.calendar_today, 'Date of Disappearance',
                      formatDate(missingPerson!.lastSeenDate)),
                  _buildDetailRow(Icons.description, 'Description',
                      missingPerson!.description),

                  // Additional Attributes
                  _buildSectionHeader('Physical Attributes'),
                  _buildDetailRow(
                      Icons.flag, 'Nationality', missingPerson!.nationality),
                  _buildDetailRow(
                      Icons.person, 'Gender', missingPerson!.gender),
                  _buildDetailRow(Icons.language, 'Languages Spoken',
                      missingPerson!.languageSpoken),
                  _buildDetailRow(Icons.color_lens, 'Skin Color',
                      missingPerson!.skinColor!),
                  _buildDetailRow(
                      Icons.brush, 'Hair Color', missingPerson!.hairColor!),

                  // Disabilities and Medical Issues
                  _buildSectionHeader('Health Information'),
                  _buildDetailRow(
                      Icons.wheelchair_pickup,
                      'Physical Disabilities',
                      missingPerson!.physicalDisability.join(", ")),
                  _buildDetailRow(
                      Icons.health_and_safety,
                      'Mental Disabilities',
                      missingPerson!.mentalDisability.join(", ")),
                  _buildDetailRow(Icons.medical_services, 'Medical Issues',
                      missingPerson!.medicalIssues.join(", ")),

                  // Photos
                  _buildSectionHeader('Photos'),
                  _buildPhotosGrid(),

                  // Contact Button
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            WidgetStateProperty.all(AppColors.accentColor),
                        padding: WidgetStateProperty.all(EdgeInsets.symmetric(
                            horizontal: 40.w, vertical: 12.h)),
                      ),
                      onPressed: () => _showContactOptions(context),
                      child: Text(
                        'Contact',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.primaryBackground,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  // Section Header Widget
  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.sp,
            color: AppColors.secondaryColor,
          ),
        ),
      ),
    );
  }

  // Detail Row Widget
  Widget _buildDetailRow(IconData icon, String title, String detail) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
      child: Row(
        children: [
          Icon(icon, color: AppColors.secondaryColor),
          SizedBox(width: 10.w),
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          ),
          Expanded(
            child: Text(detail),
          ),
        ],
      ),
    );
  }

  // Photos Grid Widget
  Widget _buildPhotosGrid() {
    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
        ),
        itemCount: missingPerson!.postImages.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: NetworkImage(
                    '${AppConstant.UPLOAD_BASE_URL}/post/${missingPerson!.postImages[index]}'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  // Contact Options Dialog
  void _showContactOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contact Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Call'),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                onTap: () => Navigator.of(context).pop(),
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Message'),
                onTap: () => Navigator.of(context).pop(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
