import 'package:afalagi/routes/names.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0.w),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Start typing a name',
                  hintStyle:
                      const TextStyle(color: AppColors.primarySecondaryText),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: AppColors.secondaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Found Persons',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: AppColors.secondaryColor),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward,
                      color: AppColors.accentColor,
                    ),
                    onPressed: () {
                      // Navigator.of(context).pushNamed(AppRoutes.FOUND);
                      // handle navigation to all found persons
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 185.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3, // replace with the actual number of found persons
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(8.0.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w,
                          height: 100.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/temp/foundChild.jpg'), // replace with actual image path
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        SizedBox(
                          width: 90.w,
                          child: Text(
                            'Rita Afework Abebe ',
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.secondaryColor),
                          ),
                        ), // replace with actual name
                      ],
                    ),
                  );
                },
              ),
            ),
            Divider(
              color: AppColors.secondaryColor,
              endIndent: 8.0.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Missing Persons',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                      color: AppColors.secondaryColor),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0.w),
              child: GridView.builder(
                physics:
                    const NeverScrollableScrollPhysics(), // to prevent GridView from scrolling
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 0.7.dg,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 10.h,
                ),
                itemCount:
                    6, // replace with the actual number of missing persons
                itemBuilder: (context, index) {
                  return Card(
                    clipBehavior: Clip.hardEdge,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.r),
                          topRight: Radius.circular(15.r)),
                    ),
                    elevation: 5.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(AppRoutes.PROFILE_DETAIL);
                            },
                            child: const CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/temp/foundMan.jpg'), // replace with actual image path
                            ),
                          ),
                          title: Text(
                            'Leulseged Lema',
                            style: TextStyle(fontSize: 12.sp),
                          ), // replace with actual user name
                        ),
                        Container(
                          width: double.infinity,
                          height: 200.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(15.r),
                              topRight: Radius.circular(15.r),
                            ),
                            image: const DecorationImage(
                              image: AssetImage(
                                  'assets/temp/missingWoman.jpg'), // replace with actual image path
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: const Text(
                            'Lielt Leulseged Lema',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.secondaryColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            'Age: 21\nLast known: Bole Airport\nDate: 10 June 2014',
                            style: TextStyle(color: AppColors.secondaryColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.all(8.0.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        AppColors.accentColor),
                                    foregroundColor: WidgetStatePropertyAll(
                                        AppColors.primaryBackground)),
                                child: const Text(
                                  'View Details',
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.MISSING_DETAIL);
                                  // handle view details action
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            TextButton(
              style: const ButtonStyle(
                  foregroundColor:
                      WidgetStatePropertyAll(AppColors.accentColor)),
              child: const Text('See More'),
              onPressed: () {
                // handle see more action
              },
            ),
          ],
        ),
      ),
    );
  }
}
