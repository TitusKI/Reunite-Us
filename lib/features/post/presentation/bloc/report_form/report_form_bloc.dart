import 'package:afalagi/features/post/domain/usecases/create_post.dart';
import 'package:afalagi/injection_container.dart';
import 'package:afalagi/features/user/presentation/bloc/create_profile/create_profile_state.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_event.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_state.dart';
import 'package:afalagi/core/resources/shared_event.dart';
import 'package:afalagi/core/util/controller/enums.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';
// Ensure this imports your enums

class ReportFormBloc extends Bloc<SharedEvent, ReportFormState> {
  final ImagePicker _picker = ImagePicker();

  ReportFormBloc() : super(ReportFormState()) {
    on<ReportFormEvent>(_reportFormEvent);
    on<NameChangedEvent>(_nameChangedEvent);

    on<PickImage>(_pickImageEvent);
    on<LocationEvent>(_locationEvent);
    on<DateEvent>(_dateOfBirthEvent);
    on<MissingPersonPost>(_missingPersonPost);
  }

  Future<void> _missingPersonPost(
      MissingPersonPost event, Emitter<ReportFormState> emit) async {
    emit(state.copyWith(isMissingLoading: true));

    try {
      // await sl<PostRepository>().createPost(
      //     missingPerson: event.missingPerson,
      //     legalDocs: event.legalDocs,
      //     postImages: event.postImages,
      //     videoMessage: event.videoMessage);
      await sl<CreatePostUsecase>().call(parms: event.missingPerson);
      // On successful Profile-creation, update the state
      emit(state.copyWith(
        //  user: event.user, // Use the user returned from the repository
        isMissingLoading: false,
        isMissingSuccess: true, // Set to true on success
        missingFailure: '', // Clear any previous failure message
      ));
    } catch (e) {
      emit(state.copyWith(
        isMissingLoading: false,
        isMissingSuccess: false,
        missingFailure: e.toString(),
      ));
    }
  }

  void _reportFormEvent(
    ReportFormEvent event,
    Emitter<ReportFormState> emit,
  ) async {
    emit(state.copyWith(
      age: event.onAge,
      height: event.onHeight,
      hairColor: event.onHairColor,
      skinColor: event.onSkinColor,
      description: event.onDescription,
      educationalLevel: event.onEducationalLevel,
      videoLink: event.onVideoLink,
      selected: event.selected,
      maritalStatus: event.onMaritalStatus,
      gender: event.onGender,
    ));

    // Update physical disabilities
    List<PhysicalDisability> updatedPhysicalDisabilities = _updateDisabilities(
      state.selectedPhysicalDisability,
      event.physicalDisability,
      event.otherPhysicalDisability,
    );
    emit(state.copyWith(
      selectedPhysicalDisability: updatedPhysicalDisabilities,
      otherPhysicalDisability:
          event.otherPhysicalDisability ?? state.otherPhysicalDisability,
    ));

    // Update mental disabilities
    List<MentalDisability> updatedMentalDisabilities = _updateDisabilities(
      state.selectedMentalDisability,
      event.mentalDisability,
      event.otherMentalDisability,
    );
    emit(state.copyWith(
      selectedMentalDisability: updatedMentalDisabilities,
      otherMentalDisability:
          event.otherMentalDisability ?? state.otherMentalDisability,
    ));

    // Update medical issues
    List<MedicalIssues> updatedMedicalIssues = _updateDisabilities(
      state.selectedMedicalIssues,
      event.medicalIssues,
      event.otherMedicalIssues,
    );
    emit(state.copyWith(
      selectedMedicalIssues: updatedMedicalIssues,
      otherMedicalIssues: event.otherMedicalIssues ?? state.otherMedicalIssues,
    ));
  }

  List<T> _updateDisabilities<T>(
    List<T> currentDisabilities,
    T? newDisability,
    String? otherDisability,
  ) {
    List<T> updatedDisabilities = List.from(currentDisabilities);

    if (newDisability == null) {
      return updatedDisabilities;
    }

    if (newDisability == 'None') {
      updatedDisabilities = [newDisability];
    } else if (newDisability == 'Other') {
      if (updatedDisabilities.contains('Other')) {
        updatedDisabilities.remove('Other');
        updatedDisabilities.add(otherDisability! as T);
      } else {
        updatedDisabilities.add(newDisability);
      }
    } else {
      if (updatedDisabilities.contains('None')) {
        updatedDisabilities.remove('None');
      }
      if (updatedDisabilities.contains(newDisability)) {
        updatedDisabilities.remove(newDisability);
      } else {
        updatedDisabilities.add(newDisability);
      }
    }

    return updatedDisabilities;
  }

  void _nameChangedEvent(
      NameChangedEvent event, Emitter<ReportFormState> emit) {
    emit(state.copyWith(
      firstName: event.firstName,
      middleName: event.middleName,
      lastName: event.lastName,
    ));
  }

  Stream<CreateProfileState> _locationEvent(
      LocationEvent event, Emitter<ReportFormState> emit) async* {
    emit(
      state.copyWith(
        country: event.country,
        state: event.state,
        city: event.city,
      ),
    );
    print("My Country: ${state.country}");
  }

  void _dateOfBirthEvent(DateEvent event, Emitter<ReportFormState> emit) {
    emit(state.copyWith(
        dateOfDisappearance: event.dateOfDisapperance,
        dateOfBirth: event.dateOfBirth));
  }

  Future<void> _pickImageEvent(
      PickImage event, Emitter<ReportFormState> emit) async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(
          state.copyWith(
              postImages: XFile(
                pickedFile.path,
              ),
              imagePickState: MissignImagePickState.picked),
        );
      } else {
        emit(
          state.copyWith(
            imagePickState: MissignImagePickState.failed,
            errorImage: "No image selected",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          imagePickState: MissignImagePickState.failed,
          errorImage: e.toString(),
        ),
      );
    }
  }
}
