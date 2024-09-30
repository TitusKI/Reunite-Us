// ignore_for_file: unused_field

import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_bloc.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_event.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_state.dart';
import 'package:afalagi/config/routes/routes.dart';

import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/common_widgets.dart';
import 'package:afalagi/features/post/presentation/views/report_screen/widgets/form_page_one_widget.dart';
import 'package:afalagi/features/post/presentation/views/report_screen/widgets/form_page_two_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../domain/entities/missing_person_entity.dart';

PageController _pageController = PageController(initialPage: 0);

// ignore: must_be_immutable
class AddReport extends StatefulWidget {
  const AddReport({super.key});

  @override
  State<AddReport> createState() => _AddReportState();
}

class _AddReportState extends State<AddReport> {
  late ReportFormBloc _reportFormBloc;

  @override
  // void initState() {
  //   super.initState();
  //   _reportFormBloc = context.read<ReportFormBloc>();
  // }
  void didChangeDependencies() {
    super.didChangeDependencies();
    //   final UserRepository repository = UserRepository();
    _reportFormBloc = BlocProvider.of<ReportFormBloc>(context);
    // _createProfileBloc = CreateProfileBloc(widget.userRepository);
  }

  // @override
  // void dispose() {
  //   _reportFormBloc.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryBackground,
        appBar: buildAppBarLarge("Report Missing Person"),
        body: BlocListener<ReportFormBloc, ReportFormState>(
          listener: (context, state) {
            if (state.isMissingSuccess!) {
              print("Successfuly post missing");
              Navigator.of(context).pushNamedAndRemoveUntil(
                  AppRoutes.MAIN, (Route<dynamic> route) => false);
            }
            if (state.missingFailure != null) {
              print("ERROR ON CREATING POST${state.missingFailure}");
            }
          },
          child: BlocBuilder<ReportFormBloc, ReportFormState>(
            builder: (context, state) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (index) {
                      state.page = index;
                      context
                          .read<ReportFormBloc>()
                          .add(const ReportFormEvent());
                    },
                    children: const [FormPageOneWidget(), FormPageTwoWidget()],
                  ),
                ],
              );
            },
          ),
        ));
  }

  void handleMissingPost() {
    BlocBuilder<ReportFormBloc, ReportFormState>(
      builder: (context, state) {
        final missingPerson = MissingPersonEntity(
            maritalStatus: state.maritalStatus.toString(),
            posterRelation: state.posterRelation!.toString(),
            dateOfBirth: state.dateOfBirth,
            firstName: state.firstName,
            middleName: state.middleName,
            lastName: state.lastName,
            description: state.description,
            lastSeenLocation: state.location,
            lastSeenDate: state.dateOfDisappearance,
            languageSpoken: state.languageSpoken!,
            nationality: state.nationality,
            hairColor: state.hairColor!.toString(),
            skinColor: state.skinColor!.toString(),
            recognizableFeatures: state.recognizableFeature,
            physicalDisability:
                state.selectedPhysicalDisability as List<String>,
            otherPhysicalDisability: state.otherPhysicalDisability,
            mentalDisability: state.selectedMentalDisability as List<String>,
            otherMentalDisability: state.otherMentalDisability,
            medicalIssues: state.selectedMedicalIssues as List<String>,
            otherMedicalIssue: state.otherMedicalIssues,
            gender: state.gender!.toString(),
            educationalLevel: state.educationalLevel!.toString(),

            // Testing... The state of the post Images and legalDocs are a type of XFile? does it matter

            postImages: [state.postImages!.path],
            legalDocs:
                state.legalDocuments!.map((value) => value.path!).toList());
        context
            .read<ReportFormBloc>()
            .add(MissingPersonPost(missingPerson: missingPerson));

        if (state.isMissingLoading!) {
          const CircularProgressIndicator();
        }
        if (state.missingFailure != null) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.missingFailure!)));
        }
        if (state.isMissingSuccess!) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Report Submitted Successfully')));
        }
        return Container();
      },
    );
  }
}

ElevatedButton pageViewButton(
    {required BuildContext context,
    required int index,
    required String buttonName,
    required formKey,
    void Function()? func}) {
  return ElevatedButton(
    style: ButtonStyle(
        alignment: Alignment.centerRight,
        backgroundColor: WidgetStateProperty.all(AppColors.accentColor)),
    onPressed: () {
      print('Button Pressed');
      if (index == 1) {
        // if (formKey.currentState!.validate()) {
        // formKey.currentState!.save();
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        // }
      } else if (index == 0) {
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      } else {
        print("Report pressed");
        if (formKey.currentState!.validate()) {
          // formKey.currentState!.save();
          func!();
        }
      }
    },
    child: Text(
      buttonName,
      style: TextStyle(
        color: AppColors.primaryBackground,
        fontSize: 18.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
