import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/constant/global_var.dart';
import 'package:adelnewversion/constant/routes.dart';
import 'package:adelnewversion/core/theme/colors.dart';
import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:adelnewversion/screens/widgets/defualt_dialog.dart';
import 'package:adelnewversion/screens/widgets/form_input_field.dart';
import 'package:adelnewversion/screens/widgets/loading_indecator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class SignUp3 extends StatefulWidget {
  SignUp3(
      {Key? key,
      required this.email,
      required this.date,
      required this.name,
      required this.gander})
      : super(key: key);

  String email;
  String date;
  String name;
  String gander;

  @override
  State<SignUp3> createState() => _SignUp3State();
}

class _SignUp3State extends State<SignUp3> {
  final TextEditingController name = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController code = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();

  String? selectedGender;

  bool agree = false;

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var mainWidgetH = h * 0.38;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg.png"), fit: BoxFit.fill)),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            'create_profile'.tr(),
            style: const TextStyle(color: Colors.white),
          ),
          automaticallyImplyLeading: true,
        ),
        body: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {
            if (state is SignupLoading) {
              LoadingScreen.show(context);
            }
            if (state is SignupSuccess) {
              LoadingScreen.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.navBarRoute, (route) => false);
            }
            if (state is SignupError) {
              LoadingScreen.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                  duration: const Duration(seconds: 5),
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10, bottom: 20),
                          width: w * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: primaryComponentColor),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: h * 0.01,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: primaryComponentColor,
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: FormInputField(
                                      color: primaryTextColor,
                                      controller: code,
                                      prefixText: "codee".tr(),
                                      hintText: "code".tr(),
                                      keyboardType: TextInputType.number,
                                      validator: (v) {
                                        // if (v == '') {
                                        //   return null;
                                        // }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.01,
                                  ),
                                  Text(
                                    'code_confirm'.tr(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: titleTextColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          agree = !agree;
                                          setState(() {});
                                        },
                                        child: Container(
                                          height: 25,
                                          width: 25,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border: Border.all(
                                                color: const Color(0xFFBABABA)),
                                          ),
                                          child: agree == true
                                              ? Icon(
                                                  Icons.check,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )
                                              : const SizedBox(),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      InkWell(
                                        onTap: () async {
                                          Uri enMembership = Uri.parse(
                                              'https://wordreward.web.app/privacy-policy/$enName/info@wordreward.net');

                                          if (await canLaunchUrl(
                                              enMembership)) {
                                            launchUrl(enMembership,
                                                mode: LaunchMode.inAppWebView);
                                          }
                                        },
                                        child: Text.rich(
                                          TextSpan(
                                            text: tr('i_agree_to'),
                                            children: [
                                              const TextSpan(text: ''),
                                              TextSpan(
                                                text:
                                                    tr('terms_and_Conditions'),
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium
                                                    ?.copyWith(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.black,
                                                      fontSize: 12,
                                                    ),
                                              ),
                                              const TextSpan(text: '.'),
                                            ],
                                          ),
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 14,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: h * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          padding: MaterialStateProperty.all(
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4, vertical: 2)),
                                          overlayColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xff3B3131)
                                                      .withOpacity(0.7)),
                                          backgroundColor:
                                              MaterialStateProperty.all(
                                                  const Color(0xff3B3131)
                                                      .withOpacity(0.7)),
                                        ),
                                        onPressed: () {
                                          FocusScope.of(context).unfocus();
                                          if (!_formKey.currentState!
                                              .validate()) {
                                            return;
                                          } else {
                                            if (!agree) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content:
                                                      Text("agree_terms".tr()),
                                                  backgroundColor: Colors.red,
                                                  duration: const Duration(
                                                      seconds: 5),
                                                ),
                                              );
                                              return;
                                            }
                                            _formKey.currentState!.save();
                                            if (code.text == "") {
                                              showDialog(
                                                  context: context,
                                                  builder: (_) {
                                                    return DefaultDialog(
                                                      size: 12,
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, false);
                                                      },
                                                      title:
                                                          'Missing Referral Code'
                                                              .tr(),
                                                      body: 'code_confirm'.tr(),
                                                      cancel:
                                                          'code_accept'.tr(),
                                                      accept:
                                                          'code_cancel'.tr(),
                                                      onPressedCancel: () {
                                                        Navigator.pop(
                                                            context, true);
                                                        BlocProvider.of<
                                                                    AppCubit>(
                                                                context)
                                                            .signup(
                                                                widget.name,
                                                                widget.date,
                                                                '',
                                                                widget.email,
                                                                widget.gander,
                                                                code.text);
                                                      },
                                                    );
                                                  });
                                            } else {
                                              BlocProvider.of<AppCubit>(context)
                                                  .signup(
                                                      widget.name,
                                                      widget.date,
                                                      '',
                                                      widget.email,
                                                      widget.gander,
                                                      code.text);
                                            }
                                          }
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 7.0),
                                          child: SizedBox(
                                            width: w * 0.35,
                                            height: h * 0.06,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                SizedBox(
                                                  width: w * 0.02,
                                                ),
                                                Text(
                                                  'next'.tr(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      // height: 2.5,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
