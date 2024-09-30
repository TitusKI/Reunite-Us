import 'package:afalagi/core/resources/shared_event.dart';
import 'package:afalagi/core/util/controller/enums.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../domain/entities/user_profile_entity.dart';

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
  final UserProfileEntity userProfile;
  const ProfileSubmitEvent({
    required this.userProfile,
  });
}

class ProfileReset extends CreateProfileEvent {}
