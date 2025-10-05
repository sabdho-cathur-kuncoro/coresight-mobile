import 'package:coresight/shared/theme.dart';
import 'package:coresight/ui/pages/home/home_page.dart';
import 'package:coresight/ui/pages/home/presence_page.dart';
import 'package:coresight/ui/pages/home/profile_page.dart';
import 'package:coresight/ui/pages/home/store_visit_page.dart';
import 'package:coresight/utils/status_bar.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    setStatusBar(
      color: Colors.transparent,
      iconBrightness: Brightness.dark,
      barBrightness: Brightness.light,
    );
  }

  Widget customBottomNav() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (value) {
        setState(() {
          currentIndex = value;
        });
      },
      type: BottomNavigationBarType.fixed,
      elevation: 0,
      backgroundColor: whiteColor,
      selectedItemColor: primaryColor,
      unselectedItemColor: subtleBlueColor,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedLabelStyle: primaryTextStyle.copyWith(
        fontSize: 12,
        fontWeight: medium,
      ),
      unselectedLabelStyle: subtleBlueTextStyle.copyWith(
        fontSize: 12,
        fontWeight: medium,
      ),
      items: [
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Image.asset(
                'assets/icons/ic_home.png',
                width: 24,
                color: currentIndex == 0 ? primaryColor : subtleBlueColor,
              ),
              SizedBox(height: 4),
            ],
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Image.asset(
                'assets/icons/ic_visit.png',
                width: 26,
                color: currentIndex == 1 ? primaryColor : subtleBlueColor,
              ),
              SizedBox(height: 4),
            ],
          ),
          label: 'Visit',
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Image.asset(
                'assets/icons/ic_presence.png',
                width: 24,
                color: currentIndex == 2 ? primaryColor : subtleBlueColor,
              ),
              SizedBox(height: 4),
            ],
          ),
          label: 'Presence',
        ),
        BottomNavigationBarItem(
          icon: Column(
            children: [
              Image.asset(
                'assets/icons/ic_user.png',
                width: 20,
                color: currentIndex == 3 ? primaryColor : subtleBlueColor,
              ),
              SizedBox(height: 4),
            ],
          ),
          label: 'Profile',
        ),
      ],
    );
  }

  Widget body() {
    switch (currentIndex) {
      case 0:
        return HomePage();
      case 1:
        return StoreVisitPage();
      case 2:
        return PresencePage();
      case 3:
        return ProfilePage();
      default:
        return HomePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      bottomNavigationBar: customBottomNav(),
      body: body(),
    );
  }
}
