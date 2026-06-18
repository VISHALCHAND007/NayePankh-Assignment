import 'package:flutter/material.dart';
import 'package:nayepankh_app/helpers/enums/donation_category.dart';
import 'package:nayepankh_app/helpers/formatters/custom_formatter.dart';

class DonationClip extends StatelessWidget {
  const DonationClip({
    super.key,
    required this.title,
    required this.subTitle,
    required this.goalAmount,
    required this.raisedAmount,
    required this.onDonateNowTaped,
  });

  final String title;
  final String subTitle;
  final double goalAmount;
  final double raisedAmount;
  final void Function(DonationCategory) onDonateNowTaped;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progressBarValue = raisedAmount / goalAmount * 10;

    return Padding(
      padding: const .symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(color: Colors.grey),
          ),
          Text(subTitle, style: theme.textTheme.bodyLarge),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Text(
                '${CustomFormatter.currencyFormatter.format(raisedAmount)} raised',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
              Text(
                '${CustomFormatter.currencyFormatter.format(goalAmount)} goal',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),

          LinearProgressIndicator(
            value: progressBarValue,
            minHeight: 10,
            borderRadius: BorderRadius.circular(5),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => onDonateNowTaped(DonationCategory.floodRelief),
            child: const Text('Donate now'),
          ),
        ],
      ),
    );
  }
}
