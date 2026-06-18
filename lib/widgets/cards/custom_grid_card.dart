import 'package:flutter/material.dart';

class CustomGridCard extends StatelessWidget {
  const CustomGridCard({
    super.key,
    required this.title,
    required this.donors,
    required this.amount,
  });

  final String title;
  final int donors;
  final String amount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const .all(10),
      child: Padding(
        padding: const .all(10),
        child: GridTile(
          child: Center(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: [
                Text(title, style: theme.textTheme.titleLarge),
                Text(
                  'Donors: $donors',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'Total: $amount',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
