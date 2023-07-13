import 'package:flutter/material.dart';
import 'package:taxi/Pages/LaddingPages/pages.ladding_page.accept_location.dart';
import 'package:taxi/Settings/settings.fonts.dart';
import '../../Models/PreviewDto/models.account.previewdto.preview_ladding.dart';
import '../../Settings/settings.colors.dart';
import '../../Settings/settings.images.dart';
import '../../Widget/Button/button.widget.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  int _currentIndex = 0;
  late Size _screenCurrentSize;
  List<PreviewLadding> previewData = [];
  @override
  void initState() {
    previewData.add(PreviewLadding(
        title: "Accept a job",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        imgPath: ImageDefault.listviewLadding1_2x));
    previewData.add(PreviewLadding(
        title: "Tracking Realtime",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        imgPath: ImageDefault.listviewLadding2_2x));
    previewData.add(PreviewLadding(
        title: "Earn Money",
        description:
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry.",
        imgPath: ImageDefault.listviewLadding3_2x));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int lengthPageView = previewData.length;
    _screenCurrentSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ColorDefaults.mainColor,
      body: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: PageView.builder(
              onPageChanged: (index) => {
                    setState(() {
                      _currentIndex = index;
                    })
                  },
              itemCount: lengthPageView,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        '${previewData[index].title}',
                        textAlign: TextAlign.center,
                        style: FontsDefault.h3,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: Text('${previewData[index].description}',
                          style: FontsDefault.h5, textAlign: TextAlign.center),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: Image.asset('${previewData[index].imgPath}'),
                    ),
                    Container(
                      height: _screenCurrentSize.height * 1 / 50,
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: lengthPageView,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return ButtonWidget.buttonDisplayCurrentPage(
                              _screenCurrentSize, index == _currentIndex);
                        },
                      ),
                    )
                  ],
                );
              }),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: _screenCurrentSize.width * 1 / 4,
            vertical: _screenCurrentSize.height * 1 / 50),
        child: ButtonWidget.buttonNavigatorNextPreviewLanding(
            context, const AcceptLocationPage()),
      ),
    );
  }
}
