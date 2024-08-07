import 'dart:io';
import 'package:afalagi/domain/entities/profile_enitity.dart';
import 'package:afalagi/domain/usecases/user/build_user_profile.dart';
import 'package:afalagi/injection_container.dart';
import 'package:afalagi/presentation/bloc/user/profile/create_profile/create_profile_event.dart';
import 'package:afalagi/presentation/bloc/user/profile/create_profile/create_profile_state.dart';
import 'package:afalagi/presentation/bloc/shared_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreateProfileBloc extends Bloc<SharedEvent, CreateProfileState> {
  final ImagePicker _picker = ImagePicker();

  @override
  CreateProfileBloc() : super(CreateProfileState.initial()) {
    on<NameChangedEvent>(_nameChangedEvent);

    on<GenderEvent>((event, emit) {
      emit(state.copyWith(selected: event.gender));
    });
    on<PhoneNoChanged>(_phoneNumberEvent);
    on<PhoneNoValidationChanged>(_phoneNoValidationChanged);
    // on<DateEvent>(_dateOfBirthEvent);
    on<PickImage>(_pickImageEvent);
    on<LocationEvent>(_locationEvent);
    on<DateEvent>(_dateOfBirthEvent);

    on<ProfileReset>((event, emit) => emit(CreateProfileState.initial()));
    on<ProfileSubmitEvent>(_profileSubmitEvent);
  }
  Future<void> _profileSubmitEvent(
      ProfileSubmitEvent event, Emitter<CreateProfileState> emit) async {
    emit(state.copyWith(isProfileLoading: true));

    try {
      await sl<BuildUserProfileUsecase>().call(
          parms:
              ProfileEnitity(userProfile: event.userProfile, file: event.file));
      // On successful Profile-creation, update the state
      emit(state.copyWith(
        //  user: event.user, // Use the user returned from the repository
        isProfileLoading: false,
        isProfileSuccess: true, // Set to true on success
        profileFailure: '', // Clear any previous failure message
      ));
    } catch (e) {
      emit(state.copyWith(
        isProfileLoading: false,
        isProfileSuccess: false,
        profileFailure: e.toString(),
      ));
    }
  }

  void _locationEvent(LocationEvent event, Emitter<CreateProfileState> emit) {
    emit(
      state.copyWith(
        country: event.country,
        state: event.state,
        city: event.city,
      ),
    );
    print("My Country: ${state.country}");
  }

  Stream<CreateProfileState> _phoneNumberEvent(
      PhoneNoChanged event, Emitter<CreateProfileState> emit) async* {
    print(event.phoneNumber);
    emit(
      state.copyWith(phoneNumber: event.phoneNumber),
    );
  }

  Stream<CreateProfileState> _phoneNoValidationChanged(
      PhoneNoValidationChanged event, Emitter<CreateProfileState> emit) async* {
    emit(
      state.copyWith(
        isValid: event.isValid,
      ),
    );
  }

  // Stream<CreateProfileState> _signUpLoadingEvent(
  //     SignUpLoadingEvent event, Emitter<CreateProfileState> emit) async* {
  //   emit(state.copyWith(isSignUpLoading: true));
  //   await Future.delayed(const Duration(seconds: 2));
  //   const CircularProgressIndicator();
  //   emit(state.copyWith(isSignUpLoading: false));
  // }

  // Stream<CreateProfileState> _signUpSuccessEvent(
  //     SignUpSuccessEvent event, Emitter<CreateProfileState> emit) async* {
  //   emit(const SignUpSuccessState());
  //   try {
  //     const CircularProgressIndicator();
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Stream<CreateProfileState> _signUpFailureEvent(
  //     SignUpFailureEvent event, Emitter<CreateProfileState> emit) async* {
  //   emit(const SignUpFailurState("Error Loading"));
  // }

  void _nameChangedEvent(
      NameChangedEvent event, Emitter<CreateProfileState> emit) {
    emit(state.copyWith(
      firstName: event.firstName,
      middleName: event.middleName,
      lastName: event.lastName,
    ));
  }

  // void _phoneNumberEvent(PhoneNumberEvent event, Emitter<CreateProfileState> emit) {
  //   emit(state.copyWith(phoneNumber: event.phoneNumber));
  // }

  void _dateOfBirthEvent(DateEvent event, Emitter<CreateProfileState> emit) {
    emit(state.copyWith(
      dateOfBirth: event.dateOfBirth,
    ));
  }

  Future<void> _pickImageEvent(
      PickImage event, Emitter<CreateProfileState> emit) async {
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
