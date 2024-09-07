import 'dart:ui';

import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:adelnewversion/screens/auth/widgets/signup_progress.dart';
import 'package:adelnewversion/screens/widgets/app_bar.dart';
import 'package:adelnewversion/screens/widgets/form_input_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReferralCode extends StatefulWidget {
  const ReferralCode({super.key});

  @override
  State<ReferralCode> createState() => _ReferralCodeState();
}

class _ReferralCodeState extends State<ReferralCode> {
  final TextEditingController code = TextEditingController();

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
            const SignupProgress(title: 'Referral code'),
            FormInputField(
              controller: code,
              color: primaryTextColor,
              prefixText: 'Referral Code',
              validator: (v) {
                if (v == '') {
                  return 'enter a Referral Code';
                }
                return null;
              },
            ),

            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                "Please enter referral code , or the mobile number of the referring friend",
                style: Fonts().primaryFont(12, FontWeight.normal),
              ),
            ),


            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    if(code.text == ""){
                      showDialog(
                          context: context,
                          barrierColor: const Color(0xffA9BF5D).withOpacity(0.4),
                          builder: (_) {
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                              child: Dialog(
                                elevation: 0,
                                backgroundColor: const Color(0xff64656A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16.0),
                                ),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width*0.1,
                                  height: MediaQuery.of(context).size.height*0.33,
                                  child: Column(
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(bottom: 1,top: 35,left: 15,right: 15),
                                        child: Text('Are you sure you want to finish setup without the referring code?',
                                          textAlign: TextAlign.center,
                                          style: Fonts().secondFont(16, FontWeight.normal),
                                        ),
                                      ),
                                      const SizedBox(height: 20,),

                                      InkWell(
                                        onTap: (){
                                          Navigator.pop(context, false);
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "back to enter code".toUpperCase(),
                                              style: Fonts().secondFont(12, FontWeight.bold),
                                            ),
                                            const SizedBox(width: 5,),
                                            Card(
                                              elevation: 5.0,
                                              color: primaryComponentColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0), // Rounded corners
                                              ),
                                              child:Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                ),
                                                padding: const EdgeInsets.all(2),
                                                child: const Icon(
                                                  Icons.arrow_back_ios_new,
                                                  size: 35.0, // Size of the arrow icon
                                                  color: secondTextColor, // Color of the arrow icon
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),

                                      const SizedBox(height: 25,),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(context, Routes.gmailRoute);
                                        },
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "finish without code".toUpperCase(),
                                              style: Fonts().secondFont(12, FontWeight.normal),
                                            ),
                                            const SizedBox(width: 5,),
                                            Card(
                                              elevation: 5.0,
                                              color: secondTextColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.0), // Rounded corners
                                              ),
                                              child:Container(
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                ),
                                                padding: const EdgeInsets.all(2),
                                                child: const Icon(
                                                  Icons.arrow_forward_ios,
                                                  size: 35.0, // Size of the arrow icon
                                                  color: secondComponentColor, // Color of the arrow icon
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }else{
                      Navigator.pushNamed(context, Routes.gmailRoute);
                    }
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
