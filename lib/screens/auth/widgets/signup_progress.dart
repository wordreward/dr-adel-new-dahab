import 'package:adelnewversion/core/core.dart';
import 'package:adelnewversion/core/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignupProgress extends StatelessWidget{
  const SignupProgress({
    super.key,
    required this.title,
    this.showBackButton,
  });

  final String? title;
  final bool? showBackButton;
  @override
  Widget build(BuildContext context) {
    Color textColor = const Color(0xff3F465C);
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [

        Column(
          children: [
            Text(
              "Create Account",
              style: GoogleFonts.poppins(
                color: textColor,
                fontSize: 9,
                height:0.1,
                fontWeight: FontWeight.normal,
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 8,bottom: 8),
              child: Card(
                color: title == "Create Account"?primaryComponentColor:secondTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Set rounded corner radius
                  side: const BorderSide(color: primaryComponentColor, width: 1.0), // Set border color and width
                ),
                elevation: 4.0, // Add elevation to card
                child: Container(height: 10,width: 70,
                  decoration: BoxDecoration(
                    color: primaryComponentColor,
                    borderRadius: BorderRadius.circular(20.0), // Rounded corners
                  ),
                ),
              ),
            ),
          ],
        ),


        Column(
          children: [
            Text(
              "otp".toUpperCase(),
              style: GoogleFonts.inter(
                color: textColor,
                fontSize: 9,
                height:0.1,
                fontWeight: FontWeight.w300,
              ),
            ),

            Container(
              padding: const EdgeInsets.only(top: 8,bottom: 8),
              child: Card(
                color: title == "otp"||title == "Referral code"||title == "Google Calendar"?primaryComponentColor:secondTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Set rounded corner radius
                  side: BorderSide(color: title == "otp"||title == "Referral code"||title == "Google Calendar"?primaryComponentColor:secondComponentColor, width: 1.0), // Set border color and width
                ),
                elevation: 4.0, // Add elevation to card
                child: Container(height: 10,width: 70,
                  decoration: BoxDecoration(
                    color: title == "otp"||title == "Referral code"||title == "Google Calendar"?primaryComponentColor:secondTextColor, // Background color
                    borderRadius: BorderRadius.circular(20.0), // Rounded corners
                  ),
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              "Referral code",
              style: GoogleFonts.inter(
                color: textColor,
                fontSize: 9,
                height:0.1,
                fontWeight: FontWeight.w300,
              ),
            ),


            Container(
              padding: const EdgeInsets.only(top: 8,bottom: 8),
              child: Card(
                color: title == "Referral code"||title == "Google Calendar"?primaryComponentColor:secondTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Set rounded corner radius
                  side: BorderSide(color: title == "Referral code"||title == "Google Calendar"?primaryComponentColor:secondComponentColor, width: 1.0), // Set border color and width
                ),
                elevation: 4.0, // Add elevation to card
                child: Container(height: 10,width: 70,
                  decoration: BoxDecoration(
                    color: title == "Referral code"||title == "Google Calendar"?primaryComponentColor:secondTextColor,
                    borderRadius: BorderRadius.circular(20.0), // Rounded corners
                  ),
                ),
              ),
            ),
          ],
        ),

/*
        Column(
          children: [
            Text(
              "Google Calendar",
              style: GoogleFonts.inter(
                color: textColor,
                fontSize: 9,
                height:0.1,
                fontWeight: FontWeight.w300,
              ),
            ),


            Container(
              padding: const EdgeInsets.only(top: 8,bottom: 8),
              child: Card(
                color: title == "Google Calendar"?primaryComponentColor:secondTextColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Set rounded corner radius
                  side: BorderSide(color: title == "Google Calendar"?primaryComponentColor:secondComponentColor, width: 1.0), // Set border color and width
                ),
                elevation: 4.0, // Add elevation to card
                child: Container(height: 10,width: 70,
                  decoration: BoxDecoration(
                    color: title == "Google Calendar"?primaryComponentColor:secondTextColor,
                    borderRadius: BorderRadius.circular(20.0), // Rounded corners
                  ),
                ),
              ),
            ),
          ],
        ),
        */
      ],
    );
  }
}