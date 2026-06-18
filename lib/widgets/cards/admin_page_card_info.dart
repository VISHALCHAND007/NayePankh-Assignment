import 'package:flutter/material.dart';

class AdminPageCardInfo extends StatelessWidget {
  const AdminPageCardInfo({
    super.key,
    required this.title,
    required this.subTitle,
  });

  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final width = MediaQuery.of(context).size.width;

    return Card(
      child: Container(
        width: width / 3 - 40,
        height: 130,
        padding: const .all(10),
        margin: const .only(right: 10),
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .stretch,
          children: [
            Text(
              title,
              style: theme.textTheme.headlineSmall,
              textAlign: .center,
            ),
            Text(
              subTitle,
              style: theme.textTheme.titleSmall?.copyWith(color: Colors.grey),
              textAlign: .center,
            ),
          ],
        ),
      ),
    );
  }
}
