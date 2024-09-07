import 'dart:async';
import 'dart:convert';
import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/business_logic/phone_auth/phone_auth_cubit.dart';
import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:adelnewversion/screens/auth%20copy/signup_screen.dart';
import 'package:adelnewversion/screens/widgets/green_button.dart';
import 'package:adelnewversion/screens/widgets/loading_indecator.dart';
import 'package:adelnewversion/screens/widgets/sub_appbar.dart';
import 'package:easy_localization/easy_localization.dart' as localization;
import 'package:crypto/crypto.dart';

import 'package:adelnewversion/constant/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class CodeForm extends StatefulWidget {
  final phoneNumber;
  final isoCode;
  CodeForm({super.key, this.phoneNumber, this.isoCode});

  @override
  State<CodeForm> createState() => _CodeFormState();
}

class _CodeFormState extends State<CodeForm> {
  late String otpCode;

  int secondsRemaining = 60;
  bool enableResend = false;
  late Timer timer;

  @override
  initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (secondsRemaining != 0) {
        setState(() {
          secondsRemaining--;
        });
      } else {
        setState(() {
          enableResend = true;
        });
      }
    });
  }

  void _resendCode() {
    //other code here
    setState(() {
      secondsRemaining = 60;
      enableResend = false;
    });
  }

  @override
  dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final windowsH = MediaQuery.of(context).size.height;
    //  final windowsW = MediaQuery.of(context).size.width;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill)),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          //backgroundColor: prtimaryPurple,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          //color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                height: windowsH * 0.05,
                              ),
                              Image.asset(
                                'assets/images/logo.png',
                                width: 130,
                                height: 130,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'sent_sms'.tr(),
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  color: titleTextColor),
                                              textAlign: TextAlign.end,
                                              maxLines: 1,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              '+${widget.isoCode}${widget.phoneNumber}',
                                              // textDirection: TextDirection.ltr,
                                              style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: titleTextColor),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.pushNamedAndRemoveUntil(
                                            context, auth, (route) => false);
                                      },
                                      child: Text(
                                        'change_phone'.tr(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: primaryComponentColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    // Directionality(
                                    //   textDirection: TextDirection.ltr,
                                    //   child: PinCodeTextField(
                                    //     appContext: context,
                                    //     autoFocus: true,
                                    //     cursorColor: Colors.transparent,
                                    //     keyboardType: TextInputType.number,
                                    //     length: 4,
                                    //     obscureText: false,
                                    //     animationType: AnimationType.scale,
                                    //     pinTheme: PinTheme(
                                    //       shape: PinCodeFieldShape.box,
                                    //       borderRadius: BorderRadius.circular(10),
                                    //       fieldHeight: 45,
                                    //       fieldWidth: 45,
                                    //       borderWidth: 1,
                                    //       activeColor: Colors.transparent,
                                    //       inactiveColor: Colors.grey,
                                    //       inactiveFillColor: Colors.transparent,
                                    //       activeFillColor: Colors.transparent,
                                    //       selectedColor: primaryComponentColor,
                                    //       selectedFillColor: Colors.transparent,
                                    //     ),
                                    //     animationDuration: const Duration(milliseconds: 300),
                                    //     backgroundColor: Colors.transparent,
                                    //     enableActiveFill: true,
                                    //     onCompleted: (submitedCode) {
                                    //       otpCode = submitedCode;
                                    //     },
                                    //     onChanged: (value) {
                                    //     },
                                    //   ),
                                    // ),
                                    PinCodeTextField(
                                      appContext: context,
                                      autoFocus: true,
                                      cursorColor: Colors.transparent,
                                      keyboardType: TextInputType.number,
                                      length: 4,
                                      obscureText: false,
                                      animationType: AnimationType.scale,
                                      pinTheme: PinTheme(
                                        shape: PinCodeFieldShape.box,
                                        borderRadius: BorderRadius.circular(10),
                                        fieldHeight: 45,
                                        fieldWidth: 45,
                                        borderWidth: 1,
                                        activeColor: Colors.transparent,
                                        inactiveColor: Colors.grey,
                                        inactiveFillColor: Colors.transparent,
                                        activeFillColor: Colors.transparent,
                                        selectedColor: primaryComponentColor,
                                        selectedFillColor: Colors.transparent,
                                      ),
                                      animationDuration:
                                          const Duration(milliseconds: 300),
                                      backgroundColor: Colors.transparent,
                                      enableActiveFill: true,
                                      onCompleted: (submitedCode) {
                                        otpCode = submitedCode;
                                      },
                                      onChanged: (value) {},
                                    ),
                                    GreenButton(
                                        label: 'Log In'.tr(),
                                        icon: Icons.login,
                                        color: primaryComponentColor,
                                        onPressed: () => _login(context)),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    _buildPhoneNumSubmittedBloc(),
                                    enableResend
                                        ? InkWell(
                                            onTap: () {
                                              BlocProvider.of<PhoneAuthCubit>(
                                                      context)
                                                  .submitPhoneNumber(
                                                      widget.phoneNumber,
                                                      widget.isoCode);
                                            },
                                            child: Text(
                                              'resend_sms'.tr(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: primaryComponentColor,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            'resend_countDown'.tr() +
                                                " $secondsRemaining",
                                            style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: primaryComponentColor,
                                            ),
                                          ),
                                    _submittedOTP(),
                                    _checkUser()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SubAppBar(),
                    ],
                  ),
                  // Container(
                  //   //color: prtimaryPurple,
                  //   padding: const EdgeInsets.only(
                  //       left: 20.0, bottom: 20, right: 20, top: 0),
                  //   child: Column(
                  //     children: [
                  //       Container(
                  //         padding: EdgeInsets.all(
                  //             MediaQuery.of(context).size.width * 0.0125),
                  //         decoration: BoxDecoration(
                  //           color: Colors.white.withOpacity(0.5),
                  //           borderRadius: const BorderRadius.all(
                  //             Radius.circular(15),
                  //           ),
                  //         ),
                  //         child: const ChangeLanguage(),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumSubmittedBloc() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          LoadingScreen.show(context);
        }
        if (state is PhoneNumberSubmited) {
          Navigator.pop(context);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (_) => BlocProvider(
                        create: (context) => PhoneAuthCubit(),
                        child: CodeForm(
                            phoneNumber: widget.phoneNumber,
                            isoCode: widget.isoCode),
                      )),
              (route) => false);
        }
        if (state is ErrorOccurred) {
          Navigator.pop(context);
          String errorMsg = state.errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
            ),
          );
        }
      },
      child: Container(),
    );
  }

  void _login(BuildContext context) {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }

  Widget _submittedOTP() {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) async {
        if (state is Loading) {
          LoadingScreen.show(context);
        }
        if (state is ErrorOccurred) {
          LoadingScreen.pop(context);
          String errorMsg = state.errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: const Duration(seconds: 5),
            ),
          );
        }
        if (state is PhoneOTPVerified) {
          var bytesToHash =
              utf8.encode('+${widget.isoCode}${widget.phoneNumber}');
          var md5Digest = md5.convert(bytesToHash);
          BlocProvider.of<AppCubit>(context).login(
              '+${widget.isoCode}${widget.phoneNumber}', md5Digest.toString());
        }
      },
      child: Container(),
    );
  }

  Widget _checkUser() {
    return BlocListener<AppCubit, AppState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is LoginError) {
          LoadingScreen.pop(context);
          String errorMsg = state.message;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
            ),
          );
        }
        if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.navBarRoute, (route) => false);
        }
        if (state is UserNotExist) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => SignupScreen(),
              ),
              (route) => false);
        }
      },
      child: Container(),
    );
  }
}
