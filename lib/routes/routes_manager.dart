import 'package:adelnewversion/business_logic/app_cubit/app_cubit.dart';
import 'package:adelnewversion/screens/about_app_screen.dart';
import 'package:adelnewversion/screens/auth%20copy/auth.dart';
import 'package:adelnewversion/screens/auth/login_screen.dart';
import 'package:adelnewversion/screens/auth/signup/create_account_screen.dart';
import 'package:adelnewversion/screens/auth/signup/google_calender.dart';
import 'package:adelnewversion/screens/auth/signup/otp.dart';
import 'package:adelnewversion/screens/auth/signup/referral_code.dart';
import 'package:adelnewversion/screens/booking.dart';
import 'package:adelnewversion/screens/branches_screen.dart';
import 'package:adelnewversion/screens/intro_screen.dart';
import 'package:adelnewversion/screens/navigation_bar/nav_bar_screen.dart';
import 'package:adelnewversion/screens/profile_form_screen.dart';
import 'package:adelnewversion/screens/transfer_screen.dart';
import 'package:flutter/material.dart';


class Routes {
  static const String introRoute = "/";
  static const String logInRoute = "/LogIn";
  static const String createAccountRoute = "/createAccount";
  static const String referralRoute = "/referral";
  static const String gmailRoute = "/gmail";
  static const String otpRoute = "/otp";
  static const String navBarRoute = "/navBar";
  // static const String bookingRoute = "/booking";
  static const String transferRoute = "/transfer";
  static const String profileRoute = "/profile";
  static const String aboutRoute = "/aboutRoute";
  static const String brancesRoute = "/branchesRoute";
}


class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.introRoute:
        return MaterialPageRoute(builder: (_) =>   LoginScreen());
        // return MaterialPageRoute(builder: (_) =>  const IntroScreen());
      case Routes.createAccountRoute:
        return MaterialPageRoute(builder: (_) =>  const CreateAccount());
      case Routes.logInRoute:
        return MaterialPageRoute(builder: (_) =>  const Login());
      case Routes.referralRoute:
        return MaterialPageRoute(builder: (_) =>  const ReferralCode());
      case Routes.gmailRoute:
        return MaterialPageRoute(builder: (_) =>  const GoogleCalender());
      case Routes.otpRoute:
        return MaterialPageRoute(builder: (_) =>  const Otp());
      case Routes.navBarRoute:
        return MaterialPageRoute(builder: (_) =>  const NavBarScreen());
      // case Routes.bookingRoute:
      //   return MaterialPageRoute(builder: (_) =>  const Booking());
      case Routes.transferRoute:
        return MaterialPageRoute(builder: (_) =>  const TransferScreen());
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (_) =>  const ProfileFormScreen());
      case Routes.aboutRoute:
        return MaterialPageRoute(builder: (_) =>  const AboutAppScreen());
      case Routes.brancesRoute:
        return MaterialPageRoute(builder: (_) =>  const BranchesScreen());
      default:
        return unDefinedRoute(settings.name);
    }
  }

  static Route<dynamic> unDefinedRoute(name) {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
            appBar: AppBar(
              title: const Text("error page directory "),
            ),
            body: Center(child: Text("error page directory $name"),
            ) ));
  }
}
