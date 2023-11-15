import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdMobService {
  Future<InitializationStatus> initializations;

  AdMobService(this.initializations);

  String get bannerAdUnitId => Platform.isAndroid
      ? "ca-app-pub-7594358837893425/8777803444"
      : "ca-app-pub-7594358837893425/7003603062";

  BannerAdListener get adListener => _adListener;
  final BannerAdListener _adListener = BannerAdListener(
    onAdLoaded: (Ad ad) => debugPrint('Ad loaded: ${ad.adUnitId}.'),
    onAdClosed: (Ad ad) {
      ad.dispose();
      debugPrint('Ad closed: ${ad.adUnitId}.');
    },
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      debugPrint('Ad failed to load: : ${ad.adUnitId}, $error');
    },
    onAdOpened: (Ad ad) => debugPrint('Ad opened: ${ad.adUnitId}.'),
    onAdImpression: (Ad ad) => debugPrint('Ad impression: ${ad.adUnitId}.'),
  );
}
