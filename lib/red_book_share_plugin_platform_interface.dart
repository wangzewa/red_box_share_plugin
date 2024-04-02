import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'red_book_share_plugin_method_channel.dart';

abstract class RedBookSharePluginPlatform extends PlatformInterface {
  /// Constructs a RedBookSharePluginPlatform.
  RedBookSharePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static RedBookSharePluginPlatform _instance = MethodChannelRedBookSharePlugin();

  /// The default instance of [RedBookSharePluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelRedBookSharePlugin].
  static RedBookSharePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [RedBookSharePluginPlatform] when
  /// they register themselves.
  static set instance(RedBookSharePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> init({required String appKey,required String universalLink}) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<int?> judgeShare() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<bool?> share({
    required String title,
    required String des,
    required String url,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
  Future<bool?> shareVideo({
    required String title,
    required String des,
    required String url,
    required String poster,
  }) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
