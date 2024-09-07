import 'package:adelnewversion/screens/navigation_bar/tab_navigator.dart';
import 'package:adelnewversion/screens/widgets/icons/my_flutter_app_icons.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/core.dart';

class NavBarScreen extends StatefulWidget {
  const NavBarScreen({super.key});

  @override
  State<NavBarScreen> createState() => _NavBarScreenState();
}

class _NavBarScreenState extends State<NavBarScreen> {
  String _currentTab = "home";
  int _selectedIndex = 0;
  List<String> pageKeys=["home","loyalty","profile"];
  Map<String,GlobalKey<NavigatorState>> _navigatorKeys={
    "home":GlobalKey<NavigatorState>(),
    "loyalty":GlobalKey<NavigatorState>(),
    "profile":GlobalKey<NavigatorState>(),
  };

  void _selectTap(String tabItem,int index){
    if(tabItem ==_currentTab){
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    }else{
      setState(() {
        _currentTab = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        final isFirstRouteInCurrentTab=!await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if(isFirstRouteInCurrentTab){
          if(_currentTab != "home"){
            _selectTap("home", 0);
            return false;
          }
        }
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
          children: [
            _buildOffstageNavigator("home",()=>_selectTap(pageKeys[1], 1)),
            _buildOffstageNavigator("loyalty",()=>_selectTap(pageKeys[1], 1)),
            _buildOffstageNavigator("profile",()=>_selectTap(pageKeys[1], 1)),
          ],
        ),

        bottomNavigationBar: Container(
          margin: const EdgeInsets.only(bottom: 25,top: 10,left: 15,right: 15),
          height: MediaQuery.of(context).size.height*0.075,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: BottomNavigationBar(
              backgroundColor: secondComponentColor,
              showUnselectedLabels: true,
              // This is all you need!
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  backgroundColor: secondComponentColor,
                  icon: const Icon(
                    Icons.house_rounded,
                    size: 30,
                  ),
                  label: 'HOME'.tr(),
                ),
                BottomNavigationBarItem(
                  backgroundColor: secondComponentColor,
                  icon: const Icon(
                    MyFlutterApp.award_1,
                    size: 30,
                  ),
                  label: 'LOYALTY'.tr(),
                ),
                BottomNavigationBarItem(
                  backgroundColor: secondComponentColor,
                  icon: const Icon(
                    Icons.settings,
                    size: 30,
                  ),
                  label: 'Settings title'.tr(),
                ),
              ],
              currentIndex:  _selectedIndex,
              selectedItemColor:  primaryBackgroundColor,
              selectedLabelStyle: GoogleFonts.inter(
                color: primaryTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: GoogleFonts.inter(
                color: primaryTextColor,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              unselectedItemColor: Color(0xffBCBCBC),
              onTap: (i){
                _selectTap(pageKeys[i], i);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem,Function selectLoyalityTab){
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        selectLoyalityTab: () {
          selectLoyalityTab();
        },
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
        c: context,
      ),
    );
  }
}
