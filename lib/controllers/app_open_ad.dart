import 'package:google_mobile_ads/google_mobile_ads.dart';

class AppOpenAdManager {
  static const String adUnitId = 'ca-app-pub-8664324039776629/6331020652';
  static AppOpenAd? _appOpenAd;
  static bool _isShowingAd = false;
  static bool _adLoaded = false; // To track if an ad is loaded

  static void loadAppOpenAd() {
    if (_isShowingAd || _appOpenAd != null) return;

    AppOpenAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: AppOpenAdLoadCallback(
        onAdLoaded: (ad) {
          _appOpenAd = ad;
          _adLoaded = true;
          _showAppOpenAd();
        },
        onAdFailedToLoad: (error) {
          print('Failed to load an app open ad: ${error.message}');
          _appOpenAd = null;
          _adLoaded = false;
        },
      ),
    );
  }

  static void _showAppOpenAd() {
    if (_appOpenAd != null && !_isShowingAd) {
      _appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (ad) {
          _isShowingAd = true;
        },
        onAdDismissedFullScreenContent: (ad) {
          _isShowingAd = false;
          ad.dispose();
          _appOpenAd = null;
          _adLoaded = false; // Reset the flag when the ad is dismissed
        },
        onAdFailedToShowFullScreenContent: (ad, error) {
          print('Failed to show app open ad: $error');
          _isShowingAd = false;
          ad.dispose();
          _appOpenAd = null;
          _adLoaded = false; // Reset the flag if ad fails to show
        },
      );
      _appOpenAd!.show();
    }
  }

  static void showAdIfAvailable() {
    if (_adLoaded && !_isShowingAd) {
      _showAppOpenAd();
    }
  }
}
