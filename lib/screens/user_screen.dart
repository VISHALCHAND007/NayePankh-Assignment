import 'package:flutter/material.dart';
import 'package:nayepankh_app/screens/tabs/user/donate_tab.dart';
import 'package:nayepankh_app/screens/tabs/user/home_tab.dart';
import 'package:nayepankh_app/screens/tabs/user/profile_tab.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  var selectedTabInd = 0;

  void openDonationTab() {
    setState(() {
      selectedTabInd = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final tabItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.monitor_heart),
        label: 'Home',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.currency_rupee),
        label: 'Donate',
      ),
      // const BottomNavigationBarItem(
      //   icon: Icon(Icons.supervised_user_circle_outlined),
      //   label: 'Profile',
      // ),
    ];

    final screens = [
      HomeTab(openDonateTab: openDonationTab),
      const DonateTab(),
      // const ProfileTab(),
    ];
    return Scaffold(
      body: screens[selectedTabInd],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedTabInd,
        items: tabItems,
        onTap: (ind) => setState(() {
          selectedTabInd = ind;
        }),
      ),
    );
  }
}
