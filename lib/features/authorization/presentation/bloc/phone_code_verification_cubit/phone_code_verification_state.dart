part of 'phone_code_verification_cubit.dart';

@immutable
abstract class PhoneCodeVerificationState {}

class PhoneCodeVerificationInitialState extends PhoneCodeVerificationState {}

class PhoneCodeVerificationInputState extends PhoneCodeVerificationState {}

class PhoneCodeVerificationVerifiedState extends PhoneCodeVerificationState {}

class PhoneCodeVerificationErrorState extends PhoneCodeVerificationState {}
