class EmailVerifyReq {
  final String email;
  final int code;

  const EmailVerifyReq({
    required this.email,
    required this.code,
  });
}
