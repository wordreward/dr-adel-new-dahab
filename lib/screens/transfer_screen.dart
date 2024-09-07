import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/screens/widgets/app_bar.dart';
import 'package:adelnewversion/screens/widgets/form_input_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TextEditingController points = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey();
  //PhoneController phoneNumberController = PhoneController(null);
  final TextEditingController phoneNumberController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    int? availablePoints = int.parse(BlocProvider.of<AppCubit>(context)
            .loginModel!
            .user!
            .points
            .toString()) -
        200;

    return BlocConsumer<AppCubit, AppState>(listener: (context, state) {
      if (state is TransferLoading) {
        OverlayLoadingProgress.start(
          context,
          widget: Container(
            width: MediaQuery.of(context).size.width / 4,
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 13),
            child: const AspectRatio(
              aspectRatio: 1,
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          ),
        );
      }
      if (state is TransferSuccess) {
        OverlayLoadingProgress.stop();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Transfer Success'),
            backgroundColor: primaryComponentColor,
            duration: Duration(seconds: 5),
          ),
        );
      }
      if (state is TransferError) {
        OverlayLoadingProgress.stop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.message),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }, builder: (context, state) {
      return GestureDetector(
        //  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          body: Column(
            children: [
              Appbar(
                title: 'Transfer Points'.tr(),
                showBackButton: true,
                topPadding: true,
              ),
              Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(
                      left: 20, top: 20, bottom: 20, right: 0),
                  margin: const EdgeInsets.only(
                      left: 20.0, bottom: 20, right: 20, top: 0),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Available Points: '.tr(),
                              style: const TextStyle(
                                color: primaryComponentColor,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              availablePoints
                                  .toString(), //${controller.availablePoints.value}',
                              style: const TextStyle(
                                  color: primaryComponentColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Form(
                                child: FormInputField(
                                  controller: phoneNumberController,
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
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: FormInputField(
                            controller: points,
                            keyboardType: TextInputType.number,
                            prefixText: 'Points'.tr(),
                            validator: (v) {
                              if (v == '') {
                                return 'enter your points';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {
                                if (!_formKey.currentState!.validate()) {
                                  return;
                                } else {
                                  _formKey.currentState!.save();
                                  BlocProvider.of<AppCubit>(context).transfer(
                                      phoneNumberController.text!, points.text);
                                }
                              },
                              child: Container(
                                width: 150,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: secondComponentColor,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Transfer'.tr(),
                                      style: Fonts()
                                          .secondFont(25, FontWeight.bold),
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
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      );
    });
  }
}
