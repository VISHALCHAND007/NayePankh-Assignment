import 'package:flutter/material.dart';
import 'package:nayepankh_app/screens/tabs/admin/donors_tab.dart';
import 'package:nayepankh_app/screens/tabs/admin/post_tab.dart';
import 'package:nayepankh_app/widgets/appbar/custom_app_bar.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  var selectedTabInd = 0;

  @override
  Widget build(BuildContext context) {
    final tabItems = [
      const BottomNavigationBarItem(icon: Icon(Icons.post_add), label: 'Post'),
      const BottomNavigationBarItem(
        icon: Icon(Icons.currency_rupee),
        label: 'Donors',
      ),
    ];

    final screens = [const PostTab(), const DonorsTab()];
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Admin Dashboard',
        subTitle: 'Post & Manage Stories',
      ),
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
