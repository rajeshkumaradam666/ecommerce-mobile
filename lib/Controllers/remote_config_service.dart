import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: Duration(seconds: 10),
      minimumFetchInterval: Duration(seconds: 1),
    ));

    try {
      await _remoteConfig.fetchAndActivate();
    } catch (e) {
      print("Failed to fetch remote config: $e");
    }
  }

  bool get showDiscountPrice =>
      _remoteConfig.getBool('showDiscountPrice');
}
