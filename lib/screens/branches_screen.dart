import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/screens/widgets/app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BranchesScreen extends StatelessWidget {
  const BranchesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
      // appBar: AppBar(
      //   title: Text(
      //     'About Us'.tr(),
      //     style: const TextStyle(color: Color(0xff29ABE2)),
      //   ),
      //   centerTitle: true,
      // ),
      body: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Appbar(
                    title: 'About Us'.tr(),
                    showBackButton: true,
                    topPadding: true,
                  ),
                ),
                Expanded(
                    child: BlocProvider.of<AppCubit>(context).getAboutModel ==
                            null
                        ? Center(child: CircularProgressIndicator())
                        : SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 20.0),
                              child: Text(
                                context.locale.languageCode == 'ar'
                                    ? BlocProvider.of<AppCubit>(context)
                                            .getAboutModel!
                                            .descriptionAr ??
                                        ""
                                    : BlocProvider.of<AppCubit>(context)
                                            .getAboutModel!
                                            .descriptionAr ??
                                        "",
                                style: Fonts()
                                    .secondComponentFont(20, FontWeight.w400),
                              ),
                            ),
                          )),
              ],
            );
          }),
    );
  }
}
