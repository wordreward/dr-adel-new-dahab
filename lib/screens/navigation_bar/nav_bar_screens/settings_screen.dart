import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/constant/global_var.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:adelnewversion/screens/auth%20copy/auth.dart';
import 'package:adelnewversion/screens/widgets/app_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/core.dart';

class Settings extends StatefulWidget {
  final BuildContext? c;
  const Settings({super.key, this.c});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {},
          builder: (context, state) {
            var model = BlocProvider.of<AppCubit>(context).loginModel;
            return model == null
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Column(
                      children: [
                        Appbar(
                          title: 'Settings title'.tr(),
                          showBackButton: false,
                          topPadding: true,
                          fontSize: 25,
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, Routes.profileRoute);
                              },
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.085,
                                width:
                                    (MediaQuery.of(context).size.width * 0.42),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 10,
                                  color: primaryComponentColor,
                                  child: Padding(
                                    padding: //
                                        EdgeInsets.only(
                                            left: context.locale.languageCode ==
                                                    'ar'
                                                ? 0
                                                : 12,
                                            right:
                                                context.locale.languageCode ==
                                                        'ar'
                                                    ? 12
                                                    : 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(11.0),
                                          child: Image.network(
                                            model!.user!.photo!,
                                            fit: BoxFit.cover,
                                            height: 40.0,
                                            width: 40.0,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return Container(
                                                color: Colors.grey,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          11.0),
                                                  child: Image.asset(
                                                    'assets/images/no-user.png',
                                                    fit: BoxFit.cover,
                                                    height: 40.0,
                                                    width: 40.0,
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'update profile btn'
                                                .tr()
                                                .toUpperCase(),
                                            style: Fonts()
                                                .whiteFont(14, FontWeight.bold),
                                            softWrap: true,
                                            overflow: TextOverflow.visible,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    context.setLocale(const Locale('ar', 'EG'));
                                    Navigator.pushNamed(
                                        context, Routes.navBarRoute);
                                  },
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.085,
                                    width: (MediaQuery.of(context).size.width *
                                        0.22),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1,
                                              color: secondComponentColor),
                                          borderRadius: BorderRadius.only(
                                            topRight:
                                                context.locale.languageCode ==
                                                        'ar'
                                                    ? const Radius.circular(15)
                                                    : const Radius.circular(5),
                                            topLeft:
                                                context.locale.languageCode ==
                                                        'ar'
                                                    ? const Radius.circular(5)
                                                    : const Radius.circular(15),
                                            bottomLeft:
                                                context.locale.languageCode ==
                                                        'ar'
                                                    ? const Radius.circular(5)
                                                    : const Radius.circular(15),
                                            bottomRight:
                                                context.locale.languageCode ==
                                                        'ar'
                                                    ? const Radius.circular(15)
                                                    : const Radius.circular(5),
                                          ),
                                        ),
                                        elevation: 10,
                                        color:
                                            context.locale.languageCode == 'ar'
                                                ? primaryBackgroundColor
                                                : secondComponentColor,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                context.locale.languageCode ==
                                                        'ar'
                                                    ? primaryBackgroundColor
                                                    : secondComponentColor,
                                            borderRadius: BorderRadius.only(
                                              topRight: context.locale
                                                          .languageCode ==
                                                      'ar'
                                                  ? const Radius.circular(15)
                                                  : const Radius.circular(5),
                                              topLeft: context.locale
                                                          .languageCode ==
                                                      'ar'
                                                  ? const Radius.circular(5)
                                                  : const Radius.circular(15),
                                              bottomLeft: context.locale
                                                          .languageCode ==
                                                      'ar'
                                                  ? const Radius.circular(5)
                                                  : const Radius.circular(15),
                                              bottomRight: context.locale
                                                          .languageCode ==
                                                      'ar'
                                                  ? const Radius.circular(15)
                                                  : const Radius.circular(5),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'العربية',
                                                style: context.locale
                                                            .languageCode ==
                                                        'ar'
                                                    ? Fonts().titleFont(
                                                        16, FontWeight.bold)
                                                    : Fonts().whiteFont(
                                                        16, FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    context.setLocale(const Locale('en', 'US'));
                                    Navigator.pushNamed(
                                        context, Routes.navBarRoute);
                                  },
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.085,
                                    width: (MediaQuery.of(context).size.width *
                                        0.22),
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1,
                                              color: secondComponentColor),
                                          borderRadius: BorderRadius.only(
                                            topRight:
                                                context.locale.languageCode ==
                                                        'ar'
                                                    ? const Radius.circular(5)
                                                    : const Radius.circular(15),
                                            topLeft:
                                                context.locale.languageCode ==
                                                        'ar'
                                                    ? const Radius.circular(15)
                                                    : const Radius.circular(5),
                                            bottomLeft:
                                                context.locale.languageCode ==
                                                        'ar'
                                                    ? const Radius.circular(15)
                                                    : const Radius.circular(5),
                                            bottomRight:
                                                context.locale.languageCode ==
                                                        'ar'
                                                    ? const Radius.circular(5)
                                                    : const Radius.circular(15),
                                          ),
                                        ),
                                        elevation: 10,
                                        color:
                                            context.locale.languageCode == 'en'
                                                ? primaryBackgroundColor
                                                : secondComponentColor,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                context.locale.languageCode ==
                                                        'en'
                                                    ? primaryBackgroundColor
                                                    : secondComponentColor,
                                            borderRadius: BorderRadius.only(
                                              topRight: context.locale
                                                          .languageCode ==
                                                      'ar'
                                                  ? const Radius.circular(5)
                                                  : const Radius.circular(15),
                                              topLeft: context.locale
                                                          .languageCode ==
                                                      'ar'
                                                  ? const Radius.circular(15)
                                                  : const Radius.circular(5),
                                              bottomLeft: context.locale
                                                          .languageCode ==
                                                      'ar'
                                                  ? const Radius.circular(15)
                                                  : const Radius.circular(5),
                                              bottomRight: context.locale
                                                          .languageCode ==
                                                      'ar'
                                                  ? const Radius.circular(5)
                                                  : const Radius.circular(15),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'english'.toUpperCase(),
                                                style: context.locale
                                                            .languageCode ==
                                                        'en'
                                                    ? Fonts().titleFont(
                                                        14, FontWeight.bold)
                                                    : Fonts().whiteFont(
                                                        14, FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () async {
                                Uri enMembership = Uri.parse(
                                    'https://wordreward.web.app/privacy-policy/$enName/info@wordreward.net');

                                if (await canLaunchUrl(enMembership)) {
                                  launchUrl(enMembership,
                                      mode: LaunchMode.inAppWebView);
                                }

                                // Uri enMembership = Uri.parse(model.user!.privacyPolicyUrl.toString());
                                //
                                // if (await canLaunchUrl(enMembership)) {
                                //   launchUrl(enMembership,
                                //       mode: LaunchMode.inAppWebView);
                                // }
                              },
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width:
                                    (MediaQuery.of(context).size.width * 0.44),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(15)
                                              : const Radius.circular(5),
                                      topLeft:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(5)
                                              : const Radius.circular(15),
                                      bottomLeft:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(5)
                                              : const Radius.circular(15),
                                      bottomRight:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(15)
                                              : const Radius.circular(5),
                                    ),
                                  ),
                                  elevation: 10,
                                  color: primaryComponentColor,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            context.locale.languageCode == 'ar'
                                                ? 0
                                                : 12,
                                        right:
                                            context.locale.languageCode == 'ar'
                                                ? 12
                                                : 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.lock,
                                          size: 35,
                                          color: secondTextColor,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'privacy policy btn'
                                                .tr()
                                                .toUpperCase(),
                                            style: Fonts()
                                                .whiteFont(14, FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () async {
                                Uri enMembership = Uri.parse(
                                    'https://dahabdentist.wordreward.net/terms');

                                if (await canLaunchUrl(enMembership)) {
                                  launchUrl(enMembership,
                                      mode: LaunchMode.inAppWebView);
                                }

                                // Uri enMembership = Uri.parse(model.user!.termsUrl.toString());
                                //
                                // if (await canLaunchUrl(enMembership)) {
                                //   launchUrl(enMembership,
                                //       mode: LaunchMode.inAppWebView);
                                // }
                              },
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width:
                                    (MediaQuery.of(context).size.width * 0.44),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(5)
                                              : const Radius.circular(15),
                                      topLeft:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(15)
                                              : const Radius.circular(5),
                                      bottomLeft:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(15)
                                              : const Radius.circular(5),
                                      bottomRight:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(5)
                                              : const Radius.circular(15),
                                    ),
                                  ),
                                  elevation: 10,
                                  color: primaryComponentColor,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            context.locale.languageCode == 'ar'
                                                ? 0
                                                : 12,
                                        right:
                                            context.locale.languageCode == 'ar'
                                                ? 12
                                                : 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.menu_book,
                                          size: 35,
                                          color: secondTextColor,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'terms and conditions btn'
                                                .tr()
                                                .toUpperCase(),
                                            style: Fonts()
                                                .whiteFont(14, FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (_) {
                                      return AlertDialog(
                                        title: Text('delete_account'),
                                        content: Text('delete_msg_1'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('cancel'),
                                            onPressed: () {
                                              Navigator.pop(context, false);
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              'confirm',
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context, true);
                                              BlocProvider.of<AppCubit>(context)
                                                  .deleteUser();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                              },
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width:
                                    (MediaQuery.of(context).size.width * 0.44),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(15)
                                              : const Radius.circular(5),
                                      topLeft:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(5)
                                              : const Radius.circular(15),
                                      bottomLeft:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(5)
                                              : const Radius.circular(15),
                                      bottomRight:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(15)
                                              : const Radius.circular(5),
                                    ),
                                  ),
                                  elevation: 10,
                                  color: primaryComponentColor,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            context.locale.languageCode == 'ar'
                                                ? 0
                                                : 12,
                                        right:
                                            context.locale.languageCode == 'ar'
                                                ? 12
                                                : 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.delete_forever,
                                          size: 35,
                                          color: secondTextColor,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'delete account btn'
                                                .tr()
                                                .toUpperCase(),
                                            style: Fonts()
                                                .whiteFont(14, FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                prefs.setBool("ISLOGGED", false);
                                prefs.setString('token', '');
                                FirebaseMessaging.instance.deleteToken();
                                //  RestartWidget.restartApp(context);
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()),
                                    (route) => false);
                                // Navigator.pushAndRemoveUntil(
                                //     MaterialPageRoute(
                                //         builder: (context) => LoginScreen()),
                                //     (route) => false);
                              },
                              child: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                width:
                                    (MediaQuery.of(context).size.width * 0.44),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(5)
                                              : const Radius.circular(15),
                                      topLeft:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(15)
                                              : const Radius.circular(5),
                                      bottomLeft:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(15)
                                              : const Radius.circular(5),
                                      bottomRight:
                                          context.locale.languageCode == 'ar'
                                              ? const Radius.circular(5)
                                              : const Radius.circular(15),
                                    ),
                                  ),
                                  elevation: 10,
                                  color: primaryComponentColor,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left:
                                            context.locale.languageCode == 'ar'
                                                ? 0
                                                : 12,
                                        right:
                                            context.locale.languageCode == 'ar'
                                                ? 12
                                                : 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.logout,
                                          size: 35,
                                          color: secondTextColor,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'log out btn'.tr().toUpperCase(),
                                            style: Fonts()
                                                .whiteFont(14, FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 100,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                print(BlocProvider.of<AppCubit>(context)
                                    .loginModel!
                                    .token);
                                print(BlocProvider.of<AppCubit>(context)
                                    .loginModel!
                                    .user!
                                    .id);
                              },
                              child: Image.asset(
                                'assets/images/logo.png',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
          }),
    );
  }
}
