import 'package:flutter/material.dart';

class DonateTab extends StatelessWidget {
  const DonateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SafeArea(
        child: Column(
          children: [
            Image.network(
              'https://thumbs.dreamstime.com/b/american-football-referee-calling-time-out-american-football-referee-calling-time-out-vector-isolated-white-115202870.jpg',
              width: .infinity,
              height: 450,
            ),
            const SizedBox(height: 20),
            Text(
              'Un-implemented due to shortage of time!',
              textAlign: .center,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
