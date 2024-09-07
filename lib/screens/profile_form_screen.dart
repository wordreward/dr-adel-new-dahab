import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/constant/routes.dart';
import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/data/models/login_model.dart';
import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:adelnewversion/screens/widgets/app_bar.dart';
import 'package:adelnewversion/screens/widgets/form_input_field.dart';
import 'package:adelnewversion/screens/widgets/loading_indecator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileFormScreen extends StatefulWidget {
  const ProfileFormScreen({super.key});

  @override
  State<ProfileFormScreen> createState() => _ProfileFormScreenState();
}

class _ProfileFormScreenState extends State<ProfileFormScreen> {
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  String? selectedGender;
  LoginModel? model;
  String? nameS;
  String? emailS;
  String? genderS;
  dynamic image;
  @override
  void initState() {
    model = BlocProvider.of<AppCubit>(context).loginModel;
    //image = "";
    // name.text = 'ss';
    // email.text = model!.user!.email!;
    // genderS = "male";
    image = model!.user!.photo ?? "";
    name.text = model!.user!.name ?? '';
    email.text = model!.user!.email!;
    genderS = model!.user!.gender ?? "male";
    _selectedDate =
        DateFormat('yyyy-MM-dd', 'en').parse(model!.user!.birthdate!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var mainWidgetH = h * 0.45;
    return Scaffold(
      body: BlocConsumer<AppCubit, AppState>(listener: (context, state) {
        if (state is UpdateLoading) {
          LoadingScreen.show(context);
        }
        if (state is UpdateSuccess) {
          LoadingScreen.pop(context);
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.navBarRoute, (route) => false);
        }
        if (state is UpdateError) {
          LoadingScreen.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
              duration: const Duration(seconds: 5),
            ),
          );
        }
      }, builder: (context, state) {
        var image = BlocProvider.of<AppCubit>(context).image;
        _birthdayController.text =
            DateFormat('yyyy-MM-dd', 'en').format(_selectedDate!);
        genderS == 'male'
            ? BlocProvider.of<AppCubit>(context).selectedGender(0)
            : BlocProvider.of<AppCubit>(context).selectedGender(1);

        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Appbar(
                title: 'Update Profile'.tr(),
                showBackButton: true,
                topPadding: true,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        BlocProvider.of<AppCubit>(context).image == null
                            ? CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.grey,
                                child: Image.network(
                                  "model!.user!.photo!",
                                  // model!.user!.photo!,
                                  fit: BoxFit.cover,
                                  height: 70.0,
                                  width: 70.0,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Container(
                                      color: Colors.grey,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(11.0),
                                        child: Image.asset(
                                          'assets/images/no-user.png',
                                          fit: BoxFit.cover,
                                          height: 70.0,
                                          width: 70.0,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              )
                            : CircleAvatar(
                                radius: 55,
                                backgroundColor: Colors.grey,
                                child: Image.file(
                                  BlocProvider.of<AppCubit>(context).image!,
                                  fit: BoxFit.cover,
                                  height: 70.0,
                                  width: 70.0,
                                ),
                              ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () =>
                              BlocProvider.of<AppCubit>(context).pickImage(),
                          child: Text(
                            'Change Photo'.tr(),
                            style: const TextStyle(
                                fontSize: 16, color: primaryTextColor),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      padding: const EdgeInsets.only(
                        right: 20,
                        left: 20,
                      ),
                      height: mainWidgetH,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                              right: 20,
                            ),
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: Column(
                              children: [
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          FormInputField(
                                            controller: name,
                                            prefixText: 'Name'.tr(),
                                            color: primaryTextColor,
                                            validator: (v) {
                                              if (v == '') {
                                                return 'enter your name';
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                border: Border.all(
                                                    color: primaryTextColor)),
                                            height: h * 0.08,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    BlocProvider.of<AppCubit>(
                                                            context)
                                                        .selectedGender(0);
                                                    setState(() {
                                                      genderS = 'male';
                                                    });
                                                    BlocProvider.of<AppCubit>(
                                                                context)
                                                            .gender[0]
                                                        ? selectedGender =
                                                            'male'
                                                        : selectedGender =
                                                            'female';
                                                  },
                                                  child: Container(
                                                    height: h * 0.08,
                                                    width: w * 0.395,
                                                    decoration: BoxDecoration(
                                                        color: // BlocProvider.of<AppCubit>(context).gender[0] ? primaryComponent :
                                                            primaryComponentColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight: context
                                                                      .locale
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? const Radius
                                                                  .circular(10)
                                                              : const Radius
                                                                  .circular(0),
                                                          bottomRight: context
                                                                      .locale
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? const Radius
                                                                  .circular(10)
                                                              : const Radius
                                                                  .circular(0),
                                                          bottomLeft: context
                                                                      .locale
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? const Radius
                                                                  .circular(0)
                                                              : const Radius
                                                                  .circular(10),
                                                          topLeft: context
                                                                      .locale
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? const Radius
                                                                  .circular(0)
                                                              : const Radius
                                                                  .circular(10),
                                                        )),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.male,
                                                          color:
                                                              primaryBackgroundColor,
                                                        ),
                                                        Text(
                                                          'Male'.tr(),
                                                          style: TextStyle(
                                                              color:
                                                                  primaryBackgroundColor,
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    BlocProvider.of<AppCubit>(
                                                            context)
                                                        .selectedGender(1);
                                                    setState(() {
                                                      genderS = 'female';
                                                    });
                                                    BlocProvider.of<AppCubit>(
                                                                context)
                                                            .gender[0]
                                                        ? selectedGender =
                                                            'male'
                                                        : selectedGender =
                                                            'female';
                                                  },
                                                  child: Container(
                                                    height: h * 0.08,
                                                    width: w * 0.395,
                                                    decoration: BoxDecoration(
                                                        color: //BlocProvider.of<AppCubit>(context).gender[1] ? primaryComponent :
                                                            secondComponentColor,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topRight: context
                                                                      .locale
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? const Radius
                                                                  .circular(0)
                                                              : const Radius
                                                                  .circular(10),
                                                          bottomRight: context
                                                                      .locale
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? const Radius
                                                                  .circular(0)
                                                              : const Radius
                                                                  .circular(10),
                                                          bottomLeft: context
                                                                      .locale
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? const Radius
                                                                  .circular(10)
                                                              : const Radius
                                                                  .circular(0),
                                                          topLeft: context
                                                                      .locale
                                                                      .languageCode ==
                                                                  'ar'
                                                              ? const Radius
                                                                  .circular(10)
                                                              : const Radius
                                                                  .circular(0),
                                                        )),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.female,
                                                          color:
                                                              primaryBackgroundColor,
                                                        ),
                                                        Text(
                                                          'Female'.tr(),
                                                          style: TextStyle(
                                                              color:
                                                                  primaryBackgroundColor,
                                                              fontSize: 16),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: h * 0.02,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                  if (!_formKey.currentState!
                                                      .validate()) {
                                                    return;
                                                  } else {
                                                    _formKey.currentState!
                                                        .save();
                                                    // print(mobile);
                                                    BlocProvider.of<AppCubit>(
                                                            context)
                                                        .updateProfile(
                                                            name.text,
                                                            // _birthdayController
                                                            //     .text,
                                                            '',
                                                            // email.text,
                                                            genderS!,
                                                            email.text,
                                                            _birthdayController
                                                                .text);
                                                    //     .text,);
                                                  }
                                                },
                                                child: Container(
                                                  width: 150,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    color: secondComponentColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Text(
                                                        'Save'.tr(),
                                                        style: Fonts()
                                                            .secondFont(
                                                                25,
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      const Icon(
                                                        Icons.arrow_forward_ios,
                                                        color: secondTextColor,
                                                        size: 25,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            )),
                      )),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  DateTime? _selectedDate;
  final TextEditingController _birthdayController = TextEditingController();

  Future<void> _selectDate() async {
    var picked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1930),
      lastDate: DateTime(2012),
      dateFormat: "dd-MMMM-yyyy",
      backgroundColor: primaryComponentColor,
      textColor: Colors.white,
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthdayController.text =
            DateFormat('yyyy-MM-dd', 'en').format(_selectedDate!);
      });
    }
  }
}
