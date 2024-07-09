import 'dart:io';

import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'report_form_event.dart';
part 'report_form_state.dart';

class ReportFormBloc extends Bloc<SharedEvent, ReportFormState> {
  final ImagePicker _picker = ImagePicker();
  ReportFormBloc() : super(ReportFormState()) {
    on<ReportFormEvent>(_reportFormEvent);
    on<NameChangedEvent>(_nameChangedEvent);
    on<GenderEvent>((event, emit) {
      emit(state.copyWith(selected: event.gender));
    });
    on<PickImage>(_pickImageEvent);
    on<LocationEvent>(_locationEvent);
    on<DateEvent>(_dateOfBirthEvent);
  }
  void _reportFormEvent(ReportFormEvent event, Emitter<ReportFormState> emit) {
    emit(state.copyWith(
      page: state.page,
      age: event.onAge,
      height: event.onHeight,
      hairColor: event.onHairColor,
      skinColor: event.onSkinColor,
      description: event.onDescription,
      recongnizableFeature: event.onRecongnizableFeature,
      educationalLevel: event.onEducationalLevel,
      videoLink: event.onVideoLink,
      hasMentalDisability: event.hasMentalDisability,
      hasPhysicalDisability: event.hasPhysicalDisability,
    ));
  }

  void _nameChangedEvent(
      NameChangedEvent event, Emitter<ReportFormState> emit) {
    emit(state.copyWith(
      fullName: event.fullName,
    ));
  }

  Stream<SignUpStates> _locationEvent(
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
    emit(state.copyWith(dateOfDisapperance: event.dateOfDisapperance));
  }

  Future<void> _pickImageEvent(
      PickImage event, Emitter<ReportFormState> emit) async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        emit(
          state.copyWith(
              profileImage: File(
                pickedFile.path,
              ),
              imagePickState: ImagePickState.picked),
        );
      } else {
        emit(
          state.copyWith(
            imagePickState: ImagePickState.failed,
            errorImage: "No image selected",
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          imagePickState: ImagePickState.failed,
          errorImage: e.toString(),
        ),
      );
    }
  }
}
