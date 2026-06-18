import 'package:flutter/material.dart';

import '../../helpers/firestore_helper.dart';
import '../../screens/auth_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, required this.subTitle});

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Column(
        crossAxisAlignment: .start,
        children: [
          Text(title, style: theme.textTheme.headlineMedium),
          Text(
            subTitle,
            style: theme.textTheme.labelLarge?.copyWith(color: Colors.grey),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {
            FirestoreHelper.auth.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const AuthScreen()),
            );
          },
          icon: const Icon(Icons.logout),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
