import 'package:flutter/material.dart';

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
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
