import 'package:afalagi/bloc/sign_up/sign_up_event.dart';
import 'package:afalagi/bloc/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvents, SignUpStates> {
  SignUpBloc() : super(const SignUpStates()) {
    on<FirstNameEvent>(_firstNameEvent);
    on<MiddleNameEvent>(_middleNameEvent);

    on<LastNameEvent>(_lastNameEvent);

    on<LocationEvent>(_locationEvent);

    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<RepasswordEvent>(_repasswordEvent);
    on<SignUpLoadingEvent>(_SignUpLoadingEvent);
    on<SignUpSuccessEvent>(_SignUpSuccessEvent);
    on<SignUpFailureEvent>(_SignUpFailureEvent);
    on<GenderEvent>((event, emit) {
      emit(GenderSelectionState(event.gender));
    });
    on<PhoneNumberEvent>(_phoneNumberEvent);
    on<DateOfBirthEvent>(_dateOfBirthEvent);
  }
  Stream<SignUpStates> _SignUpLoadingEvent(
      SignUpLoadingEvent event, Emitter<SignUpStates> emit) async* {
    emit(const SignUpLoadingState());
    try {
      const CircularProgressIndicator();
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<SignUpStates> _SignUpSuccessEvent(
      SignUpSuccessEvent event, Emitter<SignUpStates> emit) async* {
    emit(const SignUpSuccessState());
    try {
      const CircularProgressIndicator();
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<SignUpStates> _SignUpFailureEvent(
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
}
