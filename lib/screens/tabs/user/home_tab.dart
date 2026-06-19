import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:nayepankh_app/helpers/firestore_helper.dart';
import 'package:nayepankh_app/widgets/story/story_item.dart';

import '../../../helpers/shared_preferences.dart';
import '../../../models/admin/post_model.dart';
import '../../../widgets/appbar/custom_app_bar_home.dart';
import '../../../widgets/donations/donation_clip.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key, required this.openDonateTab});

  final void Function() openDonateTab;

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {

  void likePost(PostModel postModel) async {
    try {
      await FirestoreHelper.toggleLike(postModel.id, postModel.likes);
    } catch (e) {
      if (kDebugMode) print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: .start,
      children: [
        CustomAppBarHome(
          title: 'NayePankh Foundations',
          subTitle: 'Making lives better',
          usernameInitials:
              CustomSharedPreferences.instance.getString('username') ??
              'Unknown',
        ),
        DonationClip(
          title: 'Monsoon relief fund',
          subTitle: 'Help flood victims today',
          goalAmount: 2000000,
          raisedAmount: 70000,
          onDonateNowTaped: (category) {
            widget.openDonateTab();
          },
        ),

        Padding(
          padding: const .only(left: 15),
          child: Text('Latest Stories', style: theme.textTheme.bodyLarge),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: StreamBuilder(
            stream: FirestoreHelper.getAllPosts(),
            builder: (ctx, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                if (kDebugMode) {
                  print("Error fetching posts:: ${snapshot.error}");
                }
              }
              return ListView.builder(
                key: const ValueKey('posts'),
                scrollDirection: .vertical,
                padding: const .all(10),
                itemCount: snapshot.data?.length,
                itemBuilder: (ctx, ind) => StoryItem(
                  postModel: snapshot.data![ind],
                  onLikeClicked: likePost,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

