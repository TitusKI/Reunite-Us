import 'dart:io';

import 'package:afalagi/presentation/bloc/shared_event.dart';
import 'package:afalagi/data/models/Auth/user_profile_model.dart';
import 'package:afalagi/core/util/controller/enums.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

abstract class CreateProfileEvent extends SharedEvent {
  const CreateProfileEvent();
}

class GenderEvent extends CreateProfileEvent {
  final Gender gender;
  const GenderEvent(this.gender);
}

class PhoneNoChanged extends CreateProfileEvent {
  final PhoneNumber phoneNumber;
  const PhoneNoChanged(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class PhoneNoValidationChanged extends CreateProfileEvent {
  final bool isValid;
  const PhoneNoValidationChanged(this.isValid);

  @override
  List<Object> get props => [isValid];
}

class ProfileSubmitEvent extends CreateProfileEvent {
  final UserProfile userProfile;
  final File file;
  const ProfileSubmitEvent({
    required this.userProfile,
    required this.file,
  });
}

class ProfileReset extends CreateProfileEvent {}
