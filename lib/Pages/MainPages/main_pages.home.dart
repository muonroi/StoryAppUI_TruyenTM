import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taxi/Settings/settings.colors.dart';
import 'package:taxi/Settings/settings.fonts.dart';
import 'package:taxi/Settings/settings.language_code.vi..dart';
import '../../Settings/settings.main.dart';
import '../../Widget/Button/widget.button.search.dart';
import '../../Widget/Static/widget.static.banner.dart';
import '../../Widget/Static/widget.static.categories.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: ColorDefaults.mainColor,
          fontFamily: FontsDefault.inter),
      home: const Homebody(),
    );
  }
}

class Homebody extends StatefulWidget {
  const Homebody({super.key});

  @override
  State<Homebody> createState() => _HomebodyState();
}

class _HomebodyState extends State<Homebody> {
  late TextEditingController _searchController;
  late PageController _pageEditorController;
  bool _isShowClearText = false;
  late List<Widget> imageList = [
    SizedBox(
        width: 101.2,
        height: 150.71,
        child: Image.asset('assets/images/2x/image_1.png', fit: BoxFit.cover)),
    SizedBox(
        width: 101.2,
        height: 150.71,
        child: Image.asset('assets/images/2x/image_2.png', fit: BoxFit.cover)),
    SizedBox(
        width: 101.2,
        height: 150.71,
        child: Image.asset('assets/images/2x/image_3.png', fit: BoxFit.cover)),
    SizedBox(
        width: 101.2,
        height: 150.71,
        child: Image.asset('assets/images/2x/image_4.png', fit: BoxFit.cover)),
    SizedBox(
        width: 101.2,
        height: 150.71,
        child: Image.asset('assets/images/2x/image_5.png', fit: BoxFit.cover)),
  ];
  @override
  void initState() {
    _searchController = TextEditingController();
    _pageEditorController = PageController(viewportFraction: 0.9);
    super.initState();
  }

  @override
  void dispose() {
    _pageEditorController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onChangedSearch(String textInput) {
    setState(() {
      _isShowClearText = textInput.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorDefaults.lightAppColor,
      appBar: AppBar(
        leading: const Icon(Icons.abc),
        backgroundColor: ColorDefaults.lightAppColor,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.chat_outlined,
                  color: ColorDefaults.thirdMainColor)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none,
                  color: ColorDefaults.thirdMainColor)),
        ],
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: ((context, index) {
          return Column(
            children: [
              SearchContainer(
                  searchController: _searchController,
                  onChanged: _onChangedSearch,
                  isShowClearText: _isShowClearText),
              const BannerHomePage(),
              const CategoriesStr(),
              GroupCategory(
                  titleText: L(ViCode.editorChoiceTextInfo.toString()),
                  nextRoute: const HomePage()),
              SizedBox(
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 150)
                    .height,
                child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    controller: _pageEditorController,
                    itemBuilder: (context, index) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: imageList[index]),
                          )
                        ],
                      );
                    }),
              ),
              GroupCategory(
                  titleText: L(ViCode.newStoriesTextInfo.toString()),
                  nextRoute: const HomePage()),
              SizedBox(
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 347.3)
                    .height,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Vertically center the column
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Horizontally center the column
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imageList[0],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imageList[1],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imageList[2],
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment
                          .spaceEvenly, // Center the elements horizontally
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imageList[0],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imageList[1],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: imageList[2],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}

class GroupCategory extends StatelessWidget {
  final String titleText;
  final Widget nextRoute;
  const GroupCategory(
      {super.key, required this.titleText, required this.nextRoute});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            titleText,
            style: FontsDefault.h5.copyWith(fontWeight: FontWeight.w700),
          ),
          RichText(
              text: TextSpan(
                  text: L(
                    ViCode.viewAllTextInfo.toString(),
                  ),
                  style:
                      FontsDefault.h5.copyWith(color: ColorDefaults.mainColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => nextRoute));
                    }))
        ]),
      ),
    );
  }
}
