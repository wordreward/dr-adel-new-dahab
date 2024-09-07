import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:adelnewversion/screens/auth%20copy/signup2.dart';
import 'package:adelnewversion/screens/widgets/form_input_field.dart';
import 'package:adelnewversion/screens/widgets/loading_indecator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constant/routes.dart';

class SignupScreen extends StatefulWidget {
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
          title: Text(
            'create_profile'.tr(),
            style: const TextStyle(color: titleTextColor),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
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
            var image = BlocProvider.of<AppCubit>(context).image;
            return SingleChildScrollView(
              child: Column(
                children: [
                  ClipRRect(
                    child: Container(
                      //color: Colors.white,
                      padding: const EdgeInsets.only(
                          left: 25, right: 15, bottom: 15),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          image == null
                              ? Container(
                                  decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: SizedBox.fromSize(
                                        size: const Size.fromRadius(45),
                                        child: Image.asset(
                                          'assets/images/User-Profile-PNG.png',
                                          fit: BoxFit.fill,
                                        )),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(45),
                                    child: Image.file(
                                      BlocProvider.of<AppCubit>(context).image!,
                                      fit: BoxFit.cover,
                                      width: w * 0.22,
                                      height: h * 0.11,
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () =>
                                BlocProvider.of<AppCubit>(context).pickImage(),
                            child: Text(
                              'change_photo'.tr(),
                              style: const TextStyle(
                                  fontSize: 18,
                                  color: titleTextColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
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
                                      borderRadius: BorderRadius.circular(15)),
                                  child: FormInputField(
                                    controller: name,
                                    color: Colors.white,
                                    prefixText: 'name'.tr(),
                                    validator: (v) {
                                      if (v == '') {
                                        return 'enter your name';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.02,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: primaryComponentColor)),
                                  height: h * 0.08,
                                  width: w * 0.8,
                                  child: FittedBox(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            BlocProvider.of<AppCubit>(context)
                                                .selectedGender(1);
                                            BlocProvider.of<AppCubit>(context)
                                                    .gender[0]
                                                ? selectedGender = 'male'
                                                : selectedGender = 'female';
                                          },
                                          child: Container(
                                            height: h * 0.08,
                                            width: w * 0.41,
                                            decoration: BoxDecoration(
                                                color: BlocProvider.of<AppCubit>(
                                                            context)
                                                        .gender[1]
                                                    ? primaryComponentColor
                                                    : titleTextColor
                                                        .withOpacity(0.3),
                                                borderRadius: context.locale
                                                            .languageCode !=
                                                        'ar'
                                                    ? const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10))
                                                    : const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10))),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.woman,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  'female'.tr(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            BlocProvider.of<AppCubit>(context)
                                                .selectedGender(0);
                                            BlocProvider.of<AppCubit>(context)
                                                    .gender[0]
                                                ? selectedGender = 'male'
                                                : selectedGender = 'female';
                                          },
                                          child: Container(
                                            height: h * 0.08,
                                            width: w * 0.41,
                                            decoration: BoxDecoration(
                                                color: BlocProvider.of<AppCubit>(
                                                            context)
                                                        .gender[0]
                                                    ? primaryComponentColor
                                                    : titleTextColor
                                                        .withOpacity(0.3),
                                                borderRadius: context.locale
                                                            .languageCode !=
                                                        'ar'
                                                    ? const BorderRadius.only(
                                                        topRight:
                                                            Radius.circular(10),
                                                        bottomRight:
                                                            Radius.circular(10))
                                                    : const BorderRadius.only(
                                                        topLeft:
                                                            Radius.circular(10),
                                                        bottomLeft:
                                                            Radius.circular(10))),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.man,
                                                  color: primaryComponentColor,
                                                ),
                                                Text(
                                                  'male'.tr(),
                                                  style: const TextStyle(
                                                      color:
                                                          primaryComponentColor,
                                                      fontSize: 16),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: h * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                        overlayColor: MaterialStateProperty.all(
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
                                          _formKey.currentState!.save();
                                          if (selectedGender == null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text("select".tr()),
                                                backgroundColor: Colors.red,
                                                duration:
                                                    const Duration(seconds: 5),
                                              ),
                                            );
                                            return;
                                          } else {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) => SignUp2(
                                                        name: name.text,
                                                        gender:
                                                            selectedGender!)));
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
