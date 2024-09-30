// import 'package:afalagi/bloc/create_profile/create_profile_state.dart';
import 'dart:io';

import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/features/post/domain/entities/missing_person_entity.dart';
import 'package:afalagi/core/resources/shared_event.dart';
import 'package:afalagi/core/util/controller/enum_utility.dart';
import 'package:afalagi/core/util/controller/enums.dart';
import 'package:afalagi/core/util/controller/sign_up_controller.dart';
import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/build_textfield.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/flutter_toast.dart';
import 'package:afalagi/features/post/presentation/views/report_screen/widgets/build_disability.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class FormPageTwoWidget extends StatefulWidget {
  const FormPageTwoWidget({super.key});

  @override
  State<FormPageTwoWidget> createState() => _FormPageTwoWidgetState();
}

class _FormPageTwoWidgetState extends State<FormPageTwoWidget> {
  int index = 0;
  final formKey = GlobalKey<FormState>();

  final SignUpController _signUpController = SignUpController();

  final TextEditingController physicalDisabilityController =
      TextEditingController();
  final TextEditingController mentalDisabilityController =
      TextEditingController();
  final TextEditingController medicalIssuesController = TextEditingController();

  final TextEditingController recongizableFeatureController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late ReportFormBloc _reportFormBloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //   final UserRepository repository = UserRepository();
    _reportFormBloc = BlocProvider.of<ReportFormBloc>(context);
    // _createProfileBloc = CreateProfileBloc(widget.userRepository);
  }

  void _handleMissingPost() {
    var bloc = _reportFormBloc.state;
    print(bloc.firstName);
    print(bloc.maritalStatus!.name.toUpperCase());
    print(bloc.posterRelation!.name.toUpperCase());
    print(bloc.dateOfBirth);

    print(bloc.middleName);

    print(bloc.lastName);

    print(bloc.description);
//..
    print(bloc.country);

    print(bloc.dateOfDisappearance);

    print(bloc.languageSpoken);

//..

    print(bloc.nationality);
    print(bloc.postImages!.path);
    print(bloc.hairColor!.name.toUpperCase());
    print(bloc.legalDocuments!.map((value) => value.path).toList());
    print(bloc.recognizableFeature);
    print(bloc.legalDocuments!.map((value) => value.path).toList()[0]);
    print(bloc.recognizableFeature);

    final missingPerson = MissingPersonEntity(
        maritalStatus: bloc.maritalStatus!.name.toUpperCase(),
        posterRelation: bloc.posterRelation!.name.toUpperCase(),
        dateOfBirth: bloc.dateOfBirth,
        firstName: bloc.firstName,
        middleName: bloc.middleName,
        lastName: bloc.lastName,
        description: bloc.description,
        lastSeenLocation: bloc.country,
        lastSeenDate: bloc.dateOfDisappearance,
        languageSpoken: bloc.languageSpoken ?? 'Amharic',
        nationality: bloc.nationality,
        hairColor: bloc.hairColor?.name.toUpperCase(),
        skinColor: bloc.skinColor?.name.toUpperCase(),
        recognizableFeatures: bloc.recognizableFeature,
        physicalDisability: bloc.selectedPhysicalDisability
            .map((value) => value.name.toUpperCase())
            .toList(),
        otherPhysicalDisability: bloc.otherPhysicalDisability ?? '',
        mentalDisability: bloc.selectedMentalDisability
            .map((value) => value.name.toUpperCase())
            .toList(),
        otherMentalDisability: bloc.otherMentalDisability ?? '',
        medicalIssues: bloc.selectedMedicalIssues
            .map((value) => value.name.toUpperCase())
            .toList(),
        otherMedicalIssue: bloc.otherMedicalIssues ?? '',
        gender: bloc.gender!.name.toUpperCase(),
        educationalLevel: bloc.educationalLevel!.name.toUpperCase(),

// Testing... The state of the post Images and legalDocs are a type of XFile? does it matter

        postImages: [bloc.postImages!.path] ?? [],
        legalDocs: bloc.legalDocuments!.map((value) => value.path!).toList());

    print(missingPerson);
    // final postImages = _bloc.postImages;
    // final legalDocs = _bloc.legalDocuments;
    // final videoMessage = _bloc
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
    return SingleChildScrollView(
      child: BlocBuilder<ReportFormBloc, ReportFormState>(
        builder: (context, state) {
          String? selectedEducation = state.educationalLevel != null
              ? educationalLevelToString(state.educationalLevel!)
              : "";
          String? selectedPosterRelation = state.posterRelation != null
              ? posterRelationToString(state.posterRelation!)
              : "";

          String? selectedMarital = state.maritalStatus != null
              ? maritalStatusToString(state.maritalStatus!)
              : "";
          late bool isDocSelected = false;

          return Form(
            key: formKey,
            child: Container(
              alignment: Alignment.center,

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16.0),
              // padding: EdgeInsets.all(15.w),
              margin: EdgeInsets.all(15.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableText("Recongnizable Feature:"),
                  formField(
                      fieldName: "recongizableFeature",
                      value: state.recognizableFeature,
                      controller: recongizableFeatureController,
                      hintText: "Enter the recongnizable feature",
                      prefixIcon: const Icon(Icons.person),
                      inputType: TextInputType.name,
                      func: (value) {
                        _reportFormBloc
                            .add(ReportFormEvent(onRecognizableFeature: value));
                      },
                      formType: "report form",
                      context: context),
                  const SizedBox(height: 15.0),
                  reusableText("Medical Issues:"),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: buildDisabilityTextFormField(
                          disabilityType: "medical",
                          context: context,
                          controller: medicalIssuesController,
                          disabilities: MedicalIssues.values,
                          hintText: "Select Medical Issues")),
                  const SizedBox(height: 15.0),
                  reusableText("Physical Disability:"),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: buildDisabilityTextFormField(
                          disabilityType: "physical",
                          context: context,
                          controller: physicalDisabilityController,
                          disabilities: PhysicalDisability.values,
                          hintText: "Select Physical Disability")),
                  const SizedBox(height: 15.0),
                  reusableText("Mental Disability:"),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: buildDisabilityTextFormField(
                          disabilityType: "mental",
                          context: context,
                          controller: mentalDisabilityController,
                          disabilities: MentalDisability.values,
                          hintText: "Select Mental Disability")),
                  const SizedBox(height: 15.0),
                  reusableText("Description:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: formField(
                        fieldName: "description",
                        value: state.description,
                        controller: descriptionController,
                        hintText: "Enter description",
                        prefixIcon: const Icon(Icons.description),
                        inputType: TextInputType.multiline,
                        func: (value) {
                          context
                              .read<ReportFormBloc>()
                              .add(ReportFormEvent(onDescription: value));
                        },
                        formType: "report form",
                        context: context),
                  ),
                  reusableText("Marital Status:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: dropDownField(
                        selected: selectedMarital,
                        dropDown: MaritalStatus.values,
                        context: context,
                        hintText: "Select Marital Status",
                        keyName: "maritalStatus"),
                  ),
                  const SizedBox(height: 15.0),
                  reusableText("Educational Level:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: dropDownField(
                        selected: selectedEducation,
                        dropDown: EducationalLevel.values,
                        context: context,
                        hintText: "Select educational level",
                        keyName: 'educationalLevel'),
                  ),
                  reusableText("Poster Relation:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: dropDownField(
                        selected: selectedPosterRelation,
                        dropDown: PosterRelation.values,
                        context: context,
                        hintText: "Select Poster Relation",
                        keyName: 'posterRelation'),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  reusableText("Video Message:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: formField(
                        fieldName: "videoMessage",
                        value: state.videoLink,
                        controller: _signUpController.videoLinkController,
                        hintText: "Enter any video link if you have a message",
                        prefixIcon: const Icon(Icons.link),
                        inputType: TextInputType.text,
                        func: (value) {
                          context
                              .read<ReportFormBloc>()
                              .add(ReportFormEvent(onVideoLink: value));
                        },
                        formType: "report form",
                        context: context),
                  ),
                  reusableText("Upload Photo"),
                  BlocBuilder<ReportFormBloc, ReportFormState>(
                    builder: (context, state) {
                      // Check if the state is null
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildInitialInput(context),
                          if (state.imagePickState ==
                              MissignImagePickState.picked)
                            buildImagePreview(
                                state.postImages!, "missingImage"),
                          if (state.imagePickState ==
                              MissignImagePickState.failed)
                            buildFailedInput(
                                context, state.errorImage, 'imageError')
                          // the image is as for debugging not actual image
                        ],
                      );
                    },
                  ),
                  reusableText("Legal Document"),
                  BlocBuilder<ReportFormBloc, ReportFormState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            // File path display
                            Container(
                              color: AppColors.cardColor,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      readOnly: true,
                                      decoration: InputDecoration(
                                        hintText: 'Choose Legal Documents',
                                        suffixIcon: IconButton(
                                            icon: const Icon(Icons.attach_file),
                                            onPressed: () async {
                                              _reportFormBloc
                                                  .add(PickDocument());
                                              setState(() {
                                                isDocSelected = true;
                                              });
                                            }),
                                      ),
                                    ),
                                  ),
                                  if (isDocSelected)
                                    Expanded(
                                        child: ListView.builder(
                                            itemCount:
                                                state.legalDocuments?.length ??
                                                    0,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(state
                                                    .legalDocuments![index]
                                                    .name),
                                                subtitle: Text(state
                                                    .legalDocuments![index].size
                                                    .toString()),
                                              );
                                            })),
                                  if (state.docPickState ==
                                      MissingDocPickState.failed)
                                    buildFailedInput(
                                        context, state.errorDoc, 'docError')
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            // ElevatedButton.icon(
                            //   onPressed: () => context.read<UploadCubit>(),
                            //   icon: const Icon(Icons.upload_file),
                            //   label: const Text('Upload'),
                            // ),
                            const SizedBox(height: 16),
                            // if (state.status == UploadStatus.loading)
                            //   const CircularProgressIndicator(),
                            // if (state.status == UploadStatus.success)
                            //   const Text('Upload successful!'),
                            // if (state.status == UploadStatus.error)
                            //   const Text('Upload failed!'),
                          ],
                        ),
                      );
                    },
                  ),

                  // SizedBox(height: 16),
                  // if (state.status == UploadStatus.loading)
                  //   CircularProgressIndicator(),
                  // if (state.status == UploadStatus.success)
                  //   Text('Upload successful!'),
                  // if (state.status == UploadStatus.error)
                  //   // Text('Upload failed!'),

                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pageViewButton(
                          context: context,
                          index: index,
                          buttonName: "Back",
                          formKey: formKey),
                      ElevatedButton(
                        onPressed: () {
                          _handleMissingPost();
                        },
                        child: const Text("Report"),
                      )
                      // pageViewButton(
                      //     context: context,
                      //     index: 2,
                      //     buttonName: "Report",
                      //     formKey: formKey,
                      //     func: () => _handleMissingPost)
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildInitialInputDoc() {
    return Expanded(
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
          hintText: 'Choose Legal Documents',
          suffixIcon: IconButton(
              icon: const Icon(Icons.attach_file),
              onPressed: () async {
                context.read<ReportFormBloc>().add(PickDocument());
              }),
        ),
      ),
    );
  }

  Widget buildDocPreview(List<PlatformFile>? files) {
    print(files?.length);
    return Expanded(
        child: ListView.builder(
            itemCount: files?.length ?? 0,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(files![index].name),
                subtitle: Text(files[index].size.toString()),
              );
            }));
  }

  Widget buildInitialInput(BuildContext context) {
    print("Image Pick Initial State");
    return Center(
      child: Column(
        children: [
          Container(
            color: AppColors.cardColor,
            child: Center(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      _reportFormBloc.add(PickImage());
                    },
                    icon: const Icon(
                      Icons.upload,
                      weight: 10,
                    ),
                  ),
                  const Text(
                    "Upload a Photo",
                    style: TextStyle(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImagePreview(XFile image, String imageType) {
    print("ImagePreview");
    bool isPressed = false;
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.24,
            child: Center(
              child: Column(children: [
                imageType == 'missingImage'
                    ? Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            image: DecorationImage(
                                image: FileImage(File(image.path)))),
                      )
                    : MyTextField(
                        controller: TextEditingController(text: image.name),
                        hintText: "",
                        obscureText: false,
                        keyboardType: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    isPressed == false
                        ? ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.accentColor)),
                            onPressed: () {
                              isPressed = true;
                              imageType == "profile"
                                  ? toastInfo(msg: "Profile setted succesfully")
                                  : toastInfo(
                                      msg: "Missing image setted succesfully");
                            },
                            child: const Text(
                              "Set",
                              style: TextStyle(
                                color: AppColors.primaryBackground,
                              ),
                            ),
                          )
                        : Container(),
                    ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(AppColors.accentColor)),
                        onPressed: () {
                          _reportFormBloc.add(PickImage());
                        },
                        child: const Text(
                          "Change",
                          style: TextStyle(
                            color: AppColors.primaryBackground,
                          ),
                        ))
                  ],
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildFailedInput(
      BuildContext context, String? errorMsg, String? errorType) {
    print(errorMsg);
    return Column(
      children: [
        Text(errorMsg ?? 'Unknown error'),
        ElevatedButton(
          style: const ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.accentColor)),
          onPressed: () {
            errorMsg == 'imageError'
                ? _reportFormBloc.add(PickImage())
                : _reportFormBloc.add(PickDocument());
          },
          child: const Text(
            'Retry',
            style: TextStyle(
              color: AppColors.primaryBackground,
            ),
          ),
        ),
      ],
    );
  }
}
