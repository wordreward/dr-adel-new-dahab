import 'package:adelnewversion/screens/navigation_bar/nav_bar_screens/home.dart';
import 'package:adelnewversion/screens/navigation_bar/nav_bar_screens/loyalty.dart';
import 'package:adelnewversion/screens/navigation_bar/nav_bar_screens/settings_screen.dart';
import 'package:flutter/material.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabItem;
  final BuildContext? c;
  final Function? selectLoyalityTab;
  const TabNavigator({super.key,this.navigatorKey,this.tabItem,this.c,this.selectLoyalityTab});

  @override
  Widget build(BuildContext context) {
    late Widget child;

    if(tabItem == "home"){
      child = const Home();
    }
    if(tabItem == "loyalty"){
      child = const Loyalty();
    }
    if(tabItem == "profile"){
      child = const Settings();
    }
    return Container(
      child: child,
    );

      /*Container(
      child: child,
    );*/

    /*Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child
        );
      },
    );*/
  }
}
