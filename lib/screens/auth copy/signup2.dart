import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/constant/routes.dart';
import 'package:adelnewversion/core/theme/colors.dart';
import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:adelnewversion/screens/auth%20copy/signup3.dart';
import 'package:adelnewversion/screens/widgets/form_input_field.dart';
import 'package:adelnewversion/screens/widgets/loading_indecator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';

class SignUp2 extends StatefulWidget {
  SignUp2({Key? key, required this.name, required this.gender})
      : super(key: key);

  String name;
  String gender;

  @override
  State<SignUp2> createState() => _SignUp2State();
}

class _SignUp2State extends State<SignUp2> {
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
            style: const TextStyle(color: titleTextColor),
          ),
          //automaticallyImplyLeading: false,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
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
                                      controller: email,
                                      color: primaryTextColor,
                                      keyboardType: TextInputType.emailAddress,
                                      prefixText: 'email'.tr(),
                                      validator: (v) {
                                        if (v == '') {
                                          return 'enter your email';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  SizedBox(
                                    height: h * 0.02,
                                  ),
                                  InkWell(
                                    onTap: _selectDate,
                                    child: Container(
                                      width: w,
                                      height: h * 0.07,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: primaryComponentColor,
                                          ),
                                          color: Colors.white.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: context.locale.languageCode !=
                                                'ar'
                                            ? const EdgeInsets.only(left: 18.0)
                                            : const EdgeInsets.only(
                                                right: 18.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'birth_date'.tr(),
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: primaryTextColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(
                                              width: w * 0.05,
                                            ),
                                            Text(
                                              _birthdayController.text,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: primaryTextColor,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                                            _formKey.currentState!.save();
                                            if (_birthdayController.text ==
                                                '') {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text("select".tr()),
                                                  backgroundColor: Colors.red,
                                                  duration: const Duration(
                                                      seconds: 5),
                                                ),
                                              );
                                              return;
                                            } else {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => SignUp3(
                                                            email: email.text,
                                                            date:
                                                                _birthdayController
                                                                    .text,
                                                            name: widget.name,
                                                            gander:
                                                                widget.gender,
                                                          )));
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

  DateTime? _selectedDate;
  final TextEditingController _birthdayController = TextEditingController();

  Future<void> _selectDate() async {
    var picked = await DatePicker.showSimpleDatePicker(
      context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1930),
      lastDate: DateTime(2012),
      dateFormat: "dd-MMMM-yyyy",
      backgroundColor: primaryComponentColor.withOpacity(0.6),
      textColor: Colors.white,
      locale: DateTimePickerLocale.en_us,
      looping: true,
    );
    print(picked);
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthdayController.text =
            DateFormat('yyyy-MM-dd', 'en').format(_selectedDate!);
      });
    }
    print(_selectedDate);
    print(_birthdayController.text);
  }
}
