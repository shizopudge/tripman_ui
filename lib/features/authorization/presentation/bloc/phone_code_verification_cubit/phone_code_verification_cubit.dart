import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'phone_code_verification_state.dart';

const String validCode = '5555';

class PhoneCodeVerificationCubit extends Cubit<PhoneCodeVerificationState> {
  PhoneCodeVerificationCubit() : super(PhoneCodeVerificationInitialState());

  void authCheckPhoneCodeEvent({required String code}) {
    if (code.isNotEmpty) {
      if (code.length == 4) {
        if (code == validCode) {
          emit(PhoneCodeVerificationVerifiedState());
        } else {
          emit(PhoneCodeVerificationErrorState());
        }
      } else {
        emit(PhoneCodeVerificationInputState());
      }
    }
  }

  void sendVerificationCode({required String phoneNumber}) {
    if (phoneNumber.isNotEmpty) {
      //send verification code
      debugPrint('Send verification code');
    }
  }
}
