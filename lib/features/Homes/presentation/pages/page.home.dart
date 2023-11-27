import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/core/services/api_route.dart';
import 'package:muonroi/features/homes/bloc/settings/settings_bloc.dart';
import 'package:muonroi/features/homes/settings/enum/enum.setting.type.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/shared/static/buttons/widget.static.button.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class RenderHomePage extends StatefulWidget {
  const RenderHomePage(
      {super.key,
      required this.scrollLayoutController,
      required this.componentOfHomePage});
  final ScrollController scrollLayoutController;
  final List<Widget> componentOfHomePage;

  @override
  State<RenderHomePage> createState() => _RenderHomePageState();
}

class _RenderHomePageState extends State<RenderHomePage> {
  @override
  void initState() {
    _initPackageInfo();
    _settingsBloc = SettingsBloc(EnumSettingType.news);
    _settingsBloc.add(const GetSettingList());
    super.initState();
  }

  @override
  void dispose() {
    _settingsBloc.close();
    super.dispose();
  }

  Future _initPackageInfo() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _packageInfo = await PackageInfo.fromPlatform();
    _isFirstLoad = _sharedPreferences.getBool('notification') ?? true;
  }

  late SharedPreferences _sharedPreferences;
  late SettingsBloc _settingsBloc;
  late PackageInfo _packageInfo;
  late bool _isFirstLoad;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _settingsBloc,
      child: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {
          const CircularProgressIndicator();
        },
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            if (state is SettingsLoadingState) {
              return Container(
                color: Colors.transparent,
                width: 0,
                height: 0,
              );
            }
            if (state is SettingsLoadedState) {
              var settingInfo = state.settings.result.first;
              var currentVersionApp =
                  settingInfo.settingName == _packageInfo.version;
              var settingName = currentVersionApp &&
                      settingInfo.content.toLowerCase().contains("version")
                  ? ""
                  : settingInfo.settingName;
              var settingContent = currentVersionApp &&
                      settingInfo.content.toLowerCase().contains("version")
                  ? ""
                  : settingInfo.content;
              return Stack(children: [
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: widget.scrollLayoutController,
                    itemCount: widget.componentOfHomePage.length,
                    itemBuilder: ((context, index) {
                      return Column(children: [
                        widget.componentOfHomePage[index],
                      ]);
                    })),
                _isFirstLoad
                    ? Positioned(
                        top: 0,
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: Material(
                          color: const Color.fromARGB(79, 0, 0, 0),
                          child: ConfirmDialog(
                            onNo: () {
                              setState(() {
                                if (!currentVersionApp) {
                                  _isFirstLoad = false;
                                  _sharedPreferences.setBool(
                                      'notification', true);
                                } else {
                                  _isFirstLoad = false;
                                  _sharedPreferences.setBool(
                                      'notification', false);
                                }
                              });
                            },
                            title: settingName != ""
                                ? settingName
                                : L(
                                    context,
                                    LanguageCodes.notificationTextInfo
                                        .toString()),
                            content: settingContent != ""
                                ? settingContent
                                : L(
                                    context,
                                    LanguageCodes.firstInfoTrialTextInfo
                                        .toString()),
                            onYes: () {
                              if (settingInfo.content
                                      .toLowerCase()
                                      .contains("version") &&
                                  !currentVersionApp) {
                                launchUrl(Uri.parse(ApiNetwork.urlApp));
                              }
                              setState(() {
                                if (!currentVersionApp) {
                                  _isFirstLoad = false;
                                  _sharedPreferences.setBool(
                                      'notification', true);
                                } else {
                                  _isFirstLoad = false;
                                  _sharedPreferences.setBool(
                                      'notification', false);
                                }
                              });
                            },
                          ),
                        ))
                    : Container(
                        color: Colors.transparent,
                        width: 0,
                        height: 0,
                      )
              ]);
            }
            return Container(
              color: Colors.transparent,
              width: 0,
              height: 0,
            );
          },
        ),
      ),
    );
  }
}
