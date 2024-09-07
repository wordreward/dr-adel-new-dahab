import 'dart:ui';

import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/constant/routes.dart';
import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

void showBlurredBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => BlurredBottomSheet(),
  );
}

class BlurredBottomSheet extends StatelessWidget {
  double rating = 5;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding:
                    const EdgeInsets.symmetric(horizontal: 35, vertical: 16),
                decoration: BoxDecoration(
                  color: primaryComponentColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RatingBar.builder(
                      initialRating: 5,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: primaryBackgroundColor,
                      ),
                      onRatingUpdate: (r) {
                        print(rating);
                        rating = r;
                      },
                    ),
                    InkWell(
                      onTap: () {
                        BlocProvider.of<AppCubit>(context).sendRate(context,
                          rate: rating,
                        );
                        //  Navigator.of(context).pop();
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 2, bottom: 2, right: 15, left: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: secondComponentColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.check,
                          color: secondTextColor,
                          size: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(16),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: primaryComponentColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Text(
                      'Review the App'.tr(),
                      style: Fonts().whiteFont(22, FontWeight.w500),
                    ),
                    Text(
                      'And earn points'.tr(),
                      style: Fonts().titleFont(22, FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
