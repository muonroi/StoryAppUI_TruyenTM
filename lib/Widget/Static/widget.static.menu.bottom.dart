import 'package:flutter/material.dart';
import 'package:taxi/Pages/MainPages/main_pages.home.dart';

import '../../Settings/settings.colors.dart';
import '../../Settings/settings.images.dart';
import '../../Settings/settings.language_code.vi..dart';
import '../../Settings/settings.main.dart';

class DockerCenterBottomAppBar extends StatefulWidget {
  final FloatingActionButtonLocation fabLocation;
  static final List<FloatingActionButtonLocation> centerLocations =
      <FloatingActionButtonLocation>[
    FloatingActionButtonLocation.centerDocked,
    FloatingActionButtonLocation.centerFloat,
  ];
  const DockerCenterBottomAppBar(
      {super.key, this.fabLocation = FloatingActionButtonLocation.endDocked});

  @override
  State<DockerCenterBottomAppBar> createState() =>
      _DockerCenterBottomAppBarState();
}

class _DockerCenterBottomAppBarState extends State<DockerCenterBottomAppBar> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: ColorDefaults.lightAppColor, boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          blurRadius: 15.0,
          spreadRadius: 5.0,
          offset: const Offset(
              0, -3), // Offset to make the shadow appear below the BottomAppBar
        ),
      ]),
      child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          color: ColorDefaults.lightAppColor,
          child: IconTheme(
              data: IconThemeData(color: Theme.of(context).colorScheme.primary),
              child: Row(
                children: <Widget>[
                  IconButton(
                      tooltip: L(ViCode.homePageTextInfo.toString()),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                      icon: Icon(Icons.home,
                          color: _currentIndex == 1
                              ? ColorDefaults.mainColor
                              : ColorDefaults.borderButtonPreviewPage)),
                  IconButton(
                    tooltip: L(ViCode.bookCaseTextInfo.toString()),
                    onPressed: () {
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    icon: Image.asset(ImageDefault.bookBookmark2x,
                        color: _currentIndex == 2
                            ? ColorDefaults.mainColor
                            : ColorDefaults.borderButtonPreviewPage),
                  ),
                  if (DockerCenterBottomAppBar.centerLocations
                      .contains(widget.fabLocation))
                    const Spacer(),
                  IconButton(
                    tooltip: L(ViCode.freeStoriesTextInfo.toString()),
                    onPressed: () {
                      setState(() {
                        _currentIndex = 3;
                      });
                    },
                    icon: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            _currentIndex == 3
                                ? ColorDefaults.mainColor
                                : ColorDefaults.borderButtonPreviewPage,
                            BlendMode.srcIn),
                        child: Image.asset(
                          ImageDefault.freeBook2x,
                          fit: BoxFit.cover,
                        )),
                  ),
                  IconButton(
                      tooltip: L(ViCode.userInfoTextInfo.toString()),
                      onPressed: () {
                        setState(() {
                          _currentIndex = 4;
                        });
                      },
                      icon: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              _currentIndex == 4
                                  ? ColorDefaults.mainColor
                                  : ColorDefaults.borderButtonPreviewPage,
                              BlendMode.srcIn),
                          child: Image.asset(ImageDefault.userInfo2x,
                              fit: BoxFit.cover))),
                ],
              ))),
    );
  }
}
