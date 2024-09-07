import 'dart:io';

import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:adelnewversion/screens/auth/widgets/signup_progress.dart';
import 'package:adelnewversion/screens/widgets/app_bar.dart';
import 'package:adelnewversion/screens/widgets/form_input_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final TextEditingController name = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController phone = TextEditingController();

  String selectedGender='male';

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = pickedFile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(right: 30,left: 30),
        child: Center(
          child: ListView(
            children: [
              Appbar(title: 'Sign Up'.tr(),showBackButton: true,topPadding: true,),
              const SizedBox(height: 25,),
              const SignupProgress(title: 'Create Account'),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 124,
                      height: 124,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.topLeft,
                      child: _imageFile == null
                          ? const Stack(
                        children: [
                          Icon(
                            Icons.account_box_rounded,
                            size: 135,
                            color: Colors.grey,
                          ),

                          Positioned(
                            bottom: 10,
                            right: 15,
                            child: Icon(Icons.add,color: Colors.black,size: 25,),
                          ),
                        ],
                      )
                          : ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(
                          children: [
                            Image.file(
                              File(_imageFile!.path),
                              fit: BoxFit.cover,
                              width: 124,
                              height: 124,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              FormInputField(
                controller: name,
                color: primaryTextColor,
                prefixText: 'Full Name'.tr(),
                autoFillHints: const <String>[
                  AutofillHints.name
                ],
                validator: (v) {
                  if (v == '') {
                    return 'enter your name';
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

              const SizedBox(height: 10,),
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
              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: selectedGender == 'male'
                            ? primaryComponentColor
                            : primaryBackgroundColor,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          width: 1,
                          color: selectedGender == 'male'? primaryComponentColor:secondComponentColor
                        )
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedGender = 'male';
                          });
                        },
                        child: Text(
                          'Male'.tr(),
                          style: selectedGender == 'male'?Fonts().secondFont(25, FontWeight.bold):Fonts().titleFont(25, FontWeight.bold),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: selectedGender == 'female'
                            ? primaryComponentColor
                            : primaryBackgroundColor,
                        borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              width: 1,
                              color: selectedGender == 'female'? primaryComponentColor:secondComponentColor
                          )
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            selectedGender = 'female';
                          });
                        },
                        child: Text(
                          'Female'.tr(),
                          style: selectedGender == 'female'?Fonts().secondFont(25, FontWeight.bold):Fonts().titleFont(25, FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pushNamed(context, Routes.otpRoute);
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

              const SizedBox(height: 25,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an Account?".tr(),
                    style: Fonts().primaryFont(16, FontWeight.normal),
                  ),
                  const SizedBox(width: 5,),
                  InkWell(
                    onTap: (){
                      // Navigator.pushReplacementNamed(context, auth);
                    },
                    child: Text(
                      "Log In Here!".tr(),
                      style:Fonts().titleFont(17, FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
