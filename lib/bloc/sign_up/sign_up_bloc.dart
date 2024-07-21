import 'dart:io';

import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
part 'sign_up_event.dart';
part "sign_up_state.dart";

class SignUpBloc extends Bloc<SharedEvent, SignUpStates> {
  final ImagePicker _picker = ImagePicker();
  final UserRepository? _repository;
  @override
  SignUpBloc(this._repository) : super(SignUpStates.initial()) {
    on<NameChangedEvent>(_nameChangedEvent);

    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);

    on<SignUpLoadingEvent>(_signUpLoadingEvent);
    on<SignUpSuccessEvent>(_signUpSuccessEvent);
    on<SignUpFailureEvent>(_signUpFailureEvent);
    on<GenderEvent>((event, emit) {
      emit(state.copyWith(selected: event.gender));
    });
    on<PhoneNoChanged>(_phoneNumberEvent);
    on<PhoneNoValidationChanged>(_phoneNoValidationChanged);
    // on<DateEvent>(_dateOfBirthEvent);
    on<PickImage>(_pickImageEvent);
    on<LocationEvent>(_locationEvent);
    on<DateEvent>(_dateOfBirthEvent);
    on<SignUpReset>(
      (event, emit) => emit(SignUpStates.initial()),
    );
    on<SignUpSubmitEvent>(_signupSubmitEvent);
  }
  Future<void> _signupSubmitEvent(
      SignUpSubmitEvent event, Emitter<SignUpStates> emit) async {
    emit(state.copyWith(isSignUpLoading: true));
    print("email is : ${state.email}");
    try {
      await _repository!.signUp(
          email: state.email,
          password: state.password,
          passwordConfirm: state.repassword);
      // On successful sign-up, update the state
      emit(state.copyWith(
        isSignUpLoading: false,
        signUpSuccess: true, // Set to true on success
        signUpFailure: '', // Clear any previous failure message
      ));
    } catch (e) {
      emit(state.copyWith(
          isSignUpLoading: false,
          signUpSuccess: false,
          signUpFailure: e.toString()));
    }
  }

  Stream<SignUpStates> _locationEvent(
      LocationEvent event, Emitter<SignUpStates> emit) async* {
    emit(
      state.copyWith(
        country: event.country,
        state: event.state,
        city: event.city,
      ),
    );
    print("My Country: ${state.country}");
  }

  Stream<SignUpStates> _phoneNumberEvent(
      PhoneNoChanged event, Emitter<SignUpStates> emit) async* {
    emit(
      state.copyWith(phoneNumber: event.phoneNumber),
    );
  }

  Stream<SignUpStates> _phoneNoValidationChanged(
      PhoneNoValidationChanged event, Emitter<SignUpStates> emit) async* {
    emit(
      state.copyWith(
        isValid: event.isValid,
      ),
    );
  }

  Stream<SignUpStates> _signUpLoadingEvent(
      SignUpLoadingEvent event, Emitter<SignUpStates> emit) async* {
    emit(state.copyWith(isSignUpLoading: true));
    await Future.delayed(const Duration(seconds: 2));
    const CircularProgressIndicator();
    emit(state.copyWith(isSignUpLoading: false));
  }

  Stream<SignUpStates> _signUpSuccessEvent(
      SignUpSuccessEvent event, Emitter<SignUpStates> emit) async* {
    emit(const SignUpSuccessState());
    try {
      const CircularProgressIndicator();
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<SignUpStates> _signUpFailureEvent(
      SignUpFailureEvent event, Emitter<SignUpStates> emit) async* {
    emit(const SignUpFailurState("Error Loading"));
  }

  void _nameChangedEvent(NameChangedEvent event, Emitter<SignUpStates> emit) {
    emit(state.copyWith(
      firstName: event.firstName,
      middleName: event.middleName,
      lastName: event.lastName,
    ));
  }

  void _emailEvent(EmailEvent event, Emitter<SignUpStates> emit) {
    emit(
      state.copyWith(email: event.email),
    );
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignUpStates> emit) {
    print(event.password);

    emit(
      state.copyWith(password: event.password, repassword: event.repassword),
    );
  }

  // void _phoneNumberEvent(PhoneNumberEvent event, Emitter<SignUpStates> emit) {
  //   emit(state.copyWith(phoneNumber: event.phoneNumber));
  // }

  void _dateOfBirthEvent(DateEvent event, Emitter<SignUpStates> emit) {
    emit(state.copyWith(
      dateOfBirth: event.dateOfBirth,
    ));
  }

  Future<void> _pickImageEvent(
      PickImage event, Emitter<SignUpStates> emit) async {
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
