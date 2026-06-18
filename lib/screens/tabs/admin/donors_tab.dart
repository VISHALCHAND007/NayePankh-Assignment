import 'package:flutter/material.dart';
import 'package:nayepankh_app/widgets/cards/custom_grid_card.dart';

class DonorsTab extends StatelessWidget {
  const DonorsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const .symmetric(horizontal: 20, vertical: 30),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      children: [
          CustomGridCard(title: "Girl education", donors: 10090, amount: '1.2 cr'),
          CustomGridCard(title: "Flood relief", donors: 10090, amount: '1.2 cr'),
          CustomGridCard(title: "Free medical camps", donors: 10090, amount: '1.2 cr'),
          CustomGridCard(title: "Skill training program", donors: 10090, amount: '1.2 cr')
      ],
    );
  }
}
