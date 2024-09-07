import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/screens/widgets/app_bar.dart';
import 'package:adelnewversion/screens/widgets/form_input_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 30,left: 30),
        child: Column(
          children: [
            Appbar(title: 'Log In'.tr(),showBackButton: true,topPadding: true,),
            const SizedBox(height: 25,),
            FormInputField(
              controller: phone,
              color: primaryTextColor,
              prefixText: 'Mobile Number'.tr(),
              autoFillHints: const <String>[
                AutofillHints.telephoneNumber
              ],
              keyboardType: TextInputType.phone,
              validator: (v) {
                if (v == '') {
                  return 'enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 10,),
            FormInputField(
              controller: password,
              color: primaryTextColor,
              prefixText: 'Password'.tr(),
              scure: true,
              autoFillHints: const <String>[
                AutofillHints.password
              ],
              keyboardType: TextInputType.visiblePassword,
              validator: (v) {
                if (v == '') {
                  return 'enter your password';
                }
                return null;
              },
            ),
            const SizedBox(height: 20,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, Routes.navBarRoute);
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
                          'Next'.tr(),
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
