import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:adelnewversion/screens/booking.dart';
import 'package:adelnewversion/screens/booking_available.dart';
import 'package:adelnewversion/screens/review_us.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    BlocProvider.of<AppCubit>(context).getUserData();
    // prefs.setString('IdPhone', '');
    super.initState();
  }

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
                        top: kToolbarHeight, left: 20, right: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset(
                              'assets/images/logo.png',
                              width: 130,
                              height: 80,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(9.0),
                              child: Image.network(
                                model!.user!.photo!,
                                fit: BoxFit.cover,
                                height: 60.0,
                                width: 60.0,
                                errorBuilder: (BuildContext context,
                                    Object exception, StackTrace? stackTrace) {
                                  return Container(
                                    color: Colors.grey,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(11.0),
                                      child: Image.asset(
                                        'assets/images/no-user.png',
                                        fit: BoxFit.cover,
                                        height: 85.0,
                                        width: 85.0,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome'.tr(),
                                  style: Fonts()
                                      .primaryFont(20, FontWeight.normal),
                                ),
                                Text(
                                  model.user!.name.toString(),
                                  style:
                                      Fonts().primaryFont(20, FontWeight.w900),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      model.user!.points.toString(),
                                      style: Fonts().secondComponentFont(
                                          20, FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      'Points'.tr(),
                                      style: Fonts().secondComponentFont(
                                          20, FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 45,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {

 Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookingAvailable(),
                          ),
                        );

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //       builder: (context) => Booking(
                                  //           date: "date",
                                  //           fromTime: "fromTime",
                                  //           toTime: "toTime"),
                                  //     ));
                                  // // Navigator.pushNamed(
                                  //     context, Routes.bookingRoute);
                                },
                                child: Container(
                                  height: 160,
                                  margin: const EdgeInsets.all(3),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: primaryComponentColor,
                                    borderRadius: BorderRadius.circular(25),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        spreadRadius: 1,
                                        blurRadius: 4,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.calendar_month_outlined,
                                        color: secondTextColor,
                                        size: 55,
                                      ),
                                      Text(
                                        'Book an Appointment'.tr(),
                                        style: Fonts()
                                            .whiteFont(15, FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showBlurredBottomSheet(context);
                                    },
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: secondComponentColor,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                size: 15,
                                                color: secondTextColor,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 15,
                                                color: secondTextColor,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 15,
                                                color: secondTextColor,
                                              ),
                                              Icon(
                                                Icons.star,
                                                size: 15,
                                                color: secondTextColor,
                                              ),
                                              Icon(
                                                Icons.star_half,
                                                size: 15,
                                                color: secondTextColor,
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            'REVIEWS'.tr(),
                                            style: Fonts()
                                                .whiteFont(15, FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      // var model = BlocProvider.of<AppCubit>(context)
                                      //     .loginModel;

                                      context.locale.languageCode == 'en'
                                          ? Share.share(
                                              '${model.referrerMsgEn!.split('\\')[0]}'
                                              '\n'
                                              '${model.referrerMsgEn!.split('\\')[1]}'
                                              '\n'
                                              '${model.referrerMsgEn!.split('\\')[2]}'
                                              '\n'
                                              '${model.referrerMsgEn!.split('\\')[3]}'
                                              '\n'
                                              '${model.user!.referCode!}',
                                            )
                                          : Share.share(
                                              '${model.referrerMsgAr!.split('\\')[0]}'
                                              '\n'
                                              '${model.referrerMsgAr!.split('\\')[1]}'
                                              '\n'
                                              '${model.referrerMsgAr!.split('\\')[2]}'
                                              '\n'
                                              '${model.referrerMsgAr!.split('\\')[3]}'
                                              '\n'
                                              '${model.user!.referCode!}',
                                            );
                                    },
                                    child: Container(
                                      height: 70,
                                      decoration: BoxDecoration(
                                        color: secondComponentColor,
                                        borderRadius: BorderRadius.circular(25),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.mail_outline,
                                            size: 30,
                                            color: secondTextColor,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'Invite Friends'.tr(),
                                                  textAlign: TextAlign.center,
                                                  softWrap: true,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  style: Fonts().whiteFont(
                                                      15, FontWeight.bold),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 55,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  BlocProvider.of<AppCubit>(context)
                                      .getAboutUs();
                                  Navigator.pushNamed(
                                      context, Routes.aboutRoute);
                                },
                                child: Container(
                                  height: 70, // Set a height for the containers
                                  decoration: BoxDecoration(
                                    color: secondComponentColor,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'About Us'.tr(),
                                      style: Fonts()
                                          .whiteFont(18, FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                                width:
                                    16), // Add some space between the containers
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  if (BlocProvider.of<AppCubit>(context)
                                          .getBranchesModel !=
                                      null) {
                                    Uri enMembership = Uri.parse(
                                        BlocProvider.of<AppCubit>(context)
                                            .getBranchesModel!
                                            .branches!
                                            .first
                                            .website!);

                                    if (await canLaunchUrl(enMembership)) {
                                      launchUrl(enMembership,
                                          mode: LaunchMode.inAppWebView);
                                    }
                                  }
                                },
                                child: Container(
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: primaryComponentColor,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Our Website'.tr(),
                                      style: Fonts()
                                          .whiteFont(18, FontWeight.bold),
                                    ),
                                  ),
                                ),
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
