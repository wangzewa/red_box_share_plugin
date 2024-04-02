import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'red_book_share_plugin_platform_interface.dart';

/// An implementation of [RedBookSharePluginPlatform] that uses method channels.
class MethodChannelRedBookSharePlugin extends RedBookSharePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('red_book_share_plugin');

  @override
  Future<bool?> init({required String appKey,required String universalLink}) async{
    final data = await methodChannel.invokeMethod('init',{'appKey':appKey,'universalLink':universalLink});
    return data;
  }

  @override
  Future<int?> judgeShare() async{
    final data = await methodChannel.invokeMethod('judgeShare');
    return data;
  }

  @override
  Future<bool?> share({
    required String title,
    required String des,
    required String url,
  }) async{
    final data = await methodChannel.invokeMethod('redShare',{'title':title,'des':des,'url':url});
    return data;
  }

  @override
  Future<bool?> shareVideo({
    required String title,
    required String des,
    required String url,
    required String poster,
  }) async{
    final data = await methodChannel.invokeMethod('redShareVideo',{'title':title,'des':des,'url':url,'poster':poster});
    return data;
  }
}
