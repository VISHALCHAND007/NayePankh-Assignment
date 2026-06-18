import 'package:flutter/material.dart';

import '../../helpers/firestore_helper.dart';
import '../../screens/auth_screen.dart';

class CustomAppBarHome extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarHome({
    super.key,
    required this.title,
    required this.subTitle,
    required this.usernameInitials,
  });

  final String title;
  final String subTitle;
  final String usernameInitials; //first two words from username for now

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      title: Column(
        crossAxisAlignment: .start,
        children: [
          Text(title, style: theme.textTheme.headlineSmall),
          Text(
            subTitle,
            style: theme.textTheme.labelLarge?.copyWith(color: Colors.grey),
          ),
        ],
      ),
      actions: [
        Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.secondaryContainer,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              usernameInitials.substring(0, 2).toUpperCase(),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
            ),
          ),
        ),
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
