import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:nayepankh_app/helpers/enums/category.dart';
import 'package:nayepankh_app/helpers/firestore_helper.dart';
import 'package:nayepankh_app/models/admin/post_model.dart';
import 'package:nayepankh_app/widgets/cards/admin_page_card_info.dart';

class PostTab extends StatefulWidget {
  const PostTab({super.key});

  @override
  State<PostTab> createState() => _PostTabState();
}

class _PostTabState extends State<PostTab> {
  //values
  final formKey = GlobalKey<FormState>();
  late String title;
  late String description;
  late String imageUrl;
  Category category = Category.infrastructure;
  late String photoUri;
  var isLoading = false;

  void _publishPost() async {
    try {
      setState(() {
        isLoading = true;
      });
      final post = PostModel(
        title: title,
        category: category,
        description: description,
        imageUrl: imageUrl,
      );
      await FirestoreHelper.postStory(post);
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      if (kDebugMode) {
        print('Error while publishing:: $e');
      }
    }
  }

  void _validateForm() {
    final isValid = formKey.currentState?.validate();
    if (isValid != null && isValid) {
      formKey.currentState?.save();

      _publishPost();
    }
  }

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.of(context).viewInsets.bottom;
    final theme = Theme.of(context);

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: .fromLTRB(20, 20, 20, safePadding + 20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    const SizedBox(height: 10),
                    const Row(
                      mainAxisSize: .max,
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        AdminPageCardInfo(
                          title: '₹ 1.2L',
                          subTitle: 'Total raised',
                        ),
                        AdminPageCardInfo(
                          title: '12',
                          subTitle: 'Stories posted',
                        ),
                        AdminPageCardInfo(title: '456', subTitle: 'Donors'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Post a new story-',
                      style: theme.textTheme.headlineSmall,
                    ),

                    const SizedBox(height: 10),
                    Text('Story title', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 5),
                    TextFormField(
                      key: const ValueKey('title'),
                      onSaved: (value) {
                        if (value != null) title = value;
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length <= 10) {
                          return 'Title can be at least 10 characters long';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text('Category', style: theme.textTheme.bodyLarge),
                        const SizedBox(width: 20),
                        DropdownButton<Category>(
                          underline: const SizedBox(),
                          value: category,
                          items: Category.values
                              .map(
                                (cat) => DropdownMenuItem<Category>(
                                  value: cat,
                                  child: Text(cat.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) return;
                            setState(() {
                              category = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    const SizedBox(height: 20),
                    Text('Description', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 5),
                    TextFormField(
                      key: const ValueKey('desc'),
                      maxLines: 2,
                      onSaved: (value) {
                        if (value != null) description = value;
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length <= 50) {
                          return 'Description can be at least 50 characters long';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),
                    Text('Image URL', style: theme.textTheme.bodyLarge),
                    const SizedBox(height: 5),
                    TextFormField(
                      key: const ValueKey('url'),
                      onSaved: (value) {
                        if (value != null) imageUrl = value;
                      },
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('/')) {
                          return 'Enter a valid url of the image';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),
                    SizedBox(
                      width: .infinity,
                      child: ElevatedButton(
                        onPressed: _validateForm,
                        child: Text(
                          'Publish Story',
                          style: theme.textTheme.bodyLarge,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
