import 'package:flutter/material.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.comment});

  final Map<String, dynamic> comment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(20),
      ),
      child: Padding(
        padding: const .symmetric(horizontal: 15, vertical: 10),
        child: Row(
          children: [
            Text(
              '${comment['username']}~',
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black87),
            ),
            const SizedBox(width: 10),
            Text(
              '${comment['text']}',
              style: theme.textTheme.bodyLarge?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
