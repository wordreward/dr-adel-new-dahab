import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Row(),
          const SizedBox(height: 150,),
          Image.asset('assets/images/logo.png',width: 130,height: 130,),
          Text('Welcome to',style: Fonts().primaryFont(21, FontWeight.bold),),
          Text(context.locale.languageCode == 'ar'?'!Dr. Adel Ramadan Clinic':'Dr. Adel Ramadan Clinic!',style: Fonts().primaryFont(21, FontWeight.bold),),
          const SizedBox(height: 25,),
          Text(context.locale.languageCode == 'ar'?'!Come for teeth, Leave with a smile':'Come for teeth, Leave with a smile!',style: Fonts().primaryFont(16, FontWeight.normal),),
          const SizedBox(height: 25,),

          InkWell(
            onTap: (){
              Navigator.pushNamed(context, Routes.createAccountRoute);
            },
            child: Container(
              width: 230,
              height: 70,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(25),
                    topLeft: Radius.circular(25),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: primaryComponentColor
              ),
              child: Text('Sign Up'.tr(),style: Fonts().secondFont(24, FontWeight.bold),),
            ),
          ),

          const SizedBox(height: 5,),

          InkWell(
            onTap: (){
              Navigator.pushNamed(context, Routes.logInRoute);
            },
            child: Container(
              width: 230,
              height: 70,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  color: secondComponentColor
              ),
              child: Text('Log In'.tr(),style: Fonts().secondFont(24, FontWeight.bold),),
            ),
          ),
        ],
      ),
    );
  }
}
