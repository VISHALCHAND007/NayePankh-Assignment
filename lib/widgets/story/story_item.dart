import 'package:flutter/material.dart';
import 'package:nayepankh_app/helpers/formatters/custom_formatter.dart';
import 'package:nayepankh_app/models/admin/post_model.dart';
import 'package:nayepankh_app/screens/tabs/user/full_story.dart';

import '../../helpers/firestore_helper.dart';

class StoryItem extends StatelessWidget {
  const StoryItem({
    super.key,
    required this.postModel,
    required this.onLikeClicked,
  });

  final PostModel postModel;
  final void Function(PostModel) onLikeClicked;

  @override
  Widget build(BuildContext context) {
    final isLikedByUser = postModel.likes.contains(
      FirestoreHelper.auth.currentUser?.uid,
    );

    void openFullStory() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              FullStory(postId: postModel.id, onLikeClicked: onLikeClicked),
        ),
      );
    }

    final theme = Theme.of(context);

    return InkWell(
      onTap: openFullStory,
      child: Card(
        margin: const .only(bottom: 15),
        color: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(16),
        ),
        child: Padding(
          padding: const .all(2),
          child: Column(
            crossAxisAlignment: .start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadiusGeometry.only(
                  topLeft: .circular(16),
                  topRight: .circular(16),
                ),
                child: Hero(
                  tag: postModel.description,
                  child: Image.network(
                    postModel.imageUrl,
                    width: .infinity,
                    height: 180,
                    fit: .cover,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const .all(10),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Container(
                      padding: const .all(5),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onPrimaryContainer.withAlpha(
                          220,
                        ),
                        borderRadius: .circular(10),
                      ),
                      child: Text(
                        postModel.category.toString(),
                        style: TextStyle(
                          color: theme.colorScheme.primaryContainer,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(postModel.title, style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 1),
                    Row(
                      children: [
                        Text(
                          CustomFormatter.dateFormatter.format(
                            postModel.dateTime,
                          ),
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(
                          Icons.keyboard_double_arrow_right_rounded,
                          color: Colors.grey,
                        ),
                        Text(
                          'by Admin',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => onLikeClicked(postModel),
                          icon: isLikedByUser
                              ? const Icon(Icons.thumb_up)
                              : const Icon(Icons.thumb_up_alt_outlined),
                        ),
                        Text(
                          postModel.likes.length.toString(),
                          style: theme.textTheme.bodyLarge,
                        ),
                        IconButton(
                          onPressed: openFullStory,
                          icon: const Icon(Icons.comment),
                        ),
                        Text(
                          postModel.comments.length.toString(),
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
