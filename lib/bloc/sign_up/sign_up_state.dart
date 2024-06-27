class SignUpStates {
  final String userName;
  final String email;
  final String password;
  final String repassword;

  const SignUpStates(
      {this.userName = "",
      this.email = "",
      this.password = "",
      this.repassword = ""});

  SignUpStates copyWith({
    String? userName,
    String? email,
    String? password,
    String? repassword,
  }) {
    return SignUpStates(
        userName: userName ?? this.userName,
        email: email ?? this.email,
        password: password ?? this.password,
        repassword: repassword ?? this.repassword);
  }
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
