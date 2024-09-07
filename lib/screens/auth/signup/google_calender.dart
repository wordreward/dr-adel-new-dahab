import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/screens/auth/widgets/signup_progress.dart';
import 'package:adelnewversion/screens/widgets/app_bar.dart';
import 'package:adelnewversion/screens/widgets/form_input_field.dart';
import 'package:flutter/material.dart';

class GoogleCalender extends StatefulWidget {
  const GoogleCalender({super.key});

  @override
  State<GoogleCalender> createState() => _GoogleCalenderState();
}

class _GoogleCalenderState extends State<GoogleCalender> {
  final TextEditingController email = TextEditingController();
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
            const SignupProgress(title: 'Google Calendar'),
            FormInputField(
              controller: email,
              color: primaryTextColor,
              prefixText: 'Gmail',
              autoFillHints: const <String>[
                AutofillHints.email
              ],
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == '') {
                  return 'enter your gmail';
                }
                return null;
              },
            ),

            const SizedBox(height: 25,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
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
