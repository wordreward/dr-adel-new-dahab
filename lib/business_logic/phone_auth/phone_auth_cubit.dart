import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:dio/dio.dart';
import '../../constant/global_var.dart';
part 'phone_auth_state.dart';
class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  String? id;

  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future<void> submitPhoneNumber(String phoneNumber,String code) async {
    emit(Loading());
    var dio = Dio();
    var response = await dio.request(
      'https://korayem.wordreward.net/api/generate/otp?phone=$code$phoneNumber',
      options: Options(
        method: 'POST',
      ),
    );
    if (response.statusCode == 200) {
      codeSent(json.encode(response.data['secretKey']),0);
      print(json.encode(response.data['secretKey']));
    }
    else {
      emit(ErrorOccurred(errorMsg: 'something went wrong'));
      print(response.statusMessage);
    }

/*
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+$code$phoneNumber',
      timeout: const Duration(seconds: 5),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
*/
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    await signIn(/*credential*/"");
  }

  void verificationFailed(FirebaseAuthException error) {
    emit(ErrorOccurred(errorMsg: error.toString()));
  }

  void codeSent(String verificationId, int? resendToken) {
    id = verificationId;
    prefs.setString('verificationId', verificationId);
    emit(PhoneNumberSubmited());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
  }

  Future<void> submitOTP(String otpCode) async {
    emit(Loading());
    /*PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: prefs.getString('verificationId')!, smsCode: otpCode
    );*/
    await signIn(otpCode);
  }

  Future<void> signIn(String otpCode/*PhoneAuthCredential credential*/) async {
    var dio = Dio();
    String key=prefs.getString('verificationId')!.replaceAll('\"', '');
    var response = await dio.request(
      'https://korayem.wordreward.net/api/check/otp?secretKey=$key&otp=$otpCode',
      options: Options(
        method: 'POST',
      ),
    );

    if (response.statusCode == 200) {
      print(json.encode(response.data['message']));
      if(json.encode(response.data['message'])=='\"User Valid\"'){
        print(json.encode(response.data['message'])=='\"User Valid\"');
        emit(PhoneOTPVerified());
      }else{
        emit(ErrorOccurred(errorMsg: "Invalid OTP"));
      }
    }
    else {
      emit(ErrorOccurred(errorMsg: response.statusMessage.toString()));
      print(response.statusMessage);
    }
    /*try {
      //await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOTPVerified());
    } catch (error) {
      emit(ErrorOccurred(errorMsg: error.toString()));
    }*/
  }

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }
}
