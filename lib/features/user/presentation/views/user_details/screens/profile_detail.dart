import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/features/post/domain/entities/missing_person_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetail extends StatefulWidget {
  final MissingPersonEntity? missingPerson;
  const ProfileDetail({super.key, this.missingPerson});

  @override
  State<ProfileDetail> createState() => _ProfileDetailState();
}

class _ProfileDetailState extends State<ProfileDetail> {
  late MissingPersonEntity? missingPerson;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Extract the passed argument
    final args =
        ModalRoute.of(context)?.settings.arguments as MissingPersonEntity?;
    setState(() {
      missingPerson = args; // Assign to a local variable
    });
  }

  @override
  Widget build(BuildContext context) {
    // Check if missingPerson or user or profile is null
    // final missingPerson = widget.missingPerson;
    final user = missingPerson?.user;
    final profile = user?.profile;
    print(user);
    // Handle cases where the profile is null
    if (profile == null) {
      return Scaffold(
        appBar: buildAppBarLarge("Profile Details"),
        body: Center(
          child: Text(
            'Profile not available',
            style: TextStyle(
              fontSize: 20.sp,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      );
    }

    final profilePictureUrl =
        '${AppConstant.UPLOAD_BASE_URL}/profile/${profile.profilePicture}';

    return Scaffold(
      appBar: buildAppBarLarge("Profile Details"),
      body: BlocBuilder<PostsCubit, GenericState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile picture
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: CircleAvatar(
                    radius: 60.r,
                    backgroundImage: NetworkImage(profilePictureUrl),
                  ),
                ),
                // User name
                Text(
                  "${profile.firstName} ${profile.middleName} ${profile.lastName}",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
                ),
                // User details
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow(Icons.person, 'Name',
                          "${profile.firstName} ${profile.middleName} ${profile.lastName}"),
                      _buildDetailRow(
                          Icons.phone, 'Contact', profile.phoneNumber ?? ''),
                      _buildDetailRow(Icons.email, 'Email', user?.email ?? ''),
                    ],
                  ),
                ),
                // Send Message button
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          const WidgetStatePropertyAll(AppColors.accentColor),
                      padding: WidgetStatePropertyAll(EdgeInsets.symmetric(
                          horizontal: 40.w, vertical: 12.h)),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AppRoutes.CHAT_PAGE);
                      _sendMessage(context);
                    },
                    child: Text(
                      'Send Message',
                      style: TextStyle(
                          fontSize: 16.sp, color: AppColors.primaryBackground),
                    ),
                  ),
                ),
                // Description
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
                  child: Text(
                    missingPerson?.description ?? 'No description available',
                    style: TextStyle(
                        fontSize: 16.sp, color: AppColors.primarySecondaryText),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String title, String detail) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
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

  void _sendMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Message'),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Type your message here',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            maxLines: 5,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // handle send message action
                Navigator.of(context).pop();
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }
}
