import 'dart:io';

import 'package:afalagi/bloc/sign_up/sign_up_event.dart';
import 'package:afalagi/bloc/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SignUpBloc extends Bloc<SignUpEvents, SignUpStates> {
  final ImagePicker _picker = ImagePicker();
  SignUpBloc() : super(const SignUpStates()) {
    on<FirstNameEvent>(_firstNameEvent);
    on<MiddleNameEvent>(_middleNameEvent);

    on<LastNameEvent>(_lastNameEvent);

    on<LocationEvent>(_locationEvent);

    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<RepasswordEvent>(_repasswordEvent);
    on<SignUpLoadingEvent>(_signUpLoadingEvent);
    on<SignUpSuccessEvent>(_signUpSuccessEvent);
    on<SignUpFailureEvent>(_signUpFailureEvent);
    on<GenderEvent>((event, emit) {
      emit(GenderSelectionState(event.gender));
    });
    on<PhoneNumberEvent>(_phoneNumberEvent);
    on<DateOfBirthEvent>(_dateOfBirthEvent);
    on<PickImage>(_pickImageEvent);
  }
  Stream<SignUpStates> _signUpLoadingEvent(
      SignUpLoadingEvent event, Emitter<SignUpStates> emit) async* {
    emit(const SignUpLoadingState());
    try {
      const CircularProgressIndicator();
    } catch (e) {
      print(e.toString());
    }
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

  void _firstNameEvent(FirstNameEvent event, Emitter<SignUpStates> emit) {
    emit(
      state.copyWith(firstName: event.firstname),
    );
  }

  void _middleNameEvent(MiddleNameEvent event, Emitter<SignUpStates> emit) {
    emit(state.copyWith(
      middleName: event.middleName,
    ));
  }

  void _lastNameEvent(LastNameEvent event, Emitter<SignUpStates> emit) {
    emit(
      state.copyWith(lastName: event.lastName),
    );
  }

  void _locationEvent(LocationEvent event, Emitter<SignUpStates> emit) {
    emit(
      state.copyWith(location: event.location),
    );
  }

  void _emailEvent(EmailEvent event, Emitter<SignUpStates> emit) {
    print(event.email);

    emit(
      state.copyWith(email: event.email),
    );
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignUpStates> emit) {
    print(event.password);

    emit(
      state.copyWith(password: event.password),
    );
  }

  void _repasswordEvent(RepasswordEvent event, Emitter<SignUpStates> emit) {
    print(event.repassword);

    emit(
      state.copyWith(repassword: event.repassword),
    );
  }

  void _phoneNumberEvent(PhoneNumberEvent event, Emitter<SignUpStates> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void _dateOfBirthEvent(DateOfBirthEvent event, Emitter<SignUpStates> emit) {
    emit(state.copyWith(dateOfBirth: event.dateOfBirth));
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
