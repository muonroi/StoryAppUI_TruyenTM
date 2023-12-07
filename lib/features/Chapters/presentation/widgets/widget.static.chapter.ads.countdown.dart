import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.count.time.ads.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class ButtonDisplayOrHideAds extends StatefulWidget {
  final bool isCountDownComplete;
  final int second;
  final ScrollController scrollAdsController;
  final bool isContainerVisible;
  final double heightBottomContainer;
  final double heightAdsContainer;
  final bool isDisplay;
  final Function(double) heightBottomContainerFunction;
  final Function(double) heightBottomAdsContainerFunction;
  final Function(bool) isVisibleContainerFunction;
  final Function(ScrollController) setNewScrollControllerFunction;
  final Function() setIsCountdownCompleteFunction;
  const ButtonDisplayOrHideAds(
      {super.key,
      required this.isCountDownComplete,
      required this.scrollAdsController,
      required this.isContainerVisible,
      required this.heightBottomContainer,
      required this.heightAdsContainer,
      required this.isDisplay,
      required this.heightBottomContainerFunction,
      required this.heightBottomAdsContainerFunction,
      required this.second,
      required this.setIsCountdownCompleteFunction,
      required this.isVisibleContainerFunction,
      required this.setNewScrollControllerFunction});

  @override
  State<ButtonDisplayOrHideAds> createState() => _ButtonDisplayOrHideAdsState();
}

class _ButtonDisplayOrHideAdsState extends State<ButtonDisplayOrHideAds> {
  @override
  void initState() {
    _heightBottomContainer = widget.heightBottomContainer;
    _heightAdsContainer = widget.heightAdsContainer;
    _isContainerVisible = widget.isContainerVisible;
    _scrollAdsController = widget.scrollAdsController;
    _second = widget.second;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ButtonDisplayOrHideAds oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _second = widget.second;
      _isContainerVisible = widget.isContainerVisible;
      _heightBottomContainer = widget.heightAdsContainer;
      _heightAdsContainer = widget.heightAdsContainer;
      _scrollAdsController = widget.scrollAdsController;
    });
  }

  late double _heightBottomContainer;
  late double _heightAdsContainer;
  late bool _isContainerVisible;
  late ScrollController _scrollAdsController;
  late int _second;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MainSetting.getPercentageOfDevice(context, expectWidth: 370).width,
      color: Colors.transparent,
      margin: const EdgeInsets.only(bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(
          //       horizontal: 12.0),
          //   child: Container(
          //       padding:
          //           const EdgeInsets.all(4.0),
          //       decoration: BoxDecoration(
          //           borderRadius:
          //               BorderRadius.circular(
          //                   30.0),
          //           color: themeMode(
          //               context,
          //               ColorCode
          //                   .textColor.name)),
          //       child: const BuyPremium()),
          // ),
          Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: widget.isCountDownComplete
                  ? SizedBox(
                      width: MainSetting.getPercentageOfDevice(context,
                              expectWidth: 20)
                          .width,
                      height: MainSetting.getPercentageOfDevice(context,
                              expectHeight: 18)
                          .height,
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (_scrollAdsController.hasClients &&
                                  !_isContainerVisible) {
                                _heightBottomContainer =
                                    MainSetting.getPercentageOfDevice(context,
                                            expectHeight: 26)
                                        .height!;
                                _heightAdsContainer =
                                    MainSetting.getPercentageOfDevice(context,
                                            expectHeight: 0)
                                        .height!;
                                _scrollAdsController.animateTo(
                                  0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                                _isContainerVisible = true;
                                widget.heightBottomAdsContainerFunction(
                                    _heightAdsContainer);
                                widget.heightBottomContainerFunction(
                                    _heightBottomContainer);
                                widget.isVisibleContainerFunction(
                                    _isContainerVisible);
                                widget.setNewScrollControllerFunction(
                                    _scrollAdsController);
                              } else if (_scrollAdsController.hasClients &&
                                  _isContainerVisible) {
                                _heightBottomContainer =
                                    MainSetting.getPercentageOfDevice(context,
                                            expectHeight: 100)
                                        .height!;
                                _heightAdsContainer =
                                    MainSetting.getPercentageOfDevice(context,
                                            expectHeight: 70)
                                        .height!;
                                _scrollAdsController.animateTo(
                                  78,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                                _isContainerVisible = false;
                                widget.heightBottomAdsContainerFunction(
                                    _heightAdsContainer);
                                widget.heightBottomContainerFunction(
                                    _heightBottomContainer);
                                widget.isVisibleContainerFunction(
                                    _isContainerVisible);
                                widget.setNewScrollControllerFunction(
                                    _scrollAdsController);
                              }
                            });
                          },
                          child: widget.isDisplay
                              ? null
                              : Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: themeMode(
                                          context, ColorCode.modeColor.name)),
                                  child: !_isContainerVisible
                                      ? Icon(
                                          size:
                                              MainSetting.getPercentageOfDevice(
                                                      context,
                                                      expectWidth: 18)
                                                  .width,
                                          Icons.keyboard_arrow_down_outlined,
                                          color: themeMode(context,
                                              ColorCode.textColor.name),
                                        )
                                      : Icon(
                                          size:
                                              MainSetting.getPercentageOfDevice(
                                                      context,
                                                      expectWidth: 18)
                                                  .width,
                                          Icons.keyboard_arrow_up_outlined,
                                          color: themeMode(context,
                                              ColorCode.textColor.name),
                                        ),
                                )),
                    )
                  : CounterTimeAds(
                      second: _second,
                      onSuccess: widget.setIsCountdownCompleteFunction,
                    )),
        ],
      ),
    );
  }
}
