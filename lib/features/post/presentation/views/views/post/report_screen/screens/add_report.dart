// ignore_for_file: unused_field

import 'package:afalagi/features/post/domain/entities/missing_person_entity.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_bloc.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_event.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_state.dart';
import 'package:afalagi/config/routes/routes.dart';

import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/features/post/presentation/views/report_screen/widgets/form_page_two_widget.dart';
import 'package:afalagi/features/post/presentation/views/views/common/widgets/common_widgets.dart';
import 'package:afalagi/features/post/presentation/views/views/post/report_screen/widgets/form_page_one_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  void _handleMissingPost() {
    final missingPerson = MissingPersonEntity(
        maritalStatus: _reportFormBloc.state.maritalStatus.toString(),
        posterRelation: _reportFormBloc.state.posterRelation!.toString(),
        dateOfBirth: _reportFormBloc.state.dateOfBirth,
        firstName: _reportFormBloc.state.firstName,
        middleName: _reportFormBloc.state.middleName,
        lastName: _reportFormBloc.state.lastName,
        description: _reportFormBloc.state.description,
        lastSeenLocation: _reportFormBloc.state.location,
        lastSeenDate: _reportFormBloc.state.dateOfDisappearance,
        languageSpoken: _reportFormBloc.state.languageSpoken!,
        nationality: _reportFormBloc.state.nationality,
        hairColor: _reportFormBloc.state.hairColor!.toString(),
        skinColor: _reportFormBloc.state.skinColor!.toString(),
        recognizableFeatures: _reportFormBloc.state.recognizableFeature,
        physicalDisability:
            _reportFormBloc.state.selectedPhysicalDisability as List<String>,
        otherPhysicalDisability: _reportFormBloc.state.otherPhysicalDisability,
        mentalDisability:
            _reportFormBloc.state.selectedMentalDisability as List<String>,
        otherMentalDisability: _reportFormBloc.state.otherMentalDisability,
        medicalIssues:
            _reportFormBloc.state.selectedMedicalIssues as List<String>,
        otherMedicalIssue: _reportFormBloc.state.otherMedicalIssues,
        gender: _reportFormBloc.state.gender!.toString(),
        educationalLevel: _reportFormBloc.state.educationalLevel!.toString(),

// Testing... The state of the post Images and legalDocs are a type of XFile? does it matter

        postImages: [_reportFormBloc.state.postImages!.path],
        legalDocs: [_reportFormBloc.state.legalDocuments!.path]);
    // final postImages = _reportFormBloc.state.postImages;
    // final legalDocs = _reportFormBloc.state.legalDocuments;
    // final videoMessage = _reportFormBloc.state
    _reportFormBloc.add(MissingPersonPost(
      missingPerson: missingPerson,
      // postImages: postImages!,
      // legalDocs: legalDocs!,
    ));
    // _createProfileBloc
    //     .add(ProfileSubmitEvent(userProfile: userProfile, file: file!));
  }

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
}

ElevatedButton pageViewButton(
    {required BuildContext context,
    required int index,
    required String buttonName,
    required formKey,
    void Function()? func}) {
  func = func;
  return ElevatedButton(
    style: ButtonStyle(
        alignment: Alignment.centerRight,
        backgroundColor: WidgetStateProperty.all(AppColors.accentColor)),
    onPressed: () {
      if (index == 1) {
        // if (formKey.currentState!.validate()) {
        //   formKey.currentState!.save();
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        // }
      } else if (index == 0) {
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      } else {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          final state = context.read<ReportFormBloc>().state;
          state.isMissingLoading! ? const CircularProgressIndicator() : func!;

          // Navigator.of(context).pushNamedAndRemoveUntil(
          //     AppRoutes.SIGN_IN, (Route<dynamic> route) => false);
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
