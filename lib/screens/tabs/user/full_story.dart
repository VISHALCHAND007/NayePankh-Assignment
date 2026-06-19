import 'package:flutter/material.dart';
import 'package:nayepankh_app/models/admin/post_model.dart';
import 'package:nayepankh_app/widgets/story/comment_item.dart';
import 'package:readmore/readmore.dart';

import '../../../helpers/firestore_helper.dart';
import '../../../helpers/formatters/custom_formatter.dart';

class FullStory extends StatelessWidget {
  const FullStory({
    super.key,
    required this.postId,
    required this.onLikeClicked,
  });

  final String postId;
  final void Function(PostModel) onLikeClicked;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final keyboardPadding = MediaQuery.of(context).viewInsets;
    final controller = TextEditingController();

    void postComment() async {
      if (controller.text.isNotEmpty) {
        FocusScope.of(context).unfocus();
        await FirestoreHelper.addComment(postId, controller.text);
        controller.text = '';
      }
    }

    return Scaffold(
      body: StreamBuilder(
        stream: FirestoreHelper.getPost(postId),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Text("Error:: ${snapshot.error}");
          }
          final postModel = snapshot.data!;
          final isLikedByUser = postModel.likes.contains(
            FirestoreHelper.auth.currentUser?.uid,
          );
          return SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: .fromLTRB(10, 10, 10, keyboardPadding.bottom + 80),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Image.network(
                      postModel.imageUrl,
                      width: .infinity,
                      height: 280,
                      fit: .cover,
                    ),
                    const SizedBox(height: 25),
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
                    const SizedBox(height: 15),
                    ReadMoreText(
                      postModel.description,
                      trimLines: 4,
                      trimMode: .Line,
                      trimExpandedText: ' Show less',
                      trimCollapsedText: ' Show more',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 16,
                      ),
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
                          onPressed: () {},
                          icon: const Icon(Icons.comment),
                        ),
                        Text(
                          postModel.comments.length.toString(),
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    //comments
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      reverse: true,
                      itemCount: postModel.comments.length,
                      itemBuilder: (ctx, ind) =>
                          CommentItem(comment: postModel.comments[ind]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      resizeToAvoidBottomInset: true,
      //widget for creating comments
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: .fromLTRB(15, 5, 15, keyboardPadding.bottom + 10),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hint: Text(
                      'Add a comment...',
                      style: TextStyle(color: Colors.blueGrey),
                    ),
                  ),
                ),
              ),
              ElevatedButton(onPressed: postComment, child: const Text('Post')),
            ],
          ),
        ),
      ),
    );
  }
}
