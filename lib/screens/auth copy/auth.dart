import 'package:adelnewversion/business_logic/phone_auth/phone_auth_cubit.dart';
import 'package:adelnewversion/core/theme/colors.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/screens/widgets/green_button.dart';
import 'package:adelnewversion/screens/widgets/loading_indecator.dart';
import 'package:adelnewversion/screens/widgets/sub_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'dart:ui' as UI;

import 'code_form.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _phoneFormKey = GlobalKey();
  late String phoneNumber;
  late PhoneController phoneNumberController = PhoneController(null);
  UI.TextDirection direction = UI.TextDirection.ltr;

  @override
  Widget build(BuildContext context) {
    final windowsH = MediaQuery.of(context).size.height;
    final windowsW = MediaQuery.of(context).size.width;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(

// Image.asset('assets/images/logo.png',width: 130,height: 130,),

              image: AssetImage(
                'assets/images/logo.png',
              ),
              fit: BoxFit.fill)),
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
          ),
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
                          // bottomRight:
                          // Radius.circular(appLanguage.isEn ? 0 : 20),
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          //color: Colors.white,
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/logo.png',
                                width: 130,
                                height: 130,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  children: [
                                    Text(
                                      'Welcome to',
                                      style: Fonts()
                                          .primaryFont(21, FontWeight.bold),
                                    ),
                                    Text(
                                      context.locale.languageCode == 'ar'
                                          ? '!Dr. Adel Ramadan Clinic'
                                          : 'Dr. Adel Ramadan Clinic!',
                                      style: Fonts()
                                          .primaryFont(21, FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Text(
                                      context.locale.languageCode == 'ar'
                                          ? '!Come for teeth, Leave with a smile'
                                          : 'Come for teeth, Leave with a smile!',
                                      style: Fonts()
                                          .primaryFont(16, FontWeight.normal),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Form(
                                      key: _phoneFormKey,
                                      child: Directionality(
                                        textDirection: direction,
                                        child: PhoneFormField(
                                          controller: phoneNumberController,
                                          decoration: InputDecoration(
                                            prefixStyle: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                            hintText: 'mobile_number'.tr(),
                                            hintStyle: const TextStyle(
                                                color: primaryComponentColor),
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: primaryComponentColor,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: primaryComponentColor,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.black,
                                              ),
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10.0),
                                              ),
                                            ),
                                          ),
                                          flagSize: 30,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: titleTextColor,
                                            fontSize: 16,
                                          ),
                                          countryCodeStyle: const TextStyle(
                                              color: titleTextColor),
                                          validator: PhoneValidator.compose([
                                            PhoneValidator.required(
                                                errorText:
                                                    'enter_valid_phone'.tr()),
                                            PhoneValidator.validMobile(
                                                errorText:
                                                    'enter_valid_phone'.tr()),
                                          ]),
                                          defaultCountry: IsoCode.EG,
                                          countrySelectorNavigator:
                                              const CountrySelectorNavigator
                                                  .bottomSheet(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    _buildPhoneNumSubmittedBloc(),
                                    GreenButton(
                                        label: 'send_code'.tr(),
                                        icon: Icons.sms,
                                        // color: Colors.white.withOpacity(0.5),
                                        onPressed: () async {
                                          if (!_phoneFormKey.currentState!
                                              .validate()) {
                                            return;
                                          } else {
                                            _phoneFormKey.currentState!.save();
                                            BlocProvider.of<PhoneAuthCubit>(
                                                    context)
                                                .submitPhoneNumber(
                                                    phoneNumberController
                                                        .value!.nsn,
                                                    phoneNumberController
                                                        .value!.countryCode);
                                          }
                                        })
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
                            phoneNumber: phoneNumberController.value!.nsn,
                            isoCode: phoneNumberController.value!.countryCode),
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
}
