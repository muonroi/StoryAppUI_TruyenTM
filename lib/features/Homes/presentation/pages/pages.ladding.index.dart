import 'package:flutter/material.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signin.dart';
import 'package:muonroi/features/homes/presentation/pages/controller.main.dart';
import 'package:muonroi/shared/settings/settings.images.dart';

class IndexPage extends StatefulWidget {
  final AccountResult accountResult;
  const IndexPage({super.key, required this.accountResult});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _homePage(context, widget.accountResult));
  }
}

Widget _homePage(BuildContext context, AccountResult accountResult) {
  return MainPage(
    accountResult: accountResult,
  );
}

class LoadingApp extends StatelessWidget {
  final AccountResult accountResult;
  const LoadingApp({Key? key, required this.accountResult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const HomeLoading();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => IndexPage(
                    accountResult: accountResult,
                  ),
                ),
              );
            });
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class HomeLoading extends StatelessWidget {
  const HomeLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: Image.asset(CustomImages.laddingLogo)),
        ],
      ),
    );
  }
}
