import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/core/authorization/enums/key.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.sign_in.dart';
import 'package:muonroi/features/homes/presentation/pages/page.controller.main.dart';
import 'package:muonroi/features/story/bloc/user/stories_for_user_bloc.dart';
import 'package:muonroi/features/story/data/repositories/story.repository.dart';
import 'package:muonroi/features/story/settings/enums/enum.story.user.dart';
import 'package:muonroi/shared/settings/setting.images.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class LaddingPage extends StatefulWidget {
  const LaddingPage({super.key});

  @override
  State<LaddingPage> createState() => _LaddingPageState();
}

class _LaddingPageState extends State<LaddingPage> {
  @override
  void initState() {
    _uid = null;
    _storiesForUserBloc = StoriesForUserBloc(
        pageIndex: 1, pageSize: 20, storyForUserType: StoryForUserType.recent);
    _storiesForUserBloc.add(const StoriesForUserList(true, isPrevious: false));
    _storyRepository = StoryRepository();
    super.initState();
    _initData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _initData() async {
    var accessToken = userBox.get(KeyToken.accessToken.name) == null;
    if (accessToken && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (builder) => const SignInPage()));
      });
    }
    var storiesResult = await _storyRepository.getStoryForUser(0, 1, 20);
    var storiesItem = storiesResult.result.items;
    // #region init story for user
    for (int index = 0; index < storiesItem.length; index++) {
      if (chapterBox.get("story-${storiesItem[index].id}-current-chapter-id") ==
          null) {
        chapterBox.put("story-${storiesItem[index].id}-current-chapter-id",
            storiesItem[index].chapterLatestId);
      }
      if (chapterBox.get("story-${storiesItem[index].id}-current-page-index") ==
          null) {
        chapterBox.put(
            "story-${storiesItem[index].id}-current-page-index",
            storiesItem[index].pageCurrentIndex == 0
                ? 1
                : storiesItem[index].pageCurrentIndex);
      }
      if (chapterBox
              .get("story-${storiesItem[index].id}-current-chapter-index") ==
          null) {
        chapterBox.put("story-${storiesItem[index].id}-current-chapter-index",
            storiesItem[index].currentIndex);
      }
      if (chapterBox.get("story-${storiesItem[index].id}-current-chapter") ==
          null) {
        chapterBox.put("story-${storiesItem[index].id}-current-chapter",
            storiesItem[index].numberOfChapter);
      }

      if (chapterBox.get("scrollPosition-${storiesItem[index].id}") == null) {
        chapterBox.put("scrollPosition-${storiesItem[index].id}",
            storiesItem[index].chapterLatestLocation);
      }
    }

    // #endregion
    var method = userBox.get("MethodLogin");
    _accountResult = accountSignInFromJson(userBox.get('userLogin')!).result;

    switch (method) {
      case "system":
        if (mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (builder) =>
                      HomePage(accountResult: _accountResult!)));
        }
        break;
      case "google":
        final FirebaseAuth auth = FirebaseAuth.instance;
        var userInfo = auth.currentUser;
        if (userInfo != null) {
          var accountRepository = AccountRepository();
          _uid = userInfo.uid;
          var accountInfo = await accountRepository.signIn(
            userInfo.email!,
            "${userInfo.uid}12345678Az*",
            _uid,
          );

          if (accountInfo.result == null && context.mounted) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (builder) => const SignInPage()));
          }
          userBox.put(
            KeyToken.accessToken.name,
            accountInfo.result!.jwtToken,
          );
          userBox.put(
            KeyToken.refreshToken.name,
            accountInfo.result!.refreshToken,
          );
          userBox.put(
            'userLogin',
            accountSignInToJson(accountInfo),
          );
          _accountResult =
              accountSignInFromJson(userBox.get('userLogin')!).result;
          if (mounted) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (builder) =>
                        HomePage(accountResult: _accountResult!)));
          }
        }
        break;
    }
  }

  late String? _uid;
  late AccountResult? _accountResult;
  late StoriesForUserBloc _storiesForUserBloc;
  late StoryRepository _storyRepository;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: Image.asset(CustomImages.laddingLogo))
        ],
      ),
    ));
  }
}
