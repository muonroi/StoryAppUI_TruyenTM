import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/Models/Accounts/models.account.signup.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.images.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';

class UserInfo extends StatefulWidget {
  final AccountInfo userInfo;
  const UserInfo({super.key, required this.userInfo});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorDefaults.lightAppColor,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(L(ViCode.myAccountTextInfo.toString()),
                  style: FontsDefault.h4),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 70)
                      .width,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 70)
                      .height,
                  child: CachedNetworkImage(
                    imageUrl: widget.userInfo.imageLink ??
                        "https://t3.ftcdn.net/jpg/02/09/37/00/240_F_209370065_JLXhrc5inEmGl52SyvSPeVB23hB6IjrR.jpg",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.userInfo.username!,
                  style: FontsDefault.h5,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(formatValueNumber(widget.userInfo.coin!),
                                  style: FontsDefault.h5),
                              SizedBox(
                                width: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectWidth: 120)
                                    .width,
                                height: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectHeight: 25)
                                    .height,
                                child: Text(
                                  L(ViCode.myAccountCoinTextInfo.toString()),
                                  style: FontsDefault.h5,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '|',
                            style: FontsDefault.h4
                                .copyWith(fontWeight: FontWeight.w300),
                          ),
                          Column(
                            children: [
                              Text(
                                widget.userInfo.totalStoriesBought!.toString(),
                                style: FontsDefault.h5,
                              ),
                              SizedBox(
                                width: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectWidth: 120)
                                    .width,
                                height: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectHeight: 25)
                                    .height,
                                child: Text(
                                  L(ViCode.storiesBoughtTextInfo.toString()),
                                  style: FontsDefault.h5,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SettingItems(
                        text: L(ViCode.myAccountPremiumTextInfo.toString()),
                        image: ImageDefault.crown2x),
                    SettingItems(
                        text: L(ViCode.myAccountGiftCodeTextInfo.toString()),
                        image: ImageDefault.gift2x),
                    SettingItems(
                        text: L(ViCode.myAccountPopupTextInfo.toString()),
                        image: ImageDefault.coin2x),
                    SettingItems(
                        text:
                            L(ViCode.myAccountContactAdminTextInfo.toString()),
                        image: ImageDefault.contact2x),
                    SettingItems(
                        text: L(ViCode.myAccountDetailTextInfo.toString()),
                        image: ImageDefault.user2x),
                    SettingItems(
                        text: L(ViCode.myAccountSettingTextInfo.toString()),
                        image: ImageDefault.gear2x),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SettingItems extends StatelessWidget {
  final String text;
  final String image;
  const SettingItems({super.key, required this.text, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: TextButton(
          onPressed: () {},
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: ColorDefaults.secondMainColor,
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 20)
                        .width,
                    height: MainSetting.getPercentageOfDevice(context,
                            expectHeight: 20)
                        .height,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 200)
                      .width,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 25)
                      .height,
                  child: Text(
                    text,
                    style: FontsDefault.h5,
                  ),
                ),
                SizedBox(
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 25)
                      .width,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 25)
                      .height,
                  child: Text(
                    '>',
                    style: FontsDefault.h5,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
