import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:adelnewversion/routes/routes_manager.dart';
import 'package:adelnewversion/screens/booking.dart';
import 'package:adelnewversion/screens/booking_available.dart';
import 'package:adelnewversion/screens/review_us.dart';
import 'package:adelnewversion/screens/vouchers_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class Loyalty extends StatefulWidget {
  const Loyalty({super.key});

  @override
  State<Loyalty> createState() => _LoyaltyState();
}

class _LoyaltyState extends State<Loyalty> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          var model = BlocProvider.of<AppCubit>(context).loginModel;

          return model == null
              ? Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.only(
                      right: 20, left: 20, top: kToolbarHeight),
                  child: ListView(
                    padding: const EdgeInsets.all(0),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 160,
                            child: Text(
                              'Loyalty Program'.tr(),
                              style: Fonts().titleFont(25, FontWeight.bold),
                            ),
                          ),
                          Image.asset(
                            'assets/images/logo.png',
                            width: 130,
                            height: 80,
                          ),
                        ],
                      ),
                      Card(
                        elevation: 5,
                        color: primaryComponentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Container(
                          padding: const EdgeInsets.only(
                              left: 5, right: 15, bottom: 5, top: 5),
                          child: ListTile(
                              title: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.7,
                                child: Row(
                                  children: [
                                    Text(model!.user!.points.toString(),
                                        style: Fonts()
                                            .whiteFont(45, FontWeight.bold)),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text('Points'.tr(),
                                        style: Fonts()
                                            .whiteFont(25, FontWeight.normal)),
                                  ],
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const VouchersScreen()));
                                },
                                icon: const Icon(
                                  Icons.info,
                                  color: secondTextColor,
                                  size: 35,
                                ),
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(
                                'ALL POINTS'.tr(),
                                style: GoogleFonts.inter(
                                  color: primaryComponentColor,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                model!.user!.totalPoints.toString(),
                                style: GoogleFonts.inter(
                                  color: primaryComponentColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'USED POINTS'.tr(),
                                style: GoogleFonts.inter(
                                  color: primaryComponentColor,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                model!.user!.redeemedPoints.toString(),
                                style: GoogleFonts.inter(
                                  color: primaryComponentColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              Text(
                                'LEVEL POINTS'.tr(),
                                style: GoogleFonts.inter(
                                  color: primaryComponentColor,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                model!.user!.levelPoints.toString(),
                                style: GoogleFonts.inter(
                                  color: primaryComponentColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(
                        color: primaryComponentColor,
                        thickness: 1,
                        endIndent: 10,
                        indent: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: RichText(
                          text: TextSpan(
                            text: 'EARN'.tr(),
                            style: Fonts()
                                .secondComponentFont(24, FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: '  ' + 'MORE POINTS'.tr(),
                                style: Fonts()
                                    .secondComponentFont(12, FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              //  context.locale.languageCode == 'en' ? Share.share(model!.user!.referrerMsgEn!) :
                              //  Share.share(model!.user!.referrerMsgAr!);
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.9,
                              height:
                                  MediaQuery.of(context).size.height * 0.145,
                              //padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8,top: 4),
                              margin: const EdgeInsets.all(8),
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                onTap: () {
                                  // var model =
                                  //     BlocProvider.of<AppCubit>(context)
                                  //         .loginModel;

                                  context.locale.languageCode == 'en'
                                      ? Share.share(
                                          '${model!.referrerMsgEn!.split('\\')[0]}'
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
                                          '${model!.referrerMsgAr!.split('\\')[0]}'
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
                                child: Card(
                                  color: primaryComponentColor,
                                  elevation: 10,
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 35, top: 5, right: 10),
                                              child: Row(
                                                children: [
                                                  const Icon(
                                                    Icons.mail_rounded,
                                                    color: secondTextColor,
                                                    size: 45,
                                                  ),
                                                  Text(
                                                    '  ' +
                                                        "Invite friends".tr(),
                                                    style: Fonts().whiteFont(
                                                        18, FontWeight.bold),
                                                  ),
                                                ],
                                              )),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 35, bottom: 5, right: 10),
                                            child: Text(
                                              "You'll earn points for every payment they make"
                                                  .tr(),
                                              style: Fonts().whiteFont(
                                                  15, FontWeight.w300),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),
                              Card(
                                elevation: 10,
                                color: secondComponentColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.42,
                                  height:
                                      MediaQuery.of(context).size.height * 0.13,
                                  padding: const EdgeInsets.all(3),
                                  margin: const EdgeInsets.all(0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Stack(
                                    children: [
                                      Column(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.only(
                                                left: 25, top: 10, right: 10),
                                            child: Text(
                                              "Interact on social media".tr(),
                                              style: Fonts().whiteFont(
                                                  14, FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                              padding: const EdgeInsets.only(
                                                  left: 25, top: 10, right: 10),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      if (BlocProvider.of<
                                                                      AppCubit>(
                                                                  context)
                                                              .getBranchesModel !=
                                                          null) {
                                                        Uri enMembership = Uri
                                                            .parse(BlocProvider
                                                                    .of<AppCubit>(
                                                                        context)
                                                                .getBranchesModel!
                                                                .branches!
                                                                .first
                                                                .facebook!);

                                                        if (await canLaunchUrl(
                                                            enMembership)) {
                                                          launchUrl(
                                                              enMembership,
                                                              mode: LaunchMode
                                                                  .inAppWebView);
                                                        }
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                      'assets/images/face.svg',
                                                      width: 30,
                                                      height: 30,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors.white,
                                                              BlendMode.srcIn),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      if (BlocProvider.of<
                                                                      AppCubit>(
                                                                  context)
                                                              .getBranchesModel !=
                                                          null) {
                                                        Uri enMembership = Uri
                                                            .parse(BlocProvider
                                                                    .of<AppCubit>(
                                                                        context)
                                                                .getBranchesModel!
                                                                .branches!
                                                                .first
                                                                .instagram!);

                                                        if (await canLaunchUrl(
                                                            enMembership)) {
                                                          launchUrl(
                                                              enMembership,
                                                              mode: LaunchMode
                                                                  .inAppWebView);
                                                        }
                                                      }
                                                    },
                                                    child: SvgPicture.asset(
                                                      'assets/images/insta.svg',
                                                      width: 30,
                                                      height: 30,
                                                      colorFilter:
                                                          ColorFilter.mode(
                                                              Colors.white,
                                                              BlendMode.srcIn),
                                                    ),
                                                  ),
                                                  // Image.asset(
                                                  //   'assets/images/face.png',
                                                  //   color: Colors.white,
                                                  //   width: 30,
                                                  //   height: 30,
                                                  // ),
                                                  // Image.asset(
                                                  //   'assets/images/insta.png',
                                                  //   // color: Colors.white,
                                                  //   width: 30,
                                                  //   height: 30,
                                                  // ),
                                                  // Image.asset(
                                                  //   'assets/images/website.jpg',
                                                  //   color: Colors.white,
                                                  //   width: 30,
                                                  //   height: 30,
                                                  // ),
                                                ],
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      showBlurredBottomSheet(context);
                                    },
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.068,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Card(
                                        elevation: 10,
                                        color: secondComponentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
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
                                            Text(
                                              'REVIEW us'.tr(),
                                              style: Fonts().whiteFont(
                                                  14, FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BookingAvailable(),
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
                                      // Navigator.pushNamed(
                                      //     context, Routes.bookingRoute);
                                      //Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Booking()));
                                    },
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.068,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: Card(
                                        elevation: 10,
                                        color: secondComponentColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.calendar_month_rounded,
                                              size: 22,
                                              color: secondTextColor,
                                            ),
                                            Text(
                                              '  ' + 'BOOK NOW'.tr(),
                                              style: Fonts().whiteFont(
                                                  14, FontWeight.bold),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 35,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(left: 30, right: 30),
                        child: RichText(
                          text: TextSpan(
                            text: 'USE'.tr(),
                            style: Fonts()
                                .secondComponentFont(24, FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: '  ' + 'YOUR POINTS'.tr(),
                                style: Fonts()
                                    .secondComponentFont(12, FontWeight.normal),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                  context, Routes.transferRoute);
                            },
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              elevation: 10,
                              color: primaryComponentColor,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                padding: const EdgeInsets.all(8),
                                margin: const EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //const Icon(Icons.ac_unit,color: primaryText,size: 30,),
                                    Image.asset(
                                      'assets/images/wordreward.png',
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.fitWidth,
                                    ),
                                    Expanded(
                                      child: Text(
                                          "Transfer Points".tr().toUpperCase(),
                                          style: Fonts()
                                              .whiteFont(15, FontWeight.w300)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
        });
  }
}
