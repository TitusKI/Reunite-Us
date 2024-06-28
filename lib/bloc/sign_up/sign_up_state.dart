class SignUpStates {
  final String firstName;
  final String middleName;
  final String lastName;
  final String location;
  final String email;
  final String password;
  final String repassword;
  final String? phoneNumber;
  final String? dateOfBirth;

  const SignUpStates({
    this.firstName = "",
    this.middleName = "",
    this.lastName = "",
    this.location = "",
    this.email = "",
    this.password = "",
    this.repassword = "",
    this.phoneNumber = "",
    this.dateOfBirth,
  });

  SignUpStates copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? location,
    String? email,
    String? password,
    String? repassword,
    String? phoneNumber,
    String? dateOfBirth,
  }) {
    return SignUpStates(
        firstName: firstName ?? this.firstName,
        middleName: middleName ?? this.middleName,
        lastName: lastName ?? this.lastName,
        location: location ?? this.location,
        email: email ?? this.email,
        password: password ?? this.password,
        repassword: repassword ?? this.repassword,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        dateOfBirth: dateOfBirth ?? this.dateOfBirth);
  }
}

class GenderInitial extends SignUpStates {}

class GenderSelectionState extends SignUpStates {
  final String selectedGender;
  const GenderSelectionState(this.selectedGender);
  List<Object> get props => [selectedGender];
}

class SignUpSuccessState extends SignUpStates {
  final bool isSignUpSuccess;
  const SignUpSuccessState({this.isSignUpSuccess = false});
}

class SignUpLoadingState extends SignUpStates {
  final bool isSignUpLoading;
  const SignUpLoadingState({this.isSignUpLoading = false});
}

class SignUpFailurState extends SignUpStates {
  final String error;
  const SignUpFailurState(this.error);
  @override
  List<Object> get props => [error];
}
