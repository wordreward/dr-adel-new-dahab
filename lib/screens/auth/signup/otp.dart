import 'dart:async';

import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:adelnewversion/screens/auth/widgets/signup_progress.dart';
import 'package:adelnewversion/screens/widgets/app_bar.dart';
import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Otp extends StatefulWidget {
  const Otp({super.key});

  @override
  State<Otp> createState() => _OtpState();
}

enum VerificationMethod {sms , whatsapp}

class _OtpState extends State<Otp> {
  VerificationMethod? _selectedMethod = VerificationMethod.whatsapp;

  late String otpCode;

  bool _isResendButtonDisabled = true;
  int _resendTimeout = 60;
  Timer? _timer;

  void _startResendCountdown() {
    setState(() {
      _isResendButtonDisabled = true;
      _resendTimeout = 60;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_resendTimeout > 0) {
          _resendTimeout--;
        } else {
          _isResendButtonDisabled = false;
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 30,left: 30,top: kToolbarHeight),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset('assets/images/logo.png',width: 130,height: 80,),
              ],
            ),
            Appbar(title: 'Sign Up',showBackButton: true,topPadding: false,),
            const SizedBox(height: 25,),
            const SignupProgress(title: 'otp'),

            const SizedBox(height: 25,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Radio<VerificationMethod>(
                      value: VerificationMethod.sms,
                      groupValue: _selectedMethod,
                      onChanged: (VerificationMethod? value) {
                        setState(() {
                          _selectedMethod = value;
                        });
                      },
                      activeColor: const Color(0xff545C7A),
                    ),

                    const Icon(Icons.sms),
                    const SizedBox(width: 5),
                    Text('SMS',
                      style: GoogleFonts.poppins(
                          color: const Color(0xff545C7A),
                          fontSize: 12,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Radio<VerificationMethod>(
                      value: VerificationMethod.whatsapp,
                      groupValue: _selectedMethod,
                      onChanged: (VerificationMethod? value) {
                        setState(() {
                          _selectedMethod = value;
                        });
                      },
                      activeColor: const Color(0xff545C7A),
                    ),
                    const Icon(BootstrapIcons.whatsapp,size: 20,),
                    const SizedBox(width: 5),
                    Text('WhatsApp',
                      style: GoogleFonts.poppins(
                          color: const Color(0xff545C7A),
                          fontSize: 12,
                          fontWeight: FontWeight.normal
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    _startResendCountdown();
                  },
                  child: Row(
                    children: [
                      Text('Send OTP',style: Fonts().textButtonFont(20, FontWeight.normal),),
                      const Icon(Icons.arrow_forward_ios,size: 25,)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: PinCodeTextField(
                  appContext: context,
                  autoFocus: false,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.scale,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(18),
                    fieldHeight: 40,
                    fieldWidth: 40,
                    borderWidth: 1,
                    activeColor: Colors.grey,
                    inactiveColor: Colors.grey,
                    inactiveFillColor: Colors.white,
                    activeFillColor: Colors.white,
                    selectedColor: primaryComponentColor,
                    selectedFillColor: Colors.white,
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.white,
                  enableActiveFill: true,
                  onCompleted: (submitedCode) {
                    otpCode = submitedCode;
                  },
                  onChanged: (value) {
                  },
                ),
              ),
            ),
            TextButton(
              onPressed: _isResendButtonDisabled ? null : () {
                // Handle resend OTP logic here
                _startResendCountdown();
              },
              child: _isResendButtonDisabled?Text('Resend OTP ($_resendTimeout s)'):
              Text('Resend OTP',style: Fonts().textButtonFont(20, FontWeight.normal),),
            ),
            const SizedBox(height: 15,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, Routes.referralRoute);
                  },
                  child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                      color: primaryComponentColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          'Next',
                          style: Fonts().secondFont(25, FontWeight.bold),
                        ),
                        const Icon(Icons.arrow_forward_ios,color: secondTextColor,size: 25,)
                      ],
                    ),
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
